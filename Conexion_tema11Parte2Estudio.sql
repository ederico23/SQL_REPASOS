/*9. Conectarse como usuario SYSTEM a la base de datos de Oracle y crear un
usuario llamado “administrador” autentificado por la base de datos con
contraseña admin. Indicar como "tablespace" por defecto USERS y como
"tablespace" temporal TEMP; asignar una cuota de 500K en el "tablespace"
USERS.Consulta después la vista all_users e indica la información que aparece sobre él.*/

--CONEX SYSTEM
CREATE USER ADMINISTRADOR --nombre de usuario
IDENTIFIED BY ADMIN --contraseña
DEFAULT TABLESPACE USERS --tablespace por defecto (mesa, espacio de trabajo)
TEMPORARY TABLESPACE TEMP --tablespace temporal (pizzarra)
QUOTA 500K ON USERS; --cuota (espacio)

SELECT * FROM ALL_USERS; --mostrar todos los usuarios que existen


/*10. Abrir una nueva conexión en sql developer e intentar conectarse como usuario
“administrador”, ¿qué sucede?, ¿por qué?*/
--NO TIENE EL PRIVILEGIO DE CREAR SESION

/*11. Averiguar qué privilegios de sistema, roles y privilegios sobre objetos tiene
concedidos el usuario “administrador” consultando las vistas dba_role_privs,
dba_tab_privs, dba_sys_privs (busca en Internet qué contienen cada una de
estas vistas).*/

--CONEX SYSTEM
SELECT *
FROM DBA_ROLE_PRIVS
WHERE GRANTEE = 'ADMINISTRADOR';

--CONEX SYSTEM
SELECT * 
FROM DBA_TAB_PRIVS
WHERE GRANTEE = 'ADMINISTRADOR';

--CONEX SYSTEM
SELECT * 
FROM DBA_SYS_PRIVS
WHERE GRANTEE = 'ADMINISTRADOR';


/*12. Otorgar el privilegio “CREATE SESSION” al usuario “administrador” e intentar de
nuevo la conexión sqlplus o sqldeveloper.*/
--CONEX SYSTEM
GRANT CREATE SESSION TO ADMINISTRADOR; --dar permiso de crear sesion


/*13. Modifica la contraseña del usuario administrador por admi y vuelve a acceder a
Oracle con el usuario administrador. Comprueba que se ha modificado la
contraseña.*/

--CONEX SYSTEM
--alter user (nombre usuario) (que se quiere modificar)
ALTER USER ADMINISTRADOR IDENTIFIED BY ADMI; --cambiar contraseña 



/*14. Modifica el usuario administrador de forma que su cuenta esté bloqueada.
Accede de nuevo con este usuario y comprueba que efectivamente no puede
acceder a su cuenta.*/

--CONEX SYSTEM
--alter user (nombre usuario) (que se quiere modificar)
ALTER USER ADMINISTRADOR ACCOUNT LOCK; --bloquear cuenta


/*15. Conectarse como usuario “administrador” y crear un usuario llamado
“prueba00” que tenga como "tablespace" por defecto USERS y como
"tablespace" temporal TEMP; asignar una cuota de 500K en el "tablespace"
USERS. ¿Es posible hacerlo?*/

--ahora mismo administrador esta bloqueado, aunque tenga los permisos de create session
--no podria por cuenta bloqueada, ademas que administrador solo puede create session,
--no tiene el permiso de create user


/*16. Conectado como usuario SYSTEM, otorgar el privilegio “create user” al usuario
“administrador” y repetir el ejercicio anterior.*/

--CONEX SYSTEM
ALTER USER ADMINISTRADOR ACCOUNT UNLOCK; --desbloquear la cuenta, estaba bloqueada

--CONEX SYSTEM
GRANT CREATE USER TO ADMINISTRADOR; --conceder permiso de crear usuarios

--CONEX SYSTEM/ADMINISTRADOR (SE PUEDE HACER DESDE LAS 2 PERO NO ME HA QUEDADO CLARO EN EL ENUNCIADO)
CREATE USER PRUEBA00
IDENTIFIED BY PRUEBA00
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 500K ON USERS;



/*17. Crea un nuevo usuario prueba1 con clave prueba1 y tablespace users.
Concédele el privilegio de connectarse a la BD. Trata de crear una tabla ¿Has
podido? ¿Por qué? Concédele el privilegio CREATE TABLE y trata de crear de
nuevo la tabla ¿Has podido?*/

--CONEX SYSTEM
CREATE USER PRUEBA1
IDENTIFIED BY PRUEBA1
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 500K ON USERS;

--CONEX SYSTEM
GRANT CREATE SESSION TO PRUEBA1; --permiso pa conectarse a bd

--CONEX PRUEBA1
--sale error porque no tiene permisos
CREATE TABLE TABLA_PRUEBA1 
(
    ID_PRUEBA1 NUMBER(3) CONSTRAINT ID_TPRUEBA1_PK PRIMARY KEY
);

--CONEX SYSTEM
GRANT CREATE TABLE TO PRUEBA1;

--CONEX PRUEBA1
--no sale error, ya tiene permisos
CREATE TABLE TABLA_PRUEBA1 
(
    ID_PRUEBA1 NUMBER(3) CONSTRAINT ID_TPRUEBA1_PK PRIMARY KEY
);









