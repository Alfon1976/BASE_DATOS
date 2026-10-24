
:: Ejercicio 1

SELECT a.nombre, f.nombre 
FROM articulos a
JOIN fabricantes f ON fabricante_id = f.id 
WHERE precio > 100.00;


:: Ejercicio 2

SELECT f.nombre, a.nombre 
FROM fabricantes f 
JOIN articulos a ON f.id = a.fabricante_id
WHERE a.fabricante_id;


:: Ejercicio 3

SELECT f.nombre, AVG(precio) as precio_medio
FROM fabricantes f 
JOIN articulos a ON f.id = a.fabricante_id
GROUP by f.nombre, f.id
HAVING AVG(precio) > 150.00;

:: Ejercicio 4

SELECT r.descripcion_averia, r.coste_reparacion, t.nombre
FROM reparaciones r
JOIN tecnicos t ON r.tecnico_id = t.id
ORDER BY coste_reparacion ASC;

:: Ejercicio 5

SELECT t.nombre AS nombre_tecnicos
FROM tecnicos t
JOIN reparaciones r ON r.id = t.id
WHERE r.id IS null; 

:: Ejercicio 6

SELECT t.nombre, SUM(r.coste_reparacion) AS total_recaudado
FROM tecnicos t
INNER JOIN reparaciones r ON t.id = r.tecnico_id
GROUP BY t.id, t.nombre
HAVING SUM(r.coste_reparacion) > 100.00;


:: Ejercicio 7

SELECT a.nombre AS articulo, f.nombre AS fabricante
FROM articulos a
INNER JOIN fabricantes f ON a.fabricante_id = f.id
WHERE f.pais IN ('Estados Unidos', 'Taiwán');

:: Ejercicio 8

SELECT t.nombre, COUNT(r.id) AS total_reparaciones
FROM tecnicos t
LEFT JOIN reparaciones r ON t.id = r.tecnico_id
GROUP BY t.id, t.nombre;


:: Ejercicio 9


SELECT f.nombre AS fabricante, COUNT(a.id) AS total_articulos
FROM fabricantes f
INNER JOIN articulos a ON f.id = a.fabricante_id
GROUP BY f.id, f.nombre
HAVING COUNT(a.id) >= 2;


:: Ejercicio 10


SELECT t.nombre, t.especialidad, r.descripcion_averia
FROM tecnicos t
INNER JOIN reparaciones r ON t.id = r.tecnico_id
WHERE r.coste_reparacion = (
    SELECT MAX(coste_reparacion) 
    FROM reparaciones 
    WHERE tecnico_id = t.id
);








