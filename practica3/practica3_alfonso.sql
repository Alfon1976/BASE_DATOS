
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




