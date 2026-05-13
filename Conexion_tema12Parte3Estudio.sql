--CONEXION TEMA12ESTUDIO

/*Ejercicio propuesto:
Escribe un disparador que inserte en la tabla auditaremple(col1 (VARCHAR2(200)) cualquier cambio
que supere el 5% del salario del empleado indicando la fecha y hora, el empleado, y el salario
anterior y posterior.*/

CREATE TABLE AUDITAREMPLE (
INFORMACION VARCHAR2(200)); --TABLA PA MOSTRAR MENSAJE

CREATE OR REPLACE TRIGGER audit_salario --CREAS TRIGGER
    AFTER UPDATE OF SALARIO ON EMPLE -- CUANDO SE ACTUALICE LA TABLA 
    FOR EACH ROW -- POR CADA LINEA
WHEN (NEW.SALARIO > OLD.SALARIO*1.05) -- CUANDO EL SALARIO NUEVO SEA 5% MAYOR QUE EL ANTIGUO
BEGIN
        INSERT INTO AUDITAREMPLE --INSERTAR EN LA TABLA MENSAJE
        VALUES (TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI') || ' ' || :NEW.EMP_NO || ' ANTIGUO SALARIO: ' || :OLD.SALARIO ||
        ' NUEVO SALARIO: ' || :NEW.SALARIO);
END;
/

SELECT * FROM EMPLE WHERE DEPT_NO = 10;

UPDATE EMPLE 
SET SALARIO = 400000
WHERE DEPT_NO = 10;

SELECT * FROM AUDITAREMPLE;


--CONEXION_TEMA12PARTE3ESTUDIO TABLA POBLACION

/*1. Escribe un trigger que permita auditar las operaciones de inserción o borrado de datos que se realicen
en la tabla CATEGORÍAS según las siguientes especificaciones:
a. Primero se deberá crear la tabla AUDITACATEGORIAS con las columnas fecha, id_categoria,
tipo_operacion.
b. Cuando se produzca cualquier manipulación, se insertará una fila en dicha tabla que contendrá (en
la columna correspondiente):
Fecha y hora, Id de la categoría, la operación de actualización: INSERCIÓN O BORRADO. 
*/

CREATE TABLE AUDITACATEGORIAS(
FECHA VARCHAR2(200), ID_CATEGORIA NUMBER, TIPO_OPERACION VARCHAR2(200));


CREATE OR REPLACE TRIGGER IN_DEL_CATEGORIAS
    AFTER INSERT OR DELETE ON CATEGORIAS
    FOR EACH ROW
BEGIN
    IF DELETING THEN
        INSERT INTO AUDITACATEGORIAS(FECHA, ID_CATEGORIA, TIPO_OPERACION)
        VALUES(TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI'), :OLD.ID_CATEGORIA, 
            ' BORRADO');
    ELSIF INSERTING THEN
        INSERT INTO AUDITACATEGORIAS (FECHA, ID_CATEGORIA, TIPO_OPERACION)
        VALUES(TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI'), :NEW.ID_CATEGORIA,
            ' INSERCION');
    END IF;
END;
/

SELECT * 
FROM CATEGORIAS;
/
INSERT INTO CATEGORIAS
VALUES(8, 'MOTOS');
/
SELECT *
FROM AUDITACATEGORIAS;
/
SELECT *
FROM CATEGORIAS;
/
DELETE FROM CATEGORIAS
WHERE ID_CATEGORIA = 8;
/
SELECT *
FROM AUDITACATEGORIAS;
/

/*2. Escribir un trigger que permita auditar las modificaciones en la tabla CATEGORIAS, según las siguientes
especificaciones:
a. Añadir la columna datos a la tabla AUDITACATEGORIA, en la que se insertará texto.
b. Cuando se produzca cualquier manipulación, se insertará una fila en dicha tabla que contendrá (en
la columna correspondiente):
Fecha y hora, Id de la categoría, la operación de actualización MODIFICACIÓN, y el valor anterior
y nuevo de cada columna modificada (esto último se insertará en la columna datos).*/

DROP TRIGGER IN_DEL_CATEGORIAS; --BORRAR PARA Q NO SE EJECUTE 2 VECES AL INSERTAR O DELETE

ALTER TABLE AUDITACATEGORIAS
ADD (DATOS VARCHAR2(200));

CREATE OR REPLACE TRIGGER UP_IN_DEL_CATEGORIAS
    AFTER INSERT OR UPDATE OR DELETE ON CATEGORIAS
    FOR EACH ROW
