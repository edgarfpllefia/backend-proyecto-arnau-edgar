-- ============================================
-- DATOS INICIALES: MÓDULOS + ESTUDIANTES
-- Ejecutar en Supabase SQL Editor DESPUÉS de setup.sql
-- ============================================

-- =====================
-- MÓDULOS
-- =====================

-- DAW 1º
INSERT INTO modulos (nombre, ciclo, curso) VALUES
('Bases de Datos', 'DAW', 1),
('Programación', 'DAW', 1),
('Lenguajes de Marcas', 'DAW', 1),
('Entornos de Desarrollo', 'DAW', 1);

-- DAW 2º
INSERT INTO modulos (nombre, ciclo, curso) VALUES
('Desarrollo Web en Entorno Cliente', 'DAW', 2),
('Desarrollo Web en Entorno Servidor', 'DAW', 2),
('Diseño de Interfaces Web', 'DAW', 2),
('Despliegue de Aplicaciones Web', 'DAW', 2);

-- ARI 1º
INSERT INTO modulos (nombre, ciclo, curso) VALUES
('Sistemas Eléctricos y Electrónicos', 'ARI', 1),
('Elementos de Máquinas', 'ARI', 1),
('Diseño de Sistemas de Control', 'ARI', 1),
('Informática Industrial', 'ARI', 1);

-- ARI 2º
INSERT INTO modulos (nombre, ciclo, curso) VALUES
('Sistemas Neumáticos y Oleohidráulicos', 'ARI', 2),
('Robótica Industrial', 'ARI', 2),
('Comunicaciones Industriales', 'ARI', 2);

-- SMR 1º
INSERT INTO modulos (nombre, ciclo, curso) VALUES
('Montaje y Mantenimiento de Equipos', 'SMR', 1),
('Sistemas Operativos Monopuesto', 'SMR', 1),
('Aplicaciones Ofimáticas', 'SMR', 1),
('Redes Locales', 'SMR', 1);

-- SMR 2º
INSERT INTO modulos (nombre, ciclo, curso) VALUES
('Sistemas Operativos en Red', 'SMR', 2),
('Seguridad Informática', 'SMR', 2),
('Servicios en Red', 'SMR', 2);

-- IEA 1º
INSERT INTO modulos (nombre, ciclo, curso) VALUES
('Automatismos Industriales', 'IEA', 1),
('Electrónica', 'IEA', 1),
('Electrotecnia', 'IEA', 1),
('Instalaciones Eléctricas Interiores', 'IEA', 1);

-- IEA 2º
INSERT INTO modulos (nombre, ciclo, curso) VALUES
('Instalaciones de Distribución', 'IEA', 2),
('Instalaciones Domóticas', 'IEA', 2),
('Instalaciones Solares Fotovoltaicas', 'IEA', 2);

-- =====================
-- ESTUDIANTES (via Supabase Auth)
-- =====================
-- Nota: Supabase Auth no permite crear usuarios por SQL directamente.
-- Hay que usar la API. Ejecuta las siguientes funciones desde el Dashboard
-- o usa el endpoint /api/auth/register de tu API para cada uno.
-- 
-- A continuación, inserción DIRECTA en perfiles para tener datos de prueba.
-- IMPORTANTE: Estos usuarios NO tendrán contraseña en auth.users,
-- así que para tener usuarios completos hay que registrarlos por la API.
-- =====================

-- Para crear usuarios reales, usa estos comandos POST desde Postman/Thunder Client:
--
-- POST http://localhost:3000/api/auth/register
-- Body (JSON):
--
-- DAW 1º:
-- { "email": "carlos.garcia@test.com", "password": "Test1234!", "nombre": "Carlos García", "ciclo": "DAW", "curso": 1 }
-- { "email": "laura.martinez@test.com", "password": "Test1234!", "nombre": "Laura Martínez", "ciclo": "DAW", "curso": 1 }
--
-- DAW 2º:
-- { "email": "edgar.bdn@test.com", "password": "Test1234!", "nombre": "Edgar BDN", "ciclo": "DAW", "curso": 2 }
-- { "email": "arnau.lopez@test.com", "password": "Test1234!", "nombre": "Arnau López", "ciclo": "DAW", "curso": 2 }
--
-- ARI 1º:
-- { "email": "marc.soler@test.com", "password": "Test1234!", "nombre": "Marc Soler", "ciclo": "ARI", "curso": 1 }
--
-- ARI 2º:
-- { "email": "paula.vidal@test.com", "password": "Test1234!", "nombre": "Paula Vidal", "ciclo": "ARI", "curso": 2 }
--
-- SMR 1º:
-- { "email": "david.ruiz@test.com", "password": "Test1234!", "nombre": "David Ruiz", "ciclo": "SMR", "curso": 1 }
--
-- SMR 2º:
-- { "email": "marina.font@test.com", "password": "Test1234!", "nombre": "Marina Font", "ciclo": "SMR", "curso": 2 }
--
-- IEA 1º:
-- { "email": "jordi.pla@test.com", "password": "Test1234!", "nombre": "Jordi Pla", "ciclo": "IEA", "curso": 1 }
--
-- IEA 2º:
-- { "email": "ana.torres@test.com", "password": "Test1234!", "nombre": "Ana Torres", "ciclo": "IEA", "curso": 2 }
--
-- ADMIN:
-- Después de registrarlo, cambia su rol a 'admin' manualmente:
-- { "email": "admin@test.com", "password": "Admin1234!", "nombre": "Administrador", "ciclo": null, "curso": null }
-- UPDATE perfiles SET rol = 'admin' WHERE email = 'admin@test.com';