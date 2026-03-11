const express = require('express');
const router = express.Router();
const { getModulos, getModulo, createModulo, updateModulo, deleteModulo } = require('../controllers/moduloController');
const { auth, esAdmin } = require('../middleware/auth');

router.get('/', auth, getModulos);
router.get('/:id', auth, getModulo);
router.post('/', auth, esAdmin, createModulo);
router.put('/:id', auth, esAdmin, updateModulo);
router.delete('/:id', auth, esAdmin, deleteModulo);

module.exports = router;