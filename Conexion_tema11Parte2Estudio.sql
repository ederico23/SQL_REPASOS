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

--CONEX ADMINISTRADOR (SE PUEDE HACER DESDE LAS 2 PERO NO ME HA QUEDADO CLARO EN EL ENUNCIADO)
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


/*18. Asígnale una cuota de 500 K al usuario prueba1.*/

--CONEX SYSTEM
ALTER USER PRUEBA1 QUOTA 500K ON USERS;


/*19. Como usuario prueba1, modifica su propia contraseña a pru1. ¿Puede
modificar el propio usuario prueba1 su espacio de tablas por defecto? ¿Qué
privilegio necesita? Asígnale dicho privilegio desde el usuario System y
comprueba que ahora el usuario prueba1 puede modificarse a sí mismo su
espacio de tabla o su cuota, por ejemplo.*/

--CONEX PRUEBA1
ALTER USER PRUEBA1 IDENTIFIED BY PRU1;

--no, no tiene permiso para modificar su propio usuario, necesitara el permiso modify user

--CONEX SYSTEM
GRANT ALTER USER TO PRUEBA1;

--CONEX PRUEBA1
ALTER USER PRUEBA1 QUOTA 500K ON USERS;


/*20. Como usuario administrador crea un nuevo usuario llamado ora1 con
contraseña ora1 cuota 500k y espacios users y temp. Este nuevo usuario
deberá poder conectarse a la BD y crear tablas. Crea una tabla para el usuario
ora1¿Puedes insertar datos o manipular la tabla ? ¿Puedes crear
procedimientos, triggers,… ? Indica qué privilegios necesitarías.*/

--CONEX ADMINISTRADOR
CREATE USER ORA1
IDENTIFIED BY ORA1
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 500K ON USERS;

--CONEX ADMINISTRADOR
GRANT CREATE TABLE TO ORA1;
GRANT CREATE SESSION TO ORA1;


--CONEX ORA1
CREATE TABLE ORA1_TABLA
(
    ID_ORA1 NUMBER(3) CONSTRAINT ID_O1TABLA_PK PRIMARY KEY,
    NOMBRE VARCHAR2(15)
);

--CONEX ORA1
INSERT INTO ORA1_TABLA
VALUES (1,'Eder');

--CONEX ORA1
UPDATE ORA1_TABLA
SET NOMBRE = 'Mariano'
WHERE ID_ORA1 = 1;


/*21. Como usuario administrador borra el usuario ora1. Indica los pasos que has
tenido que realizar para poder hacerlo*/

--CONEX SYSTEM
GRANT DROP USER TO ADMINISTRADOR;

--CONEX ADMINISTRADOR
DROP USER ORA1 CASCADE;


/*22. Averiguar qué usuarios de la base de datos tienen asignado el privilegio “create
user” de forma directa, ¿qué vista debe ser consultada? ¿Qué significa la
opción ADMIN OPTION?*/

SELECT * 
FROM DBA_SYS_PRIVS
WHERE PRIVILEGE = 'CREATE USER';

--admin option significa que tambien puede dar privilegios a otros


/*23. Hacer lo mismo para el privilegio “create session”.*/
SELECT * 
FROM DBA_SYS_PRIVS 
WHERE PRIVILEGE = 'CREATE SESSION';



/*24. En caso de que esté bloqueado, desbloquea el usuario hr de la base de datos y
ponle como contraseña hr. Consulta las tablas de las que dispone este usuario.*/

--CONEX SYSTEM
ALTER USER Conexion_hr ACCOUNT UNLOCK;
ALTER USER Conexion_hr IDENTIFIED BY HR;


/*25. Concede permisos al usuario oracle4 para ejecutar consultas sobre la tabla
employees del usuario hr (Crea previamente el usuario oracle4 con clave a 500k
y tablespace users y temp, concédele privilegios para conectarse y crear tablas,
crea una tabla en el usuario oracle4) Nota: previamente concede
definitivamente al administrador el rol dba.*/

--CONEX SYSTEM
GRANT DBA TO ADMINISTRADOR;

--CONEX SYSTEM
CREATE USER ORACLE4
IDENTIFIED BY ORACLE4
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 500K ON USERS;

--CONEX SYSTEM
GRANT CREATE USER TO ORACLE4;
GRANT CREATE TABLE TO ORACLE4;
GRANT CREATE SESSION TO ORACLE4;
GRANT SELECT ON Conexion_hr.employees TO oracle4;

--CONEX ORACLE4
CREATE TABLE PRUEBA_ORACLE4
    (
    ID_O4 NUMBER(4) CONSTRAINT ID_PO4_PK PRIMARY KEY,
    NOMBRE VARCHAR(15)
    );
    


/*26. Consulta los datos de la tabla employees (habiéndote conectado como usuario
oracle4). Crear la tabla empleados a partir de la consulta anterior.*/

--CONEX ORACLE4
SELECT * FROM CONEXION_HR.EMPLOYEES;

CREATE TABLE EMPLEADOS
AS SELECT * FROM CONEXION_HR.EMPLOYEES;


/*27. Consulta los datos de la tabla countries de hr ¿Has podido? ¿Por qué?*/

--CONEX ORACLE4
SELECT * 
FROM CONEXION_HR.COUNTRIES;
--NO DEJA PORQUE NO HEMOS DADO PERMISO PARA VER COUNTRIES

/*28. Concede permisos a oracle4 para insertar registros en la tabla countries de hr*/

--CONEX SYSTEM
GRANT INSERT ON CONEXION_HR.COUNTRIES TO ORACLE4;


/*29. Inserta el país España con código ES de Europa en la tabla countries como
usuario oracle4*/

--CONEX ORACLE4
INSERT INTO CONEXION_HR.COUNTRIES (COUNTRY_ID, COUNTRY_NAME, REGION_ID)
VALUES('ES', 'España', (SELECT REGION_ID FROM CONEXION_HR.REGIONS WHERE REGION_NAME = 'Europe'));



/*30. Trata de borrar como usuario oracle4 la fila que has insertado*/
DELETE CONEXION_HR.COUNTRIES
WHERE COUNTRY_NAME = 'España';
--PRIVILEGIOS INSUFICIENTES



































