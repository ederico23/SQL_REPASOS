/*2. Escribir un trigger que permita auditar las modificaciones en la tabla CATEGORIAS, según las siguientes
especificaciones:
a. Añadir la columna datos a la tabla AUDITACATEGORIA, en la que se insertará texto.
b. Cuando se produzca cualquier manipulación, se insertará una fila en dicha tabla que contendrá (en
la columna correspondiente):
Fecha y hora, Id de la categoría, la operación de actualización MODIFICACIÓN, y el valor anterior
y nuevo de cada columna modificada (esto último se insertará en la columna datos).*/



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
            ' ACTUALIZACION. ', 'VALOR ANTIGUO: ' || 
            ' DESCRIPCION: ' || :OLD.DESCRIPCION || '. VALOR NUEVO: '
            || 'DESCRIPCION: ' ||
            :NEW.DESCRIPCION);
    ELSIF UPDATING('ID_CATEGORIA') THEN     
        INSERT INTO AUDITACATEGORIAS (FECHA, ID_CATEGORIA, TIPO_OPERACION, DATOS)
        VALUES(TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI'), :NEW.ID_CATEGORIA,
            ' ACTUALIZACION. ', 'VALOR ANTIGUO: ' || 
            ' ID: ' || :OLD.ID_CATEGORIA || '. VALOR NUEVO: '
            || 'ID: ' ||
            :NEW.ID_CATEGORIA);
    END IF;
END;
/
