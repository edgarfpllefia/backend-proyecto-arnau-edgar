const supabase = require('../config/db');

// Verifica que el usuario está autenticado
const auth = async (req, res, next) => {
    const token = req.headers.authorization?.split(' ')[1];

    if (!token) {
        return res.status(401).json({ error: 'Token no proporcionado' });
    }

    const { data: { user }, error } = await supabase.auth.getUser(token);

    if (error || !user) {
        return res.status(401).json({ error: 'Token inválido' });
    }

    // Obtener perfil con rol
    const { data: perfil } = await supabase
        .from('perfiles')
        .select('*')
        .eq('id', user.id)
        .single();

    req.user = perfil;
    next();
};

// Verifica que el usuario es admin
const esAdmin = (req, res, next) => {
    if (req.user.rol !== 'admin') {
        return res.status(403).json({ error: 'Acceso denegado. Solo admin.' });
    }
    next();
};

module.exports = { auth, esAdmin };