-- ============================================
-- TABLAS PARA EL PROYECTO
-- Ejecutar en Supabase SQL Editor
-- ============================================

-- Tabla de perfiles (extiende auth.users de Supabase Auth)
CREATE TABLE perfiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT NOT NULL,
    nombre TEXT NOT NULL,
    rol TEXT NOT NULL DEFAULT 'estudiante' CHECK (rol IN ('admin', 'estudiante')),
    ciclo TEXT,
    curso INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tabla de módulos
CREATE TABLE modulos (
    id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    ciclo TEXT NOT NULL,
    curso INTEGER NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tabla intermedia módulo-estudiante
CREATE TABLE modulo_estudiante (
    id SERIAL PRIMARY KEY,
    estudiante_id UUID NOT NULL REFERENCES perfiles(id) ON DELETE CASCADE,
    modulo_id INTEGER NOT NULL REFERENCES modulos(id) ON DELETE CASCADE,
    estado TEXT NOT NULL DEFAULT 'Pendiente' CHECK (estado IN ('Aprobado', 'Cursando', 'No Cursa', 'Pendiente')),
    nota_t1 NUMERIC(4,2),
    nota_t2 NUMERIC(4,2),
    nota_t3 NUMERIC(4,2),
    nota_ordinaria NUMERIC(4,2),
    nota_extraordinaria NUMERIC(4,2),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(estudiante_id, modulo_id)
);

-- Tabla de tareas
CREATE TABLE tareas (
    id SERIAL PRIMARY KEY,
    estudiante_id UUID NOT NULL REFERENCES perfiles(id) ON DELETE CASCADE,
    modulo_id INTEGER NOT NULL REFERENCES modulos(id) ON DELETE CASCADE,
    titulo TEXT NOT NULL,
    descripcion TEXT,
    fecha_entrega DATE,
    estado TEXT NOT NULL DEFAULT 'pendiente' CHECK (estado IN ('en progreso', 'pendiente', 'completado')),
    nota NUMERIC(4,2),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Función para crear perfil automáticamente al registrarse
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.perfiles (id, email, nombre, rol, ciclo, curso)
    VALUES (
        NEW.id,
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'nombre', ''),
        COALESCE(NEW.raw_user_meta_data->>'rol', 'estudiante'),
        NEW.raw_user_meta_data->>'ciclo',
        (NEW.raw_user_meta_data->>'curso')::INTEGER
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger: cuando se registra un usuario, se crea su perfil
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Deshabilitar RLS para que la API con anon key pueda operar
ALTER TABLE perfiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE modulos ENABLE ROW LEVEL SECURITY;
ALTER TABLE modulo_estudiante ENABLE ROW LEVEL SECURITY;
ALTER TABLE tareas ENABLE ROW LEVEL SECURITY;

-- Políticas permisivas (la seguridad la gestiona tu API con middleware)
CREATE POLICY "Acceso completo perfiles" ON perfiles FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Acceso completo modulos" ON modulos FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Acceso completo modulo_estudiante" ON modulo_estudiante FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Acceso completo tareas" ON tareas FOR ALL USING (true) WITH CHECK (true);