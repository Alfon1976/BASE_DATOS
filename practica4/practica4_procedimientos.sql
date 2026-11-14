

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


