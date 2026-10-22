
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







