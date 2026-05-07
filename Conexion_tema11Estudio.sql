--------------------------------------------------------------------------------
----------------------------------HOJA 1----------------------------------------
--------------------------------------------------------------------------------

/*1. Crear una vista DEP30 que contiene el APELLIDO, el OFICIO, y el SALARIO de los
empleados de la tabla EMPLE del departamento 30. Después comprobar
descripción y contenido.*/
CREATE OR REPLACE VIEW DEP30 AS
SELECT APELLIDO, OFICIO, SALARIO
FROM EMPLE
WHERE DEPT_NO = 30;

DESC DEP30;


/*2. Hacer lo mismo que en el ejercicio anterior dando nombres distintos a las
columnas.
Para reemplazar la vista, que ya existe al haberla creado en el ejercicio anterior,
acuérdate de utilizar la sentencia OR REPLACE.*/
CREATE OR REPLACE VIEW DEP30 AS
SELECT APELLIDO AS LAST_NAME, OFICIO AS JOB, SALARIO AS SALARY
FROM EMPLE
WHERE DEPT_NO = 30;

DESC DEP30;


/*3. Crear la vista VDEP a partir de la tabla DEPART con las columnas dept_no y
dnombre. A partir de la vista anterior ambiar el nombre del departamento 20 a
‘nuevo20’*/

CREATE OR REPLACE VIEW VDEP AS
SELECT DEPT_NO, DNOMBRE
FROM DEPART;

UPDATE VDEP
SET DNOMBRE = 'nuevo20' 
WHERE DEPT_NO = 20;


/*4. Crear una vista a partir de las tablas EMPLE y DEPART que contenga las
columnas EMP_NO, APELLIDO, DEPT_NO y DNOMBRE. Probar a insertar, a
modificar y a borrar filas.*/
CREATE OR REPLACE VIEW EMPLE_DEPART AS
SELECT E.EMP_NO, E.APELLIDO, D.DEPT_NO, D.DNOMBRE
FROM EMPLE E 
JOIN DEPART D ON E.DEPT_NO = D.DEPT_NO;

--SI INSERTAMOS SALE ERROR
--SI ACTUALIZAMOS QUE PERTENEZCA A UNA TABLA BIEN
--SI ACTUALIZAMOS QUE PERTENEZCA A VARIAS TABLAS MAL
--SI BORRAMOS ERROR


/*5. Crear una vista llamada pagos a partir de las filas de la tabla EMPLE, cuyo
departamento sea el 10. Las columnas de la vista se llamarán NOMBRE,
SAL_MES. SAL_AN y DEPT_NO. El NOMBRE es la columna APELLIDO, al que
aplicamos la función INITCAP(), SAL_MES es el SALARIO, SAL_AN es el
salario*12.
Modificar individualmente cada columna y ver qué ocurre. (Hacer rollback después
de cada actualización)*/

CREATE OR REPLACE VIEW PAGOS AS
SELECT INITCAP(APELLIDO) AS NOMBRE, SALARIO AS SAL_MES, (SALARIO*12) AS SAL_AN, DEPT_NO
FROM EMPLE
WHERE DEPT_NO = 10;

--ERROR
UPDATE PAGOS
SET NOMBRE = 'Pedro';
ROLLBACK;

--SI SE PUEDE
UPDATE PAGOS
SET SAL_MES = 1200;
ROLLBACK;

--ERROR
UPDATE PAGOS
SET SAL_AN = 18000;
ROLLBACK;


/*6. Crear la vista VMEDIA a partir de las tablas EMPLE y DEPART. La vista contendrá
por cada departamento el número de departamento, el nombre, la media de
salario y el máximo salario.
Visualizar su contenido y tratar de borrar filas, insertar y modificar*/

CREATE OR REPLACE VIEW VMEDIA AS
SELECT D.DEPT_NO, D.DNOMBRE, AVG(E.SALARIO) AS MEDIA_SALARIO, MAX(E.SALARIO) AS MAX_SALARIO
FROM DEPART D
JOIN EMPLE E ON D.DEPT_NO = E.DEPT_NO
GROUP BY D.DEPT_NO, D.DNOMBRE;

--VIASUALIZAR
SELECT *
FROM VMEDIA;

--BORRAR FILAS(ERROR)
DELETE FROM VMEDIA
WHERE DEPT_NO = (SELECT MIN(DEPT_NO)
                 FROM VMEDIA);

--INSERTAR FILAS(ERROR)
INSERT INTO VMEDIA (DEPT_NO, DNOMBRE, SALARIO)
VALUES(
       (SELECT MAX(DEPT_NO) + 1),
       'Eder',
       1600
      );
      
--ACTUALIZAR (ERROR)
UPDATE VMEDIA
SET DNOMBRE = 'Fede'
WHERE DEPT_NO = 5;

--MODIFICAR
CREATE OR REPLACE VIEW VMEDIA AS
SELECT D.DEPT_NO, D.DNOMBRE, ROUND(AVG(E.SALARIO),2) AS MEDIA_SALARIO, MAX(E.SALARIO) AS MAX_SALARIO
FROM DEPART D
JOIN EMPLE E ON D.DEPT_NO = E.DEPT_NO
GROUP BY D.DEPT_NO, D.DNOMBRE;


/*7. Crear el sinónimo DEPARTAMENTOS asociado a la tabla DEPART.*/
CREATE SYNONYM DEPARTAMENTOS FOR DEPART;

SELECT * FROM DEPART;
SELECT * FROM DEPARTAMENTOS;

/*8. Crear un sinónimo llamado Conser asociado a la vista creada antes (vmedia).
Hacer consultas utilizando este sinónimo*/
CREATE SYNONYM CONSER FOR VMEDIA;

SELECT DNOMBRE
FROM CONSER
WHERE DEPT_NO = 10;






















































