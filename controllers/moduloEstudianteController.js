const supabase = require('../config/db');

// Mapeo de estados BD <-> Frontend
const estadoBdToFront = {
    'Aprobado': 'aprobado',
    'Cursando': 'cursando',
    'No Cursa': 'no-cursa',
    'Pendiente': 'pendiente'
};

const estadoFrontToBd = {
    'aprobado': 'Aprobado',
    'cursando': 'Cursando',
    'no-cursa': 'No Cursa',
    'pendiente': 'Pendiente'
};

// Transforma un registro de modulo_estudiante al formato del frontend
const transformarModuloEstudiante = (me) => ({
    id: me.id.toString(),
    estudianteId: me.estudiante_id,
    moduloId: me.modulo_id.toString(),
    estado: estadoBdToFront[me.estado] || me.estado,
    notas: {
        trimestre1: me.nota_t1,
        trimestre2: me.nota_t2,
        trimestre3: me.nota_t3,
        ordinaria: me.nota_ordinaria,
        extraordinaria: me.nota_extraordinaria
    },
    // Incluir datos del módulo si vienen en el join
    ...(me.modulos ? {
        nombre: me.modulos.nombre,
        codigo: me.modulos.codigo,
        curso: me.modulos.curso,
        ciclo: me.modulos.ciclo,
        horas: me.modulos.horas,
        descripcion: me.modulos.descripcion
    } : {})
});

// GET /api/estudiantes/:estudianteId/modulos
const getModulosEstudiante = async (req, res) => {
    const { data, error } = await supabase
        .from('modulo_estudiante')
        .select('*, modulos(*)')
        .eq('estudiante_id', req.params.estudianteId);

    if (error) return res.status(400).json({ error: error.message });

    res.json(data.map(transformarModuloEstudiante));
};

// GET /api/estudiantes/:estudianteId/modulos/:moduloId
const getModuloEstudiante = async (req, res) => {
    const { data, error } = await supabase
        .from('modulo_estudiante')
        .select('*, modulos(*)')
        .eq('estudiante_id', req.params.estudianteId)
        .eq('modulo_id', req.params.moduloId)
        .single();

    if (error) return res.status(404).json({ error: 'Módulo del estudiante no encontrado' });

    res.json(transformarModuloEstudiante(data));
};

// PUT /api/estudiantes/:estudianteId/modulos/:moduloId
const updateModuloEstudiante = async (req, res) => {
    const { estado, notas } = req.body;

    const updateData = {};

    if (estado) updateData.estado = estadoFrontToBd[estado] || estado;
    if (notas) {
        if (notas.trimestre1 !== undefined) updateData.nota_t1 = notas.trimestre1;
        if (notas.trimestre2 !== undefined) updateData.nota_t2 = notas.trimestre2;
        if (notas.trimestre3 !== undefined) updateData.nota_t3 = notas.trimestre3;
        if (notas.ordinaria !== undefined) updateData.nota_ordinaria = notas.ordinaria;
        if (notas.extraordinaria !== undefined) updateData.nota_extraordinaria = notas.extraordinaria;
    }

    const { data, error } = await supabase
        .from('modulo_estudiante')
        .update(updateData)
        .eq('estudiante_id', req.params.estudianteId)
        .eq('modulo_id', req.params.moduloId)
        .select('*, modulos(*)')
        .single();

    if (error) return res.status(400).json({ error: error.message });

    res.json(transformarModuloEstudiante(data));
};

module.exports = { getModulosEstudiante, getModuloEstudiante, updateModuloEstudiante };