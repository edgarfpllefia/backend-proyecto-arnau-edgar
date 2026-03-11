const supabase = require('../config/db');

// POST /api/auth/register
const register = async (req, res) => {
    const { email, password, nombre, ciclo, curso } = req.body;

    const { data, error } = await supabase.auth.signUp({
        email,
        password,
        options: {
            data: { nombre, rol: 'estudiante', ciclo, curso }
        }
    });

    if (error) return res.status(400).json({ error: error.message });

    // Asignar módulos automáticamente si es estudiante con ciclo
    if (ciclo) {
        // Si no se especifica curso, asignar todos los módulos del ciclo
        let query = supabase.from('modulos').select('id').eq('ciclo', ciclo);
        if (curso) query = query.eq('curso', curso);

        const { data: modulos } = await query;

        if (modulos && modulos.length > 0) {
            const asignaciones = modulos.map(m => ({
                estudiante_id: data.user.id,
                modulo_id: m.id,
                estado: 'Cursando'
            }));

            await supabase.from('modulo_estudiante').insert(asignaciones);
        }
    }

    res.status(201).json({ mensaje: 'Usuario registrado', usuario: data.user });
};

// POST /api/auth/login
const login = async (req, res) => {
    const { email, password } = req.body;

    const { data, error } = await supabase.auth.signInWithPassword({ email, password });

    if (error) return res.status(400).json({ error: error.message });

    const { data: perfil } = await supabase
        .from('perfiles')
        .select('*')
        .eq('id', data.user.id)
        .single();

    res.json({
        token: data.session.access_token,
        usuario: {
            id: perfil.id,
            nombre: perfil.nombre,
            email: perfil.email,
            rol: perfil.rol === 'admin' ? 'admin' : 'estudiante',
            ciclo: perfil.ciclo,
            curso: perfil.curso
        }
    });
};

// POST /api/auth/logout
const logout = async (req, res) => {
    const token = req.headers.authorization?.split(' ')[1];

    if (!token) return res.status(400).json({ error: 'Token no proporcionado' });

    const { error } = await supabase.auth.signOut(token);

    if (error) return res.status(400).json({ error: error.message });

    res.json({ mensaje: 'Sesión cerrada' });
};

// GET /api/auth/me
const me = async (req, res) => {
    const user = req.user;
    res.json({
        usuario: {
            id: user.id,
            nombre: user.nombre,
            email: user.email,
            rol: user.rol,
            ciclo: user.ciclo,
            curso: user.curso
        }
    });
};

module.exports = { register, login, logout, me };