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