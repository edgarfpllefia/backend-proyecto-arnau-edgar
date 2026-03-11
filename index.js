require('dotenv').config();
const express = require('express');
const cors = require('cors');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Rutas
app.use('/api/auth', require('./routes/auth'));
app.use('/api/usuarios', require('./routes/usuarios'));
app.use('/api/modulos', require('./routes/modulos'));
app.use('/api/estudiantes', require('./routes/estudiantes'));
app.use('/api/tareas', require('./routes/tareas'));

// Ruta raíz
app.get('/', (req, res) => {
    res.json({ mensaje: 'API funcionando correctamente' });
});

// Iniciar servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor corriendo en puerto ${PORT}`);
});