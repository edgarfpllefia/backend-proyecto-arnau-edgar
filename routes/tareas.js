const express = require('express');
const router = express.Router();
const { getTarea, updateTarea, deleteTarea } = require('../controllers/tareaController');
const { auth } = require('../middleware/auth');

router.get('/:id', auth, getTarea);
router.put('/:id', auth, updateTarea);
router.delete('/:id', auth, deleteTarea);

module.exports = router;