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


/*31. Crea la tabla país como copia de countries desde el usuario HR.¨*/

--CONEX HR
CREATE TABLE EMPLEADOS AS
SELECT *
FROM Conexion_hr.EMPLOYEES;
--LA HEMOS BORRADO ANTES


/*32. Concede al usuario oracle4 permisos para borrar tablas de cualquier usuario.
Borra desde el usuario oracle4 la tabla país del usuario hr.*/

--CONEX SYSTEM
GRANT DROP ANY TABLE TO ORACLE4;

--CONEX ORACLE4
DROP TABLE CONEXION_HR.EMPLEADOS;


/*33. Oracle4 concede a todos los usuarios (actuales y futuros) cualquier tipo de
privilegio sobre la tabla que ha creado en el ejercicio 25.*/

--CONEX SYSTEM
GRANT ALL ON ORACLE4.PRUEBA_ORACLE4 TO PUBLIC;



/*34. Crea en oracle4 una segunda tabla2 con 3 campos (campo1, campo2 y campo3)
concede al usuario hr permisos para modificar solo la columna campo2. Trata
ahora de modificar como usuario hr dos columnas de esa tabla, ¿permite
hacerlo?*/

--ORACLE4
CREATE TABLE TABLA2
    (
    CAMPO1 VARCHAR2(50),
    CAMPO1 VARCHAR2(50),
    CAMPO1 VARCHAR2(50)
    );


/*35. Comprueba que desde oracle 4 puedes borrar la tabla countries.*/

--CONEX ORACLE4
DROP TABLE CONEXION_HR.EMPLEADOS;


/*36. Concede permisos al usuario oracle4 para que a su vez pueda crear usuarios así
como darles cualquier privilegio.*/

--CONEX SYSTEM
GRANT CREATE USER TO ORACLE4 WITH ADMIN OPTION; --crear users
GRANT DBA TO ORACLE4;--dar cualquier privilkegio


/*37. Conéctate como usuario oracle4 y crea el usuario oracle4a con contraseña
oracle4a espacio de tablas usuario y sin límite de cuota. Asígnale permisos de
ejecución de consultas sobre la tabla jobs del usuario hr. Concede ahora
privilegio de modificación sobre la columna coutry_name de la tabla countries
a todos los usuarios*/

--CONEX ORACLE4
CREATE USER ORACLE4A
IDENTIFIED BY ORACLE4A
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON USRES;

--CONEX SYSTEM
GRANT SELECT ON CONEXION_HR.JOBS TO ORACLE4A;
GRANT CREATE USER TO ORACLE4A;
GRANT CREATE SESSION TO ORACLE4A;
--GRANT UPDATE 
GRANT UPDATE (REGION_NAME) ON CONEXION_HR.REGIONS TO PUBLIC;



/*38. Comprueba desde el usuario hr qué permisos ha concedido sobre sus tablas a
los demás usuarios. Comprueba desde el usuario oracle4 qué permisos ha
recibido sobre las tablas de otros usuarios (usa la vista user_tab_privs).*/

--CONEX HR
SELECT * FROM USER_TAB_PRIVS;

--CONEX ORACLE4
SELECT * FROM USER_TAB_PRIVS;



/*39. Consulta los privilegios de sistema asignados a oracle4a ( usa la vista
dba_sys_privs).*/

--ORACLE4A
SELECT * FROM USER_SYS_PRIVS;



/*40. Estando conectado como usuario “administrador” probar a crear un rol llamado
“administrador”, ¿qué ocurre?*/

--CONEX ADMINISTRADOR
CREATE ROLE ADMINISTRADOR;
--no permite crear un rol con el mismo nombre que un usuario ya existenete


/*41. Idem estando conectado como usuario SYSTEM, ¿qué sucede?, ¿por qué?*/

--CONEX system
CREATE ROLE ADMINISTRADOR;
--el mismo error por lo mismo de antes


/*42. Comprobar en el diccionario de datos los usuarios o roles que poseen el
privilegio “CREATE ROLE”. (Utiliza la vista dba_sys_privs).*/

--CONEX SYSTEM
SELECT * 
FROM dba_sys_privs
WHERE PRIVILEGE = 'CREATE ROLE';


/*43. Crear un rol llamado “ADMIN”, asignarle los privilegios “create session”,
“create user” y “CREATE ROLE”. Asignarlo al usuario administrador.*/

--CONEX SYSTEM
CREATE ROLE ADMIN;
GRANT CREATE SESSION TO ADMIN;
GRANT CREATE USER TO ADMIN;
GRANT CREATE ROLE TO ADMIN;
GRANT ADMIN TO ADMINISTRADOR;



/*44. Consultar los privilegios de sistema que tiene asignados de forma directa el
usuario “administrador”, revocarlos y asignarle el rol “admin.”.*/

--CONEX SYSTEM
SELECT *
FROM DBA_SYS_PRIVS
WHERE GRANTEE = 'ADMINISTRADOR';


/*45. Crea el usuario usuario1 y asígnale el role connect y resource. Comprueba
después en la vista correspondiente que efectivamente tiene esos roles.
Comprueba también desde el EM que el usuario tiene marcados esos roles.*/

--CONEX SYSTEM
CREATE USER USUARIO1
IDENTIFIED BY USUARIO1
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 500K ON USERS;

GRANT CONNECT TO USUARIO1;
GRANT RESOURCE TO USUARIO1;

