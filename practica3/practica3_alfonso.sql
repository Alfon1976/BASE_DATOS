
--Tarea 1: Creación de usuarios y políticas de conexión y caducidad--

CREATE USER 'gestor_tienda'@'localhost' IDENTIFIED BY 'G3st0r_T13nd4.2026!'; --aqui le ponemos la contraseña--

CREATE USER 'auditor_externo'@'%' IDENTIFIED BY 'Aud1t0r_Ext3rn0_#Sec!';


-- Directiva de caducidad de credenciales:--

ALTER USER 'auditor_externo'@'%' PASSWORD EXPIRE INTERVAL 30 DAY;


--Directiva de control de sesión:--

CREATE ROLE rol_consultor;

GRANT SELECT on tienda_informatica.* TO 'rol_consultor' --GRANT permiso de lectura por que estra el select--

GRANT SELECT ON tienda_informatica.* TO 'rol_consultor';

-- 3. Asignación y rol por defecto

GRANT 'rol_consultor' TO 'auditor_externo'@'%';

SET DEFAULT ROLE 'rol_consultor' FOR 'auditor_externo'@'%';

--Tarea 3: Seguridad mediante Vistas y Privilegios Granulares--

CREATE VIEW v_tecnicos_activos AS SELECT id, nombre, especialidad FROM tecnicos;

GRANT SELECT ON tienda_informatica.v_tecnicos_activos TO 'gestor_tienda'@'%';

--Tarea 4: Consistencia y control con WITH CHECK OPTION --

CREATE VIEW v_articulos_gama_baja AS SELECT id, nombre, precio, fabricante_id FROM articulos WHERE precio <= 50.00 WITH CHECK OPTION;


--Tarea 5: Auditoría, Resolución de Incidencias y Reflexión Crítica (Apartado de Análisis y Razonamiento) --


1. Auditoría de privilegios efectivos
Para comprobar exactamente qué ve el servidor en tiempo de ejecución para el usuario auditor_externo, utilizamos estas sentencias SQL:

-- 1. Verificar los roles y privilegios asignados explícitamente al usuario

SHOW GRANTS FOR 'auditor_externo'@'%';

esto es lo que hace cada palabra de la sentencia 

SHOW GRANTS: Es la orden que le dice al servidor: "Muéstrame la lista de permisos y privilegios asignados".
FOR: Especifica a quién le vas a revisar esos permisos.
'auditor_externo': Es el nombre exacto de la cuenta de usuario que estás auditando.
@: Significa "en" o "desde", y sirve para separar el nombre del usuario de su lugar de conexión.
'% ': Es un comodín (significa "cualquier parte") que indica que el usuario se puede conectar desde cualquier dirección IP o servidor remoto.


-- 2. Comprobar qué rol tiene activo en su sesión (debe mostrar 'rol_consultor')

SELECT CURRENT_ROLE();

SELECT: Es la orden que le dice al servidor: "Muéstrame en pantalla el siguiente dato".
CURRENT_ROLE: Es una función interna que le dice al servidor: "Busca cuál es el rol (o grupo de permisos) que este usuario tiene activado y usando en este preciso momento".
(): Son los paréntesis obligatorios que indican que CURRENT_ROLE es una función que el servidor debe ejecutar de inmediato.







--2. Principio de Mínimo Privilegio : 

Dar permisos totales (ALL PRIVILEGES) a la web es una locura: si entra una inyección SQL, el atacante tiene vía libre para borrar la base de datos o robarlo todo. Con el principio de mínimo privilegio solo le das lo justo (como leer o insertar en tablas concretas), limitando muchísimo el daño si nos hackean.

--3. Análisis del CHECK OPTION:

Quitar el WITH CHECK OPTION para "ganar rendimiento" es un error grave. Alguien podría meter un artículo caro (ej. 600€) por la vista de gama baja; la BD lo guarda, pero el producto "desaparece" de la vista porque no cumple el filtro, rompiendo las reglas del negocio y generando datos falsos.






Sin WITH CHECK OPTION, podrías colar un producto de 600€ por la vista de gama baja. La tabla original lo guardaría, pero desaparecería de la vista al no cumplir el filtro (<= 50€). Esto rompe la lógica del negocio por una falsa mejora de rendimiento. 
