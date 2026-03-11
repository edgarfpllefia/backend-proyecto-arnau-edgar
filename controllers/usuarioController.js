const supabase = require('../config/db');

// GET /api/usuarios
const getUsuarios = async (req, res) => {
    const { rol, ciclo } = req.query;

    let query = supabase.from('perfiles').select('*');

    if (rol) query = query.eq('rol', rol);
    if (ciclo) query = query.eq('ciclo', ciclo);

    const { data, error } = await query;

    if (error) return res.status(400).json({ error: error.message });

    res.json(data.map(u => ({
        id: u.id,
        nombre: u.nombre,
        email: u.email,
        rol: u.rol,
        ciclo: u.ciclo,
        curso: u.curso
    })));
};

// GET /api/usuarios/:id
const getUsuario = async (req, res) => {
    const { data, error } = await supabase
        .from('perfiles')
        .select('*')
        .eq('id', req.params.id)
        .single();

    if (error) return res.status(404).json({ error: 'Usuario no encontrado' });

    res.json({
        id: data.id,
        nombre: data.nombre,
        email: data.email,
        rol: data.rol,
        ciclo: data.ciclo,
        curso: data.curso
    });
};

// PUT /api/usuarios/:id
const updateUsuario = async (req, res) => {
    const { nombre, email, ciclo, curso, rol } = req.body;

    const { data, error } = await supabase
        .from('perfiles')
        .update({ nombre, email, ciclo, curso, rol })
        .eq('id', req.params.id)
        .select()
        .single();

    if (error) return res.status(400).json({ error: error.message });

    res.json({
        id: data.id,
        nombre: data.nombre,
        email: data.email,
        rol: data.rol,
        ciclo: data.ciclo,
        curso: data.curso
    });
};

// DELETE /api/usuarios/:id
const deleteUsuario = async (req, res) => {
    const { error } = await supabase
        .from('perfiles')
        .delete()
        .eq('id', req.params.id);

    if (error) return res.status(400).json({ error: error.message });

    res.json({ mensaje: 'Usuario eliminado' });
};

module.exports = { getUsuarios, getUsuario, updateUsuario, deleteUsuario };