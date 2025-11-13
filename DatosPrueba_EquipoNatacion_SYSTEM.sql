-- ==============================================================
-- 🏊 Datos de prueba - EquipoNatacion SOAP
-- Usuario: SYSTEM
-- Base de datos: Oracle 19c
-- ==============================================================
-- Estructura esperada:
--   SYSTEM.EQUIPO_NATACION
--   SYSTEM.MIEMBRO_EQUIPO
-- ==============================================================

-- 🧹 Limpiar datos anteriores
DELETE FROM SYSTEM.MIEMBRO_EQUIPO;
DELETE FROM SYSTEM.EQUIPO_NATACION;
COMMIT;

-- ==============================================================
-- 🚀 Insertar equipos (13 registros)
-- ==============================================================

INSERT INTO SYSTEM.EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, CIUDAD, CANTIDAD_MIEMBROS)
VALUES (1,  'Los Delfines',        'Juan Pérez',       'Bogotá',           3);
INSERT INTO SYSTEM.EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, CIUDAD, CANTIDAD_MIEMBROS)
VALUES (2,  'AquaRockets',         'Lucía Gómez',      'Ciudad de México', 3);
INSERT INTO SYSTEM.EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, CIUDAD, CANTIDAD_MIEMBROS)
VALUES (3,  'Mar Abierto',         'Carlos López',     'Santiago',         3);
INSERT INTO SYSTEM.EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, CIUDAD, CANTIDAD_MIEMBROS)
VALUES (4,  'Tiburones Azules',    'Sofía Torres',     'Buenos Aires',     3);
INSERT INTO SYSTEM.EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, CIUDAD, CANTIDAD_MIEMBROS)
VALUES (5,  'Rayo del Pacífico',   'Andrés Núñez',     'Lima',             3);
INSERT INTO SYSTEM.EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, CIUDAD, CANTIDAD_MIEMBROS)
VALUES (6,  'Coral Team',          'Valentina Ruiz',   'Medellín',         3);
INSERT INTO SYSTEM.EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, CIUDAD, CANTIDAD_MIEMBROS)
VALUES (7,  'Delfines del Norte',  'Mario Vargas',     'Monterrey',        3);
INSERT INTO SYSTEM.EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, CIUDAD, CANTIDAD_MIEMBROS)
VALUES (8,  'Tormenta Marina',     'Camila Ortega',    'Guayaquil',        3);
INSERT INTO SYSTEM.EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, CIUDAD, CANTIDAD_MIEMBROS)
VALUES (9,  'Velocidad Total',     'Raúl Mendoza',     'Montevideo',       3);
INSERT INTO SYSTEM.EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, CIUDAD, CANTIDAD_MIEMBROS)
VALUES (10, 'Olas Doradas',        'Gabriela Luna',    'Caracas',          3);
INSERT INTO SYSTEM.EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, CIUDAD, CANTIDAD_MIEMBROS)
VALUES (11, 'Truenos del Agua',    'Eduardo Silva',    'San José',         3);
INSERT INTO SYSTEM.EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, CIUDAD, CANTIDAD_MIEMBROS)
VALUES (12, 'Náuticos del Sur',    'Laura Mejía',      'Asunción',         3);
INSERT INTO SYSTEM.EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, CIUDAD, CANTIDAD_MIEMBROS)
VALUES (13, 'AquaStars',           'Fernanda Díaz',    'Cali',             3);

COMMIT;

-- ==============================================================
-- 🧍‍♂️ Insertar miembros (39 nadadores, 3 por equipo)
-- ==============================================================

-- Equipo 1
INSERT INTO SYSTEM.MIEMBRO_EQUIPO (NOMBRE_MIEMBRO, EDAD, ESTILO, TIEMPO_MEJOR, ID_EQUIPO)
VALUES ('Camila Torres', 21, '100m Libre', '00:54.2', 1);
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 1, 'Santiago Gómez', 24, '200m Pecho', '02:12.8');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 1, 'Luisa Díaz', 20, '50m Mariposa', '00:26.9');

-- Equipo 2
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 2, 'Javier López', 25, '100m Espalda', '00:55.1');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 2, 'Natalia Rojas', 22, '200m Libre', '02:03.7');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 2, 'Héctor Campos', 26, '400m Combinado', '04:41.5');

-- Equipo 3
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 3, 'Daniel Soto', 19, '100m Pecho', '01:03.9');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 3, 'Mariana Ortiz', 23, '200m Espalda', '02:14.3');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 3, 'Felipe León', 20, '100m Libre', '00:53.7');

-- Equipo 4
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 4, 'Valeria Peña', 22, '50m Espalda', '00:28.5');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 4, 'Andrés Parra', 25, '200m Mariposa', '02:02.2');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 4, 'Juliana Castro', 21, '400m Libre', '04:17.6');

-- Equipo 5
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 5, 'Miguel Herrera', 26, '100m Libre', '00:52.9');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 5, 'Daniela Suárez', 20, '50m Pecho', '00:32.8');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 5, 'Alejandro Cruz', 23, '100m Mariposa', '00:56.4');

-- Equipo 6
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 6, 'Carolina Ramírez', 21, '200m Libre', '02:05.9');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 6, 'Esteban Mora', 24, '100m Espalda', '00:55.7');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 6, 'Laura Niño', 22, '50m Libre', '00:25.4');

-- Equipo 7
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 7, 'José Vega', 27, '200m Pecho', '02:13.1');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 7, 'Tatiana Muñoz', 19, '100m Mariposa', '00:58.3');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 7, 'Felipe Correa', 22, '50m Libre', '00:24.8');

-- Equipo 8
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 8, 'Camilo López', 23, '100m Espalda', '00:56.0');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 8, 'María Quintero', 21, '200m Libre', '02:04.6');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 8, 'Oscar Rivas', 24, '400m Combinado', '04:39.3');

-- Equipo 9
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 9, 'Ricardo Díaz', 26, '50m Mariposa', '00:25.8');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 9, 'Juliana Pérez', 20, '100m Libre', '00:55.3');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 9, 'David Ruiz', 23, '200m Pecho', '02:15.7');

-- Equipo 10
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 10, 'Lucía Cárdenas', 21, '100m Mariposa', '00:59.1');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 10, 'Juan Morales', 24, '200m Libre', '02:01.8');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 10, 'Sofía Ramírez', 19, '50m Espalda', '00:29.3');

-- Equipo 11
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 11, 'Pedro Rincón', 22, '400m Libre', '04:15.2');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 11, 'Camila Muñoz', 25, '100m Espalda', '00:56.8');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 11, 'Jorge Romero', 23, '200m Mariposa', '02:04.4');

-- Equipo 12
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 12, 'Valentina Cruz', 21, '50m Libre', '00:25.0');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 12, 'Mauricio Peña', 24, '100m Pecho', '01:04.3');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 12, 'Daniel Torres', 22, '200m Espalda', '02:11.9');

-- Equipo 13
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 13, 'Elena Sánchez', 20, '50m Mariposa', '00:27.1');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 13, 'Carlos Pardo', 25, '100m Libre', '00:54.0');
INSERT INTO SYSTEM.MIEMBRO_EQUIPO VALUES (DEFAULT, 13, 'Isabella Díaz', 23, '200m Libre', '02:06.7');

COMMIT;
