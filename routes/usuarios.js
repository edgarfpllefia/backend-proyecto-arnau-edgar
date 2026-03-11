const express = require('express');
const router = express.Router();
const { getUsuarios, getUsuario, updateUsuario, deleteUsuario } = require('../controllers/usuarioController');
const { auth, esAdmin } = require('../middleware/auth');

router.get('/', auth, esAdmin, getUsuarios);
router.get('/:id', auth, getUsuario);
router.put('/:id', auth, updateUsuario);
router.delete('/:id', auth, esAdmin, deleteUsuario);

module.exports = router;