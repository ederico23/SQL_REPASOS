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