SELECT * 
FROM DBA_ROLE_PRIVS
WHERE GRANTEE = 'USUARIO1';



/*46. Crea el rol opera_jobs de modo que este rol adjudique permisos de selección,
inserción y borrado sobre la tabla jobs del usuario HR. Y además tenga
permisos para crear usuarios en la base de datos*/

--CONEX SYSTEM
CREATE ROLE OPERA_JOBS;

GRANT SELECT ON CONEXION_HR.JOBS TO OPERA_JOBS;
GRANT INSERT ON CONEXION_HR.JOBS TO OPERA_JOBS;
GRANT DELETE ON CONEXION_HR.JOBS TO OPERA_JOBS;
GRANT CREATE USER TO OPERA_JOBS;


/*47. Comprueba en las correspondientes vistas los permisos que tiene asociados el
rol opera_jobs.*/

--CONEX SYSTEM
SELECT *
FROM DBA_SYS_PRIVS
WHERE GRANTEE = 'OPERA_JOBS';


/*48. Crea un usuario oracle5 con contraseña oracle5, espacio de tablas usuarios y
sin límite de cuota. Asígnale a oracle5 y oracle4 el rol opera jobs(en una sola
sentencia). Accede con el usuario oracle5 y comprueba que puedes insertar la
fila ('SA_TA', 'XXXXX', 200,9000) en la tabla jobs de hr*/

--CONEX SYSTEM
CREATE USER ORACLE5
IDENTIFIED BY ORACLE5
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON USERS;

--CONEX SYSTEM
GRANT OPERA_JOBS TO ORACLE5, ORACLE4;

--CONEX SYSTEM
--primero necesita permisoss de create session
GRANT CREATE SESSION TO ORACLE5;

--CONEX ORACLE5
INSERT INTO CONEXION_HR.JOBS
VALUES('SA_TA', 'XXXXX', 200,9000);


/*49. Retira el privilegio create user del role opera_jobs.*/

--CONEX SYSTEM
REVOKE CREATE USER FROM OPERA_JOBS;


/*50. Retira al usuario oracle5 el rol opera_jobs.*/

--CONEX SYSTEM
REVOKE OPERA_JOBS FROM ORACLE5;


/*51. Borra el rol opera_jobs*/

--CONEX SYSTEM
DROP ROLE OPERA_JOBS;


/*52. Si cuando creamos un usuario no le asignamos ningún perfil, ¿qué perfil le
adjudica ORACLE?Entra en la vista dba_profiles y comprueba los valores de los
campos asociados al perfil DEFAULT.
a. ¿Cuántas sesiones concurrentes por usuario permite ?
b.¿Cuál es el límite de tiempo de inactividad?
c. ¿Cuál es el máximo tiempo que una sesión puede permanecer inactiva?
d.¿Cuántos intentos consecutivos fallidos permite antes de bloquear la cuenta?
FAILED_LOGIN_ATTEMPTS.*/

--se le asigna el perfil default
--CONEX SYSTEM
SELECT *
FROM DBA_PROFILES
WHERE PROFILE = 'DEFAULT';

--A
--CONEX SYSTEM
SELECT * 
FROM DBA_PROFILES
WHERE PROFILE = 'DEFAULT' AND RESOURCE_NAME = 'SESSIONS_PER_USER';

--B 
--CONEX SYSTEM
SELECT * 
FROM DBA_PROFILES
WHERE PROFILE = 'DEFAULT' AND RESOURCE_NAME = 'IDLE_TIME';

--C
--CONEX SYSTEM
SELECT * 
FROM DBA_PROFILES
WHERE PROFILE = 'DEFAULT' AND RESOURCE_NAME = 'CONNECT_TIME';

--D
--CONEX SYSTEM
SELECT * 
FROM DBA_PROFILES
WHERE PROFILE = 'DEFAULT' AND RESOURCE_NAME = 'FAILED_LOGIN_ATTEMPTS';



/*53. Crea el perfil pruebas1 (desde el usuario administrador) de modo que solo
pueda haber 2 sesiones concurrentes por usuario, el tiempo de inactividad será
un máximo de 2’ y el nº de intentos fallidos antes de bloquear la cuenta 2.
Indica los pasos realizados*/

--CONEX ADMINISTRADOR
CREATE PROFILE PRUEBAS1 LIMIT
    SESSIONS_PER_USER 2
    IDLE_TIME 2
    FAILED_LOGIN_ATTEMPTS 2;
    
/*54. Modifica el usuario oracle4 de modo que su perfil sea pruebas1 y comprueba
que se cumplen las condiciones del perfil alter user oracle4 profile pruebas*/

--CONEX SYSTEM
ALTER USER ORACLE4 PROFILE PRUEBAS1;
SELECT *
FROM DBA_PROFILES
WHERE PROFILE = 'PRUEBAS1';


/*55. Modifica el perfil pruebas1 cambiando el tiempo de inactividad a 3’ y el tiempo
de sesión a 400’.*/

--CONEX SYSTEM
ALTER PROFILE PRUEBAS1 LIMIT
    IDLE_TIME 3
    CONNECT_TIME 400;


/*56. Comprueba a través de la vista de perfiles cuales son los nuevos valores
asignados.*/

--CONEX SYSTEM
SELECT *
FROM DBA_PROFILES
WHERE PROFILE = 'PRUEBAS1';


/*57. Borra el perfil pruebas1.*/
DROP PROFILE PRUEBAS1 CASCADE; 