BEGIN
    IF DELETING THEN
        INSERT INTO AUDITACATEGORIAS(FECHA, ID_CATEGORIA, TIPO_OPERACION, DATOS)
        VALUES(TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI'), :OLD.ID_CATEGORIA, 
            ' BORRADO', 'VALOR ANTIGUO: ID: ' || :OLD.ID_CATEGORIA || 
            ' DESCRIPCION: ' || :OLD.DESCRIPCION);
    ELSIF INSERTING THEN
        INSERT INTO AUDITACATEGORIAS (FECHA, ID_CATEGORIA, TIPO_OPERACION, DATOS)
        VALUES(TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI'), :NEW.ID_CATEGORIA,
            ' INSERCION', 'VALOR NUEVO: ID: ' || :NEW.ID_CATEGORIA || 
            ' DESCRIPCION: ' || :NEW.DESCRIPCION);
    ELSIF UPDATING('DESCRIPCION') THEN     
        INSERT INTO AUDITACATEGORIAS (FECHA, ID_CATEGORIA, TIPO_OPERACION, DATOS)
        VALUES(TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI'), :NEW.ID_CATEGORIA,
            ' ACTUALIZACION. ', 'VALOR ANTIGUO: ID: ' || :OLD.ID_CATEGORIA || 
            ' DESCRIPCION: ' || :OLD.DESCRIPCION || '. VALOR NUEVO: ID: '
            || :NEW.ID_CATEGORIA || ' DESCRIPCION: ' ||
            :NEW.DESCRIPCION);
    END IF;
END;
/

SELECT * 
FROM CATEGORIAS;
/
INSERT INTO CATEGORIAS
VALUES(8, 'MOTOS');
/
SELECT *
FROM AUDITACATEGORIAS;
/
SELECT *
FROM CATEGORIAS;
/
UPDATE CATEGORIAS
SET DESCRIPCION = 'COCHES'
WHERE ID_CATEGORIA = 8;
/
SELECT *
FROM AUDITACATEGORIAS;
/
SELECT *
FROM CATEGORIAS;
/
DELETE FROM CATEGORIAS
WHERE ID_CATEGORIA = 8;
/
SELECT *
FROM AUDITACATEGORIAS;
/





/*3. Añade las siguientes columnas a la tabla CLIENTES: fecha_modificacion de tipo date, tipo_modificación
(inserción, actualización o borrado) y modificado_por de tipo texto.
Realiza un programa que cree una secuencia llamada seq_id_cliente que empiece por el número
siguiente al identificador más alto de la tabla CLIENTES y que vaya aumentando de 1 en 1.
Crea ahora un trigger de modo que, cada vez que se realice una inserción en la tabla CLIENTES se
inserten en los campos fecha_modificación, tipo_modificación y modificado_por: la fecha en que se ha
realizado la inserción, el tipo de modificación que es (INSERCIÓN) y el usuario de la base de datos que
ha realizado dicha inserción, respectivamente, y como identificador del cliente se va a insertar el
siguiente valor de la secuencia creada anteriormente. 
*/

ALTER TABLE CLIENTES ADD (
    fecha_modificacion DATE,
    tipo_modificacion VARCHAR2(20),
    modificado_por VARCHAR2(50)
);

CREATE OR REPLACE PROCEDURE SEQ_ID_CLIENTE

IS
    v_max_id NUMBER;
BEGIN
    SELECT MAX(id_cliente)
    INTO v_max_id 
    FROM CLIENTES;
       
    CREATE SEQUENCE SEQ_ID_CLIENTE
    START WITH V_MAX_ID + 1
    INCREMENT BY 1;
    
END;
/

CREATE OR REPLACE TRIGGER CLIENTES_INSERT
    BEFORE INSERT ON CLIENTES
    FOR EACH ROW
BEGIN
    INSERT INTO CLIENTES (FECHA_MODIFICACION, TIPO_MODIFICACION, MODIFICADO_POR)
    VALUES (SYSDATE, ' INSERCION ', USER);
END;
/




/*4. Modifica el trigger del ejercicio anterior para que haga lo siguiente:
a. Cada vez que se inserta una fila en la tabla CLIENTES haga lo mismo que en el ejercicio
anterior.
b. Cada vez que se modifica una fila de la tabla CLIENTES inserte la fecha de modificación, tipo
de modificación (ACTUALIZACIÓN) y la persona que lo ha modificado en las columnas
respectivas.
¡TENER EN CUENTA QUE EL IDENTIFICADOR DEL CLIENTE SOLO SE DEBE CAMBIAR CUANDO SE
HACE UNA INSERCIÓN EN LA TABLA!*/
CREATE OR REPLACE TRIGGER CLIENTES_INSERT
    BEFORE INSERT OR UPDATE ON CLIENTES
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO CLIENTES (FECHA_MODIFICACION, TIPO_MODIFICACION, MODIFICADO_POR)
        VALUES (SYSDATE, ' INSERCION ', USER);
    ELSIF updating THEN
        INSERT INTO CLIENTES (FECHA_MODIFICACION, TIPO_MODIFICACION, MODIFICADO_POR)
        VALUES (SYSDATE, ' ACTUALIZACION ', USER);
    END IF;
END;
/

UPDATE CLIENTES 
SET NOMBRE = 'Mariano', APELLIDOS = 'Clavero'
WHERE ID_CLIENTE = (SELECT ID_CLIENTE
                    FROM CLIENTES
                    WHERE NOMBRE = 'Eder');


select *from clientes;



/*5. Ejecuta el script poblaciones.txt que creará una nueva tabla POBLACIONES que contendrá poblaciones
con códigos postales.
Ahora crea un trigger que no permita insertar clientes nuevos en la base de datos cuyo código postal no
se encuentre en la tabla POBLACIONES. */

CREATE OR REPLACE TRIGGER NO_INSERTAR_CLIENTES
    BEFORE INSERT ON CLIENTES
    FOR EACH ROW
BEGIN
    
END;
