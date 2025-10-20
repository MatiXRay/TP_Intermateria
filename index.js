require('dotenv').config();
const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const cookieParser = require('cookie-parser');
const path = require("path");
const mongoose = require('mongoose');
const CategoriaMongo = require('./models/CategoriaMongo');


const app = express();
app.use(cors({
    origin: process.env.CLIENT_ORIGIN, // o donde sirvas tus archivos HTML
    credentials: true
}));
app.use(express.json());
app.use(cookieParser());
app.use(express.static(path.join(__dirname, "public")));



// Conexion MongoDB
mongoose.connect(process.env.MONGO_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true
})

    .then(() => console.log("Conectado a MongoDB!"))
    .catch(err => console.error("ERROR al conectar MongoDB :( ", err));


// Conexión MySQL
const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

db.connect(err => {
    if (err) console.error('Error DB:', err);
    else console.log('Conectado a MySQL!');
});

// 🔐 SECRET para JWT (usá variable de entorno en producción)
const JWT_SECRET = process.env.JWT_SECRET;
const TOKEN_EXPIRATION = process.env.TOKEN_EXPIRATION;

// Función para generar token
function generarToken(usuario) {
    return jwt.sign(
        { id: usuario.id, nombre: usuario.nombre },
        JWT_SECRET,
        { expiresIn: TOKEN_EXPIRATION }
    );
}

// Middleware para validar token
function autenticarToken(req, res, next) {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
    if (!token) return res.status(401).json({ mensaje: 'Token requerido' });

    jwt.verify(token, JWT_SECRET, (err, user) => {
        if (err) return res.status(403).json({ mensaje: 'Token inválido o expirado' });
        req.user = user;
        next();
    });
}

// 🟢 LOGIN
app.post('/login', (req, res) => {
    const { nombre, contrasenia } = req.body;
    if (!nombre || !contrasenia)
        return res.status(400).json({ mensaje: 'Faltan datos' });

    const query = 'SELECT * FROM usuarios WHERE nombre = ?';
    db.query(query, [nombre], async (err, results) => {
        if (err) return res.status(500).json({ mensaje: 'Error en la consulta', error: err });
        if (results.length === 0) return res.status(401).json({ mensaje: 'Usuario no encontrado' });

        const usuario = results[0];

        // ⚠️ Si tus contraseñas NO están hasheadas, reemplazá este bloque temporalmente con:
        // if (usuario.contrasenia !== contrasenia) return res.status(401).json({ mensaje: 'Contraseña incorrecta' });
        const contraseniaValida = await bcrypt.compare(contrasenia, usuario.contrasenia);
        if (!contraseniaValida) return res.status(401).json({ mensaje: 'Contraseña incorrecta' });

        const token = generarToken(usuario);
        res.json({ mensaje: 'Login exitoso', token, usuario });
    });
});

// 🧱 ENDPOINTS PROTEGIDOS


// Obtener juegos por categoría desde Mongo
app.get("/juegos/categoria/:nombre", async (req, res) => {
  try {
    const categoria = req.params.nombre;
    const data = await CategoriaMongo.findOne({ categoria });

    if (!data) return res.status(404).json({ mensaje: "Categoría no encontrada" });
    res.json(data.juegos);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});



// Filtrar juegos por precio en MySQL
app.get("/juegos_caros", autenticarToken, (req, res) => {
    db.query("CALL Juegos_Mayores_20()", (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results[0]);
    });
});

app.get("/juegos_baratos", autenticarToken, (req, res) => {
    db.query("CALL Juegos_MenoresIgual_20()", (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results[0]);
    });
});

// 🧨 LOGOUT (solo frontend borra el token, no hace falta en backend simple)
app.post('/logout', (req, res) => {
    res.json({ mensaje: 'Sesión cerrada' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Servidor en http://localhost:${PORT}`));
