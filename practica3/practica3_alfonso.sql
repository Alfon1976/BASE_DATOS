
--Tarea 1: Creación de usuarios y políticas de conexión y caducidad--

CREATE USER 'gestor_tienda'@'localhost' 
IDENTIFIED BY 'G3st0r_T13nd4.2026!';

CREATE USER 'auditor_externo'@'%' 
IDENTIFIED BY 'Aud1t0r_Ext3rn0_#Sec!';