-- ============================================
-- ASIGNAR MÓDULOS A ESTUDIANTES EXISTENTES
-- Y CREAR TAREAS DE EJEMPLO
-- Ejecutar en Supabase SQL Editor
-- ============================================

-- Asignar módulos a cada estudiante según su ciclo y curso
INSERT INTO modulo_estudiante (estudiante_id, modulo_id, estado)
SELECT p.id, m.id, 'Cursando'
FROM perfiles p
JOIN modulos m ON m.ciclo = p.ciclo AND m.curso = p.curso
WHERE p.rol = 'estudiante'
ON CONFLICT (estudiante_id, modulo_id) DO NOTHING;

-- =====================
-- TAREAS DE EJEMPLO
-- =====================

-- Tareas para estudiantes de DAW 1º (Bases de Datos)
INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado, nota)
SELECT p.id, m.id, 'Práctica 1 - SELECT básico', 'Realizar consultas SELECT simples sobre la base de datos de ejemplo', '2026-03-15', 'completado', 7.5
FROM perfiles p, modulos m WHERE p.email = 'carlos.garcia@test.com' AND m.nombre = 'Bases de Datos' AND m.curso = 1;

INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado)
SELECT p.id, m.id, 'Práctica 2 - JOIN', 'Consultas con JOIN entre múltiples tablas', '2026-03-28', 'en progreso'
FROM perfiles p, modulos m WHERE p.email = 'carlos.garcia@test.com' AND m.nombre = 'Bases de Datos' AND m.curso = 1;

INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado)
SELECT p.id, m.id, 'Práctica 3 - Subconsultas', 'Ejercicios con subconsultas y vistas', '2026-04-10', 'pendiente'
FROM perfiles p, modulos m WHERE p.email = 'carlos.garcia@test.com' AND m.nombre = 'Bases de Datos' AND m.curso = 1;

-- Tareas para Carlos en Programación
INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado, nota)
SELECT p.id, m.id, 'Ejercicio Arrays', 'Manipulación de arrays en Java', '2026-03-10', 'completado', 8.0
FROM perfiles p, modulos m WHERE p.email = 'carlos.garcia@test.com' AND m.nombre = 'Programación' AND m.curso = 1;

INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado)
SELECT p.id, m.id, 'Proyecto POO', 'Crear una aplicación con herencia y polimorfismo', '2026-04-20', 'pendiente'
FROM perfiles p, modulos m WHERE p.email = 'carlos.garcia@test.com' AND m.nombre = 'Programación' AND m.curso = 1;

-- Tareas para Laura en Bases de Datos
INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado, nota)
SELECT p.id, m.id, 'Práctica 1 - SELECT básico', 'Realizar consultas SELECT simples', '2026-03-15', 'completado', 9.0
FROM perfiles p, modulos m WHERE p.email = 'laura.martinez@test.com' AND m.nombre = 'Bases de Datos' AND m.curso = 1;

INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado)
SELECT p.id, m.id, 'Práctica 2 - JOIN', 'Consultas con JOIN', '2026-03-28', 'completado'
FROM perfiles p, modulos m WHERE p.email = 'laura.martinez@test.com' AND m.nombre = 'Bases de Datos' AND m.curso = 1;

-- Tareas para Edgar en Desarrollo Web en Entorno Cliente
INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado, nota)
SELECT p.id, m.id, 'Práctica DOM', 'Manipulación del DOM con JavaScript vanilla', '2026-03-12', 'completado', 8.5
FROM perfiles p, modulos m WHERE p.email = 'edgar.bdn@test.com' AND m.nombre = 'Desarrollo Web en Entorno Cliente' AND m.curso = 2;

INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado)
SELECT p.id, m.id, 'Proyecto React', 'Crear una SPA con React y React Router', '2026-04-25', 'en progreso'
FROM perfiles p, modulos m WHERE p.email = 'edgar.bdn@test.com' AND m.nombre = 'Desarrollo Web en Entorno Cliente' AND m.curso = 2;

INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado)
SELECT p.id, m.id, 'Práctica API REST', 'Consumir una API REST desde el frontend', '2026-04-05', 'pendiente'
FROM perfiles p, modulos m WHERE p.email = 'edgar.bdn@test.com' AND m.nombre = 'Desarrollo Web en Entorno Cliente' AND m.curso = 2;

-- Tareas para Edgar en Desarrollo Web en Entorno Servidor
INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado, nota)
SELECT p.id, m.id, 'CRUD con Express', 'Crear un CRUD completo con Express y Supabase', '2026-03-20', 'completado', 9.0
FROM perfiles p, modulos m WHERE p.email = 'edgar.bdn@test.com' AND m.nombre = 'Desarrollo Web en Entorno Servidor' AND m.curso = 2;

INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado)
SELECT p.id, m.id, 'Autenticación JWT', 'Implementar sistema de auth con tokens', '2026-04-15', 'en progreso'
FROM perfiles p, modulos m WHERE p.email = 'edgar.bdn@test.com' AND m.nombre = 'Desarrollo Web en Entorno Servidor' AND m.curso = 2;

-- Tareas para Arnau en Diseño de Interfaces Web
INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado, nota)
SELECT p.id, m.id, 'Maquetación Responsive', 'Crear un layout responsive con Flexbox y Grid', '2026-03-18', 'completado', 7.0
FROM perfiles p, modulos m WHERE p.email = 'arnau.lopez@test.com' AND m.nombre = 'Diseño de Interfaces Web' AND m.curso = 2;

INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado)
SELECT p.id, m.id, 'Prototipo Figma', 'Diseñar un prototipo interactivo en Figma', '2026-04-08', 'pendiente'
FROM perfiles p, modulos m WHERE p.email = 'arnau.lopez@test.com' AND m.nombre = 'Diseño de Interfaces Web' AND m.curso = 2;

-- Tareas para Marc (ARI 1º) en Informática Industrial
INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado, nota)
SELECT p.id, m.id, 'Práctica PLC básico', 'Programación básica de un PLC', '2026-03-14', 'completado', 6.5
FROM perfiles p, modulos m WHERE p.email = 'marc.soler@test.com' AND m.nombre = 'Informática Industrial' AND m.curso = 1;

INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado)
SELECT p.id, m.id, 'Proyecto automatización', 'Diseñar un sistema automatizado simple', '2026-04-22', 'pendiente'
FROM perfiles p, modulos m WHERE p.email = 'marc.soler@test.com' AND m.nombre = 'Informática Industrial' AND m.curso = 1;

-- Tareas para Paula (ARI 2º) en Robótica Industrial
INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado)
SELECT p.id, m.id, 'Simulación brazo robótico', 'Simular movimientos de un brazo robótico', '2026-04-01', 'en progreso'
FROM perfiles p, modulos m WHERE p.email = 'paula.vidal@test.com' AND m.nombre = 'Robótica Industrial' AND m.curso = 2;

-- Tareas para David (SMR 1º) en Redes Locales
INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado, nota)
SELECT p.id, m.id, 'Configuración switch', 'Configurar VLANs en un switch Cisco', '2026-03-11', 'completado', 8.0
FROM perfiles p, modulos m WHERE p.email = 'david.ruiz@test.com' AND m.nombre = 'Redes Locales' AND m.curso = 1;

INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado)
SELECT p.id, m.id, 'Cableado estructurado', 'Diseñar el cableado de una oficina', '2026-04-18', 'pendiente'
FROM perfiles p, modulos m WHERE p.email = 'david.ruiz@test.com' AND m.nombre = 'Redes Locales' AND m.curso = 1;

-- Tareas para Marina (SMR 2º) en Seguridad Informática
INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado)
SELECT p.id, m.id, 'Auditoría de seguridad', 'Realizar una auditoría básica de seguridad en red', '2026-04-12', 'en progreso'
FROM perfiles p, modulos m WHERE p.email = 'marina.font@test.com' AND m.nombre = 'Seguridad Informática' AND m.curso = 2;

-- Tareas para Jordi (IEA 1º) en Electrotecnia
INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado, nota)
SELECT p.id, m.id, 'Circuitos serie-paralelo', 'Resolver circuitos mixtos con ley de Ohm', '2026-03-08', 'completado', 7.0
FROM perfiles p, modulos m WHERE p.email = 'jordi.pla@test.com' AND m.nombre = 'Electrotecnia' AND m.curso = 1;

-- Tareas para Ana (IEA 2º) en Instalaciones Domóticas
INSERT INTO tareas (estudiante_id, modulo_id, titulo, descripcion, fecha_entrega, estado)
SELECT p.id, m.id, 'Proyecto domótica KNX', 'Diseñar una instalación domótica con protocolo KNX', '2026-04-30', 'pendiente'
FROM perfiles p, modulos m WHERE p.email = 'ana.torres@test.com' AND m.nombre = 'Instalaciones Domóticas' AND m.curso = 2;