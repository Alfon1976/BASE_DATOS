

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

-- Ejercicio 3. Crear un procedimiento que obtenga el nombre de los videojuegos y el género 
-- de los publicados en la plataforma 'PlayStation'.

CREATE PROCEDURE sp_videojuegos_playstation()
BEGIN

SELECT DISTINCT j.nombre_juego, g.nombre_genero, p.nombre_plataforma
    FROM juego j
    JOIN genero g ON j.id_genero = g.id_genero
    JOIN desarrollador_juego dj ON j.id_juego = dj.id_juego
    JOIN plataforma_juego pj ON dj.id_des_juego = pj.id_desarrollador_juego
    JOIN plataforma p ON pj.id_plataforma = p.id_plataforma
    WHERE p.nombre_plataforma LIKE '%PlayStation%';


END //