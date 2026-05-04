--------------------------------------------------------------------------------
----------------------------------HOJA 1----------------------------------------
--------------------------------------------------------------------------------

/*1. Crear una vista DEP30 que contiene el APELLIDO, el OFICIO, y el SALARIO de los
empleados de la tabla EMPLE del departamento 30. Después comprobar
descripción y contenido.*/

--CREAR LA VISTA
CREATE VIEW DEP30 AS 
SELECT APELLIDO, OFICIO, SALARIO
FROM EMPLE
WHERE DEPT_NO = 30;

--MIRAR LAS COLUMNAS Q TIENE Y SU TIPO
DESC DEP30;


/*2. Hacer lo mismo que en el ejercicio anterior dando nombres distintos a las
columnas.
Para reemplazar la vista, que ya existe al haberla creado en el ejercicio anterior,
acuérdate de utilizar la sentencia OR REPLACE.*/

CREATE OR REPLACE VIEW DEP30 AS
SELECT APELLIDO AS EMPLE_APE, OFICIO AS TRABAJO, SALARIO AS SALARY
FROM EMPLE
WHERE DEPT_NO = 30;

DESC DEP30;

/*3. Crear la vista VDEP a partir de la tabla DEPART con las columnas dept_no y
dnombre. A partir de la vista anterior ambiar el nombre del departamento 20 a
‘nuevo20’*/

--CREAMOS VISTA
CREATE OR REPLACE VIEW VDEP AS
SELECT DEPT_NO, DNOMBRE
FROM DEPART;

--MODIFICAMOS
UPDATE VDEP
SET DNOMBRE = 'nuevo20'
where DEPT_NO = 20;

SELECT * FROM DEPART;


/*4. Crear una vista a partir de las tablas EMPLE y DEPART que contenga las
columnas EMP_NO, APELLIDO, DEPT_NO y DNOMBRE. Probar a insertar, a
modificar y a borrar filas.*/

CREATE OR REPLACE VIEW EMPLE_DEPART AS
SELECT E.EMP_NO, E.APELLIDO, D.DEPT_NO, D.DNOMBRE
FROM EMPLE E
JOIN DEPART D ON E.DEPT_NO = D.DEPT_NO;

DESC EMPLE_DEPART;

--si se puede
UPDATE EMPLE_DEPART
SET APELLIDO = 'Gracia'
WHERE EMP_NO = 7369;

--solo deja de una tabla, no de la vista
DELETE FROM EMPLE
WHERE EMP_NO = 7369;

--solo deja d euna tabla, no de la vista
INSERT INTO EMPLE_DEPART (EMP_NO, APELLIDO, DEPT_NO)
VALUES (8888, 'FERNANDEZ', 10);


/*5. Crear una vista llamada pagos a partir de las filas de la tabla EMPLE, cuyo
departamento sea el 10. Las columnas de la vista se llamarán NOMBRE,
SAL_MES. SAL_AN y DEPT_NO. El NOMBRE es la columna APELLIDO, al que
aplicamos la función INITCAP(), SAL_MES es el SALARIO, SAL_AN es el
salario*12.
Modificar individualmente cada columna y ver qué ocurre. (Hacer rollback después
de cada actualización)*/
CREATE OR REPLACE VIEW PAGOS AS
SELECT








