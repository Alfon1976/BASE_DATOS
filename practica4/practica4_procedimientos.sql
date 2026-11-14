

-- Ejercicio 1. Crear un procedimiento que obtenga los videojuegos que pertenecen al género MOBA.


DELIMITER //

CREATE PROCEDURE sp_videojuegos_moba()
BEGIN
    SELECT j.id_juego, j.nombre_juego, g.nombre_genero
    FROM juego j
    JOIN genero g ON j.id_genero = g.id_genero
    WHERE g.nombre_genero = 'MOBA';
END //
DELIMITER ;


-- Ejercicio 2. Crear un procedimiento que obtenga los videojuegos desarrollados por Supercell.

DELIMITER //

CREATE PROCEDURE sp_videojuegos_supercell()
BEGIN
    SELECT j.id_juego, j.nombre_juego, d.nombre_desarrollador
    FROM juego j
    JOIN desarrollador_juego dj ON j.id_juego = dj.id_juego
    JOIN desarrollador d ON dj.id_desarrollador = d.id_desarrollador
    WHERE d.nombre_desarrollador = 'Supercell';
END //


DELIMITER ;