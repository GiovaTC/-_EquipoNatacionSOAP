-- ==============================================================
-- ? Datos de prueba para ConsultarEquipoNatacion
-- Base de datos: Oracle 19c
-- ==============================================================
-- Tablas esperadas:
--   EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, PAIS)
--   MIEMBRO_EQUIPO (ID_MIEMBRO, NOMBRE_MIEMBRO, EDAD, ESPECIALIDAD, ID_EQUIPO)
-- ==============================================================

-- ? Limpiar datos anteriores
DELETE FROM MIEMBRO_EQUIPO;
DELETE FROM EQUIPO_NATACION;
COMMIT;

-- ==============================================================
-- ? Insertar equipos
-- ==============================================================

INSERT INTO EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, PAIS) VALUES (1,  'Los Delfines',           'Juan Pérez',      'Colombia');
INSERT INTO EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, PAIS) VALUES (2,  'AquaRockets',           'Lucía Gómez',     'México');
INSERT INTO EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, PAIS) VALUES (3,  'Mar Abierto',           'Carlos López',    'Chile');
INSERT INTO EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, PAIS) VALUES (4,  'Tiburones Azules',      'Sofía Torres',    'Argentina');
INSERT INTO EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, PAIS) VALUES (5,  'Rayo del Pacífico',     'Andrés Núñez',    'Perú');
INSERT INTO EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, PAIS) VALUES (6,  'Coral Team',            'Valentina Ruiz',  'Colombia');
INSERT INTO EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, PAIS) VALUES (7,  'Delfines del Norte',    'Mario Vargas',    'México');
INSERT INTO EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, PAIS) VALUES (8,  'Tormenta Marina',       'Camila Ortega',   'Ecuador');
INSERT INTO EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, PAIS) VALUES (9,  'Velocidad Total',       'Raúl Mendoza',    'Uruguay');
INSERT INTO EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, PAIS) VALUES (10, 'Olas Doradas',          'Gabriela Luna',   'Venezuela');
INSERT INTO EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, PAIS) VALUES (11, 'Truenos del Agua',      'Eduardo Silva',   'Costa Rica');
INSERT INTO EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, PAIS) VALUES (12, 'Náuticos del Sur',      'Laura Mejía',     'Paraguay');
INSERT INTO EQUIPO_NATACION (ID_EQUIPO, NOMBRE_EQUIPO, ENTRENADOR, PAIS) VALUES (13, 'AquaStars',             'Fernanda Díaz',   'Colombia');

COMMIT;

-- ==============================================================
-- ???? Insertar miembros (3 por equipo)
-- ==============================================================

INSERT INTO MIEMBRO_EQUIPO (ID_MIEMBRO, NOMBRE_MIEMBRO, EDAD, ESPECIALIDAD, ID_EQUIPO) VALUES (1,  'Camila Torres',      21, '100m Libre',          1);
INSERT INTO MIEMBRO_EQUIPO (ID_MIEMBRO, NOMBRE_MIEMBRO, EDAD, ESPECIALIDAD, ID_EQUIPO) VALUES (2,  'Santiago Gómez',    24, '200m Pecho',          1);
INSERT INTO MIEMBRO_EQUIPO (ID_MIEMBRO, NOMBRE_MIEMBRO, EDAD, ESPECIALIDAD, ID_EQUIPO) VALUES (3,  'Luisa Díaz',        20, '50m Mariposa',        1);

INSERT INTO MIEMBRO_EQUIPO (ID_MIEMBRO, NOMBRE_MIEMBRO, EDAD, ESPECIALIDAD, ID_EQUIPO) VALUES (4,  'Javier López',      25, '100m Espalda',        2);
INSERT INTO MIEMBRO_EQUIPO (ID_MIEMBRO, NOMBRE_MIEMBRO, EDAD, ESPECIALIDAD, ID_EQUIPO) VALUES (5,  'Natalia Rojas',     22, '200m Libre',          2);
INSERT INTO MIEMBRO_EQUIPO (ID_MIEMBRO, NOMBRE_MIEMBRO, EDAD, ESPECIALIDAD, ID_EQUIPO) VALUES (6,  'Héctor Campos',     26, '400m Combinado',      2);

INSERT INTO MIEMBRO_EQUIPO (ID_MIEMBRO, NOMBRE_MIEMBRO, EDAD, ESPECIALIDAD, ID_EQUIPO) VALUES (7,  'Daniel Soto',       19, '100m Pecho',          3);
INSERT INTO MIEMBRO_EQUIPO (ID_MIEMBRO, NOMBRE_MIEMBRO, EDAD, ESPECIALIDAD, ID_EQUIPO) VALUES (8,  'Mariana Ortiz',     23, '200m Espalda',        3);
INSERT INTO MIEMBRO_EQUIPO (ID_MIEMBRO, NOMBRE_MIEMBRO, EDAD, ESPECIALIDAD, ID_EQUIPO) VALUES (9,  'Felipe León',       20, '100m Libre',          3);

INSERT INTO MIEMBRO_EQUIPO (ID_MIEMBRO, NOMBRE_MIEMBRO, EDAD, ESPECIALIDAD, ID_EQUIPO) VALUES (10, 'Valeria Peña',      22, '50m Espalda',         4);
INSERT INTO MIEMBRO_EQUIPO (ID_MIEMBRO, NOMBRE_MIEMBRO, EDAD, ESPECIALIDAD, ID_EQUIPO) VALUES (11, 'Andrés Parra',      25, '200m Mariposa',       4);
INSERT INTO MIEMBRO_EQUIPO (ID_MIEMBRO, NOMBRE_MIEMBRO, EDAD, ESPECIALIDAD, ID_EQUIPO) VALUES (12, 'Juliana Castro',    21, '400m Libre',          4);

INSERT INTO MIEMBRO_EQUIPO (ID_MIEMBRO, NOMBRE_MIEMBRO, EDAD, ESPECIALIDAD, ID_EQUIPO) VALUES (13, 'Miguel Herrera',    26, '100m Libre',          5);
INSERT INTO MIEMBRO_EQUIPO (ID_MIEMBRO, NOMBRE_MIEMBRO, EDAD, ESPECIALIDAD, ID_EQUIPO) VALUES (14, 'Daniela Suárez',    20, '50m Pecho',           5);
INSERT INTO MIEMBRO_EQUIPO (ID_MIEMBRO, NOMBRE_MIEMBRO, EDAD, ESPECIALIDAD, ID_EQUIPO) VALUES (15, 'Alejandro Cruz',    23, '100m Mariposa',       5);

-- (Puedes continuar con 3 nadadores por cada uno de los equipos 6 a 13)
COMMIT;
