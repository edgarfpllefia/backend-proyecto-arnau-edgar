const supabase = require('../config/db');

const transformarModulo = (m) => ({
    id: m.id.toString(),
    nombre: m.nombre,
    ciclo: m.ciclo,
    curso: m.curso,
    codigo: m.codigo,
    horas: m.horas,
    descripcion: m.descripcion
});

// GET /api/modulos
const getModulos = async (req, res) => {
    const { ciclo, curso } = req.query;

    let query = supabase.from('modulos').select('*');

    if (ciclo) query = query.eq('ciclo', ciclo);
    if (curso) query = query.eq('curso', curso);

    const { data, error } = await query;

    if (error) return res.status(400).json({ error: error.message });

    res.json(data.map(transformarModulo));
};

// GET /api/modulos/:id
const getModulo = async (req, res) => {
    const { data, error } = await supabase
        .from('modulos')
        .select('*')
        .eq('id', req.params.id)
        .single();

    if (error) return res.status(404).json({ error: 'Módulo no encontrado' });

    res.json(transformarModulo(data));
};

// POST /api/modulos
const createModulo = async (req, res) => {
    const { nombre, ciclo, curso, codigo, horas, descripcion } = req.body;

    const { data: modulo, error } = await supabase
        .from('modulos')
        .insert({ nombre, ciclo, curso, codigo, horas, descripcion })
        .select()
        .single();

    if (error) return res.status(400).json({ error: error.message });

    // Asignar automáticamente a estudiantes del mismo ciclo y curso
    const { data: estudiantes } = await supabase
        .from('perfiles')
        .select('id')
        .eq('rol', 'estudiante')
        .eq('ciclo', ciclo)
        .eq('curso', curso);

    if (estudiantes && estudiantes.length > 0) {
        const asignaciones = estudiantes.map(e => ({
            estudiante_id: e.id,
            modulo_id: modulo.id,
            estado: 'Cursando'
        }));

        await supabase.from('modulo_estudiante').insert(asignaciones);
    }

    res.status(201).json(transformarModulo(modulo));
};

// PUT /api/modulos/:id
const updateModulo = async (req, res) => {
    const { nombre, ciclo, curso, codigo, horas, descripcion } = req.body;
    const moduloId = req.params.id;

    const { data: moduloActual } = await supabase
        .from('modulos')
        .select('*')
        .eq('id', moduloId)
        .single();

    const { data: modulo, error } = await supabase
        .from('modulos')
        .update({ nombre, ciclo, curso, codigo, horas, descripcion })
        .eq('id', moduloId)
        .select()
        .single();

    if (error) return res.status(400).json({ error: error.message });

    if (moduloActual && (moduloActual.ciclo !== ciclo || moduloActual.curso !== curso)) {
        await supabase.from('modulo_estudiante').delete().eq('modulo_id', moduloId);

        const { data: estudiantes } = await supabase
            .from('perfiles')
            .select('id')
            .eq('rol', 'estudiante')
            .eq('ciclo', ciclo)
            .eq('curso', curso);

        if (estudiantes && estudiantes.length > 0) {
            const asignaciones = estudiantes.map(e => ({
                estudiante_id: e.id,
                modulo_id: moduloId,
                estado: 'Cursando'
            }));

            await supabase.from('modulo_estudiante').insert(asignaciones);
        }
    }

    res.json(transformarModulo(modulo));
};

// DELETE /api/modulos/:id
const deleteModulo = async (req, res) => {
    const { error } = await supabase
        .from('modulos')
        .delete()
        .eq('id', req.params.id);

    if (error) return res.status(400).json({ error: error.message });

    res.json({ mensaje: 'Módulo eliminado' });
};

module.exports = { getModulos, getModulo, createModulo, updateModulo, deleteModulo };