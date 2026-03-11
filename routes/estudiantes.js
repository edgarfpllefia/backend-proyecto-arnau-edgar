const express = require('express');
const router = express.Router();
const { getModulosEstudiante, getModuloEstudiante, updateModuloEstudiante } = require('../controllers/moduloEstudianteController');
const { getTareas, createTarea } = require('../controllers/tareaController');
const { auth } = require('../middleware/auth');

router.get('/:estudianteId/modulos', auth, getModulosEstudiante);
router.get('/:estudianteId/modulos/:moduloId', auth, getModuloEstudiante);
router.put('/:estudianteId/modulos/:moduloId', auth, updateModuloEstudiante);

// Tareas dentro del contexto estudiante/módulo
router.get('/:estudianteId/modulos/:moduloId/tareas', auth, getTareas);
router.post('/:estudianteId/modulos/:moduloId/tareas', auth, createTarea);

module.exports = router;