-- ============================================
-- MIGRACIÓN: Añadir campos que necesita el frontend
-- Ejecutar en Supabase SQL Editor
-- ============================================

-- Añadir campos a modulos
ALTER TABLE modulos ADD COLUMN IF NOT EXISTS codigo TEXT;
ALTER TABLE modulos ADD COLUMN IF NOT EXISTS horas INTEGER;
ALTER TABLE modulos ADD COLUMN IF NOT EXISTS descripcion TEXT;

-- Añadir campo prioridad a tareas
ALTER TABLE tareas ADD COLUMN IF NOT EXISTS prioridad TEXT DEFAULT 'media' CHECK (prioridad IN ('alta', 'media', 'baja'));

-- Añadir campo curso a perfiles (para saber si es 1º o 2º)
-- Ya existe, pero asegurar que está

-- Actualizar módulos existentes con códigos y horas del mockData
UPDATE modulos SET codigo = '0483', horas = 192, descripcion = 'Diseño y gestión de bases de datos relacionales' WHERE nombre = 'Bases de Datos' AND ciclo = 'DAW';
UPDATE modulos SET codigo = '0484', horas = 256, descripcion = 'Fundamentos de programación orientada a objetos' WHERE nombre = 'Programación' AND ciclo = 'DAW';
UPDATE modulos SET codigo = '0485', horas = 128, descripcion = 'XML, JSON, HTML y tecnologías de marcado' WHERE nombre = 'Lenguajes de Marcas' AND ciclo = 'DAW';
UPDATE modulos SET codigo = '0487', horas = 96, descripcion = 'IDEs, control de versiones y metodologías ágiles' WHERE nombre = 'Entornos de Desarrollo' AND ciclo = 'DAW';
UPDATE modulos SET codigo = '0373', horas = 140, descripcion = 'JavaScript, frameworks frontend y UX' WHERE nombre = 'Desarrollo Web en Entorno Cliente' AND ciclo = 'DAW';
UPDATE modulos SET codigo = '0374', horas = 180, descripcion = 'PHP, Node.js y desarrollo backend' WHERE nombre = 'Desarrollo Web en Entorno Servidor' AND ciclo = 'DAW';
UPDATE modulos SET codigo = '0376', horas = 120, descripcion = 'CSS, diseño responsive y accesibilidad' WHERE nombre = 'Diseño de Interfaces Web' AND ciclo = 'DAW';
UPDATE modulos SET codigo = '0375', horas = 100, descripcion = 'Servidores web, contenedores y CI/CD' WHERE nombre = 'Despliegue de Aplicaciones Web' AND ciclo = 'DAW';

UPDATE modulos SET codigo = '0963', horas = 160, descripcion = 'Circuitos eléctricos y componentes electrónicos' WHERE nombre = 'Sistemas Eléctricos y Electrónicos' AND ciclo = 'ARI';
UPDATE modulos SET codigo = '0964', horas = 128, descripcion = 'Mecánica aplicada y elementos de transmisión' WHERE nombre = 'Elementos de Máquinas' AND ciclo = 'ARI';
UPDATE modulos SET codigo = '0965', horas = 160, descripcion = 'Automatización de procesos industriales' WHERE nombre = 'Diseño de Sistemas de Control' AND ciclo = 'ARI';
UPDATE modulos SET codigo = '0966', horas = 192, descripcion = 'SCADA, HMI y comunicaciones industriales' WHERE nombre = 'Informática Industrial' AND ciclo = 'ARI';
UPDATE modulos SET codigo = '0967', horas = 105, descripcion = 'Sistemas de potencia fluida' WHERE nombre = 'Sistemas Neumáticos y Oleohidráulicos' AND ciclo = 'ARI';
UPDATE modulos SET codigo = '0968', horas = 147, descripcion = 'Programación y manejo de robots industriales' WHERE nombre = 'Robótica Industrial' AND ciclo = 'ARI';
UPDATE modulos SET codigo = '0969', horas = 84, descripcion = 'Redes industriales y protocolos de comunicación' WHERE nombre = 'Comunicaciones Industriales' AND ciclo = 'ARI';

UPDATE modulos SET codigo = '0221', horas = 224, descripcion = 'Hardware, ensamblaje y diagnóstico de equipos' WHERE nombre = 'Montaje y Mantenimiento de Equipos' AND ciclo = 'SMR';
UPDATE modulos SET codigo = '0222', horas = 192, descripcion = 'Windows, Linux y gestión de usuarios' WHERE nombre = 'Sistemas Operativos Monopuesto' AND ciclo = 'SMR';
UPDATE modulos SET codigo = '0223', horas = 256, descripcion = 'Suite ofimática y herramientas de productividad' WHERE nombre = 'Aplicaciones Ofimáticas' AND ciclo = 'SMR';
UPDATE modulos SET codigo = '0224', horas = 224, descripcion = 'Configuración de redes LAN y cableado estructurado' WHERE nombre = 'Redes Locales' AND ciclo = 'SMR';
UPDATE modulos SET codigo = '0228', horas = 147, descripcion = 'Servidores Windows/Linux y Active Directory' WHERE nombre = 'Sistemas Operativos en Red' AND ciclo = 'SMR';
UPDATE modulos SET codigo = '0229', horas = 105, descripcion = 'Ciberseguridad, firewall y políticas de seguridad' WHERE nombre = 'Seguridad Informática' AND ciclo = 'SMR';
UPDATE modulos SET codigo = '0230', horas = 147, descripcion = 'DNS, DHCP, web y correo electrónico' WHERE nombre = 'Servicios en Red' AND ciclo = 'SMR';

UPDATE modulos SET codigo = '0232', horas = 224, descripcion = 'Automatización con contactores y PLCs' WHERE nombre = 'Automatismos Industriales' AND ciclo = 'IEA';
UPDATE modulos SET codigo = '0233', horas = 128, descripcion = 'Componentes electrónicos y circuitos' WHERE nombre = 'Electrónica' AND ciclo = 'IEA';
UPDATE modulos SET codigo = '0234', horas = 192, descripcion = 'Corriente alterna, trifásica y máquinas eléctricas' WHERE nombre = 'Electrotecnia' AND ciclo = 'IEA';
UPDATE modulos SET codigo = '0235', horas = 256, descripcion = 'Instalaciones de baja tensión según REBT' WHERE nombre = 'Instalaciones Eléctricas Interiores' AND ciclo = 'IEA';
UPDATE modulos SET codigo = '0236', horas = 105, descripcion = 'Redes de distribución eléctrica' WHERE nombre = 'Instalaciones de Distribución' AND ciclo = 'IEA';
UPDATE modulos SET codigo = '0238', horas = 84, descripcion = 'Sistemas KNX y automatización de viviendas' WHERE nombre = 'Instalaciones Domóticas' AND ciclo = 'IEA';
UPDATE modulos SET codigo = '0239', horas = 84, descripcion = 'Energía solar y sistemas fotovoltaicos' WHERE nombre = 'Instalaciones Solares Fotovoltaicas' AND ciclo = 'IEA';