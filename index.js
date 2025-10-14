const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const cookieParser = require('cookie-parser');
const path = require("path");

const app = express();
app.use(cors({
    origin: 'http://localhost:3000', // o donde sirvas tus archivos HTML
    credentials: true
}));
app.use(express.json());
app.use(cookieParser());
app.use(express.static(path.join(__dirname, "public")));

// Conexión MySQL
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '03534530mM',
    database: 'steamdb'
});

db.connect(err => {
    if (err) console.error('Error DB:', err);
    else console.log('Conectado a MySQL!');
});

// 🔐 SECRET para JWT (usá variable de entorno en producción)
const JWT_SECRET = 'clave_super_secreta_123';
const TOKEN_EXPIRATION = '15m';

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

const PORT = 3000;
app.listen(PORT, () => console.log(`Servidor en http://localhost:${PORT}`));
