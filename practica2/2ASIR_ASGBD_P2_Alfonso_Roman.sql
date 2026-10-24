-- Batería de Consultas 1:
-- Para esta batería de preguntas está prohibido utilizar JOIN.


-- 1. Muestra el nombre y el precio de aquellos artículos que sean, exactamente, el
-- artículo más caro de su respectivo fabricante.


SELECT nombre, precio 
FROM articulos a
WHERE precio = (
    SELECT MAX(precio) 
    FROM articulos 
    WHERE fabricante_id = a.fabricante_id
);


-- 2. Muestra el nombre de los fabricantes que no tienen ningún artículo con un precio
-- inferior o igual a la media general de precios de toda la tienda.

SELECT nombre 
FROM fabricantes f
WHERE NOT EXISTS (
    SELECT 1 
    FROM articulos 
    WHERE fabricante_id = f.id 
      AND precio <= (SELECT AVG(precio) FROM articulos)
);




-- 3. Muestra la descripción y el coste de aquellas reparaciones cuyo coste sea
-- estrictamente superior a la media de las reparaciones realizadas por su propio
-- técnico.

SELECT descripcion_averia, coste_reparacion 
FROM reparaciones r
WHERE coste_reparacion > (
    SELECT AVG(coste_reparacion) 
    FROM reparaciones 
    WHERE tecnico_id = r.tecnico_id
);


-- 4. Muestra el identificador y la especialidad de los técnicos cuya suma total del coste de
-- las reparaciones que han realizado supere el doble de su propio salario.

SELECT id, especialidad 
FROM tecnicos t
WHERE (
    SELECT SUM(coste_reparacion) 
    FROM reparaciones 
    WHERE tecnico_id = t.id
) > (t.salario * 2);



-- 5. Muestra el nombre del fabricante (o fabricantes) que posee el mayor número de
-- artículos registrados en la base de datos.

SELECT nombre 
FROM fabricantes f
WHERE (
    SELECT COUNT(*) 
    FROM articulos 
    WHERE fabricante_id = f.id
) = (
    SELECT MAX(total) 
    FROM (
        SELECT COUNT(*) AS total 
        FROM articulos 
        GROUP BY fabricante_id
    ) AS sub
);

-- 6. Muestra el nombre de los técnicos que han realizado alguna reparación, pero que
-- nunca han realizado ninguna reparación cuyo coste haya superado los 100.00 euros.

SELECT nombre 
FROM tecnicos t
WHERE EXISTS (
    SELECT 1 
    FROM reparaciones 
    WHERE tecnico_id = t.id
) AND NOT EXISTS (
    SELECT 1 
    FROM reparaciones 
    WHERE tecnico_id = t.id 
      AND coste_reparacion > 100.00
);


-- 7. Muestra el nombre y el salario de los técnicos cuyo salario sea inferior a la media
-- salarial de su propia especialidad.

SELECT nombre, salario 
FROM tecnicos t
WHERE salario < (
    SELECT AVG(salario) 
    FROM tecnicos 
    WHERE especialidad = t.especialidad
);


-- 8. Muestra el nombre de los fabricantes cuyo país coincide con el país del fabricante
-- que produce el artículo más caro de toda la tienda.

SELECT nombre 
FROM fabricantes 
WHERE pais = (
    SELECT pais 
    FROM fabricantes 
    WHERE id = (
        SELECT fabricante_id 
        FROM articulos 
        WHERE precio = (SELECT MAX(precio) FROM articulos)
    )
);

-- 9. Muestra el nombre y el precio del artículo más barato de entre todos los fabricantes
-- que son originarios de 'Estados Unidos'.

SELECT nombre, precio 
FROM articulos 
WHERE precio = (
    SELECT MIN(precio) 
    FROM articulos 
    WHERE fabricante_id IN (
        SELECT id 
        FROM fabricantes 
        WHERE pais = 'Estados Unidos'
    )
);

-- 10. Muestra el identificador del técnico (tecnico_id) que ha acumulado el mayor
-- coste total en reparaciones.



SELECT tecnico_id 
FROM reparaciones 
GROUP BY tecnico_id
HAVING SUM(coste_reparacion) = (
    SELECT MAX(total_coste) 
    FROM (
        SELECT SUM(coste_reparacion) AS total_coste 
        FROM reparaciones 
        GROUP BY tecnico_id
    ) AS sub
);









