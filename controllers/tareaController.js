const supabase = require('../config/db');

// Mapeo estados BD <-> Frontend
const estadoBdToFront = {
    'en progreso': 'en-progreso',
    'pendiente': 'pendiente',
    'completado': 'completada'
};

const estadoFrontToBd = {
    'en-progreso': 'en progreso',
    'pendiente': 'pendiente',
    'completada': 'completado'
};

const transformarTarea = (t) => ({
    id: t.id.toString(),
    moduloId: t.modulo_id.toString(),
    estudianteId: t.estudiante_id,
    titulo: t.titulo,
    descripcion: t.descripcion,
    fechaCreacion: t.created_at,
    fechaVencimiento: t.fecha_entrega,
    estado: estadoBdToFront[t.estado] || t.estado,
    nota: t.nota,
    prioridad: t.prioridad
});

// GET /api/estudiantes/:estudianteId/modulos/:moduloId/tareas
const getTareas = async (req, res) => {
    const { estado, desde, hasta, orden } = req.query;

    let query = supabase
        .from('tareas')
        .select('*')
        .eq('estudiante_id', req.params.estudianteId)
        .eq('modulo_id', req.params.moduloId);

    if (estado) {
        const estadoDb = estadoFrontToBd[estado] || estado;
        query = query.eq('estado', estadoDb);
    }
    if (desde) query = query.gte('fecha_entrega', desde);
    if (hasta) query = query.lte('fecha_entrega', hasta);

    if (orden === 'fecha_asc') query = query.order('fecha_entrega', { ascending: true });
    else if (orden === 'fecha_desc') query = query.order('fecha_entrega', { ascending: false });
    else query = query.order('created_at', { ascending: false });

    const { data, error } = await query;

    if (error) return res.status(400).json({ error: error.message });

    res.json(data.map(transformarTarea));
};

// GET /api/tareas/:id
const getTarea = async (req, res) => {
    const { data, error } = await supabase
        .from('tareas')
        .select('*')
        .eq('id', req.params.id)
        .single();

    if (error) return res.status(404).json({ error: 'Tarea no encontrada' });

    res.json(transformarTarea(data));
};

// POST /api/estudiantes/:estudianteId/modulos/:moduloId/tareas
const createTarea = async (req, res) => {
    const { titulo, descripcion, fechaVencimiento, estado, nota, prioridad } = req.body;

    const { data, error } = await supabase
        .from('tareas')
        .insert({
            estudiante_id: req.params.estudianteId,
            modulo_id: req.params.moduloId,
            titulo,
            descripcion,
            fecha_entrega: fechaVencimiento || null,
            estado: estadoFrontToBd[estado] || estado || 'pendiente',
            nota: nota || null,
            prioridad: prioridad || 'media'
        })
        .select()
        .single();

    if (error) return res.status(400).json({ error: error.message });

    res.status(201).json(transformarTarea(data));
};

// PUT /api/tareas/:id
const updateTarea = async (req, res) => {
    const { titulo, descripcion, fechaVencimiento, estado, nota, prioridad } = req.body;

    const updateData = {};
    if (titulo !== undefined) updateData.titulo = titulo;
    if (descripcion !== undefined) updateData.descripcion = descripcion;
    if (fechaVencimiento !== undefined) updateData.fecha_entrega = fechaVencimiento;
    if (estado !== undefined) updateData.estado = estadoFrontToBd[estado] || estado;
    if (nota !== undefined) updateData.nota = nota;
    if (prioridad !== undefined) updateData.prioridad = prioridad;

    const { data, error } = await supabase
        .from('tareas')
        .update(updateData)
        .eq('id', req.params.id)
        .select()
        .single();

    if (error) return res.status(400).json({ error: error.message });

    res.json(transformarTarea(data));
};

// DELETE /api/tareas/:id
const deleteTarea = async (req, res) => {
    const { error } = await supabase
        .from('tareas')
        .delete()
        .eq('id', req.params.id);

    if (error) return res.status(400).json({ error: error.message });

    res.json({ mensaje: 'Tarea eliminada' });
};

module.exports = { getTareas, getTarea, createTarea, updateTarea, deleteTarea };