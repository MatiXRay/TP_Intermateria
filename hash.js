// hash.js
const mysql = require('mysql2/promise');
const bcrypt = require('bcryptjs');

(async () => {
    // CONFIG - ajustá si tu conexión es distinta
    const dbConfig = {
        host: 'localhost',
        user: 'root',
        password: '03534530mM',
        database: 'steamdb',
    };

    let connection;
    try {
        connection = await mysql.createConnection(dbConfig);
        console.log('Conectado a la DB.');

        // 1) traer todos los usuarios (id + contrasenia)
        const [rows] = await connection.execute('SELECT id_usuario AS id, contrasenia FROM usuarios');
        console.log(`Encontrados ${rows.length} usuarios.`);

        let updated = 0;
        for (const user of rows) {
            const pass = user.contrasenia || '';

            // Detectar si ya está hasheada (bcrypt hashes empiezan con $2a$ / $2b$ / $2y$)
            if (typeof pass === 'string' && pass.startsWith('$2')) {
                console.log(`id=${user.id} ya tiene hash, se saltea.`);
                continue;
            }

            // Si la contraseña está vacía o null, opcional -> saltear o definir uno temporal
            if (!pass) {
                console.log(`id=${user.id} tiene contraseña vacía - se saltea.`);
                continue;
            }

            // Generar hash
            const hash = await bcrypt.hash(pass, 10);

            // Actualizar DB
            await connection.execute('UPDATE usuarios SET contrasenia = ? WHERE id_usuario = ?', [hash, user.id]);
            console.log(`id=${user.id} - actualizado a bcrypt.`);
            updated++;
        }

        console.log(`Proceso finalizado. Actualizados: ${updated}`);
    } catch (err) {
        console.error('Error:', err);
    } finally {
        if (connection) await connection.end();
        process.exit(0);
    }
})();