-- Batería de Consultas 2:



-- Para esta batería de preguntas está permitido utilizar JOIN y todo lo estudiado.
-- 1. Muestra el nombre de cada artículo junto con el nombre de su fabricante, pero
-- únicamente para aquellos artículos cuyo precio sea superior a 100.00 euros.

SELECT a.nombre, f.nombre 
FROM articulos a
JOIN fabricantes f ON fabricante_id = f.id 
WHERE precio > 100.00;


-- 2. Muestra el nombre de todos los fabricantes de la base de datos y, al lado, el nombre
-- de sus artículos. Asegúrate de que aparezcan los fabricantes que no tienen ningún
-- artículo registrado.

SELECT f.nombre, a.nombre 
FROM fabricantes f 
JOIN articulos a ON f.id = a.fabricante_id
WHERE a.fabricante_id;


-- 3. Muestra el nombre del fabricante y la media de los precios de sus artículos, pero solo
-- para aquellos fabricantes cuya media de precios supere los 150.00 euros.

SELECT f.nombre, AVG(precio) as precio_medio
FROM fabricantes f 
JOIN articulos a ON f.id = a.fabricante_id
GROUP by f.nombre, f.id
HAVING AVG(precio) > 150.00;

-- 4. Muestra la descripción de la avería, el coste de la reparación y el nombre del técnico
-- que la ha llevado a cabo, ordenado por el coste de mayor a menor.


SELECT r.descripcion_averia, r.coste_reparacion, t.nombre
FROM reparaciones r
JOIN tecnicos t ON r.tecnico_id = t.id
ORDER BY coste_reparacion ASC;


-- 5. Muestra el nombre de aquellos técnicos que no han realizado ninguna reparación,
-- utilizando obligatoriamente un cruce externo de tablas.

SELECT t.nombre AS nombre_tecnicos
FROM tecnicos t
JOIN reparaciones r ON r.id = t.id
WHERE r.id IS null; 

-- 6. Muestra el nombre del técnico y la suma total del dinero recaudado con sus
-- reparaciones, filtrando únicamente aquellos técnicos cuya recaudación total supere
-- los 100.00 euros.

SELECT t.nombre, SUM(r.coste_reparacion) AS total_recaudado
FROM tecnicos t
INNER JOIN reparaciones r ON t.id = r.tecnico_id
GROUP BY t.id, t.nombre
HAVING SUM(r.coste_reparacion) > 100.00;



-- 7. Muestra el nombre de los artículos y el nombre de su respectivo fabricante, pero
-- filtrando exclusivamente aquellos artículos cuyos fabricantes sean originarios de
-- 'Estados Unidos' o 'Taiwán' .

SELECT a.nombre AS articulo, f.nombre AS fabricante
FROM articulos a
INNER JOIN fabricantes f ON a.fabricante_id = f.id
WHERE f.pais IN ('Estados Unidos', 'Taiwán');



-- 8. Muestra el nombre de todos los técnicos y, al lado, el número total de reparaciones
-- que ha realizado cada uno de ellos.

SELECT t.nombre, COUNT(r.id) AS total_reparaciones
FROM tecnicos t
LEFT JOIN reparaciones r ON t.id = r.tecnico_id
GROUP BY t.id, t.nombre;



-- 9. Muestra el nombre del fabricante y el número total de artículos que produce, pero
-- solo de aquellos fabricantes que tengan un número de artículos mayor o igual a 2.

SELECT f.nombre AS fabricante, COUNT(a.id) AS total_articulos
FROM fabricantes f
INNER JOIN articulos a ON f.id = a.fabricante_id
GROUP BY f.id, f.nombre
HAVING COUNT(a.id) >= 2;




-- 10. Muestra el nombre del técnico, su especialidad y la descripción de la reparación más
-- costosa que ha realizado cada uno de ellos.


SELECT t.nombre, t.especialidad, r.descripcion_averia
FROM tecnicos t
INNER JOIN reparaciones r ON t.id = r.tecnico_id
WHERE r.coste_reparacion = (
    SELECT MAX(coste_reparacion) 
    FROM reparaciones 
    WHERE tecnico_id = t.id
);

