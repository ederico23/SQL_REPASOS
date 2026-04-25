--------------------------------------------------------------------------------
---------------------------------HOJA 2-----------------------------------------
--------------------------------------------------------------------------------

/*42) Selecciona los datos de los empleados que trabajan en el departamento 80, pero la
columna de la comisión tiene que aparecer redondeado a un decimal. */
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, ROUND(E.COMMISSION_PCT, 1) AS COMMISSION, MANAGER_ID, DEPARTMENT_ID
FROM EMPLOYEES E
WHERE DEPARTMENT_ID = 80;


/*43) Crea una consulta que calcule la raíz cuadrada de 49*/
SELECT SQRT(49)
FROM DUAL;


/*44) Crea una consulta que calcule la raíz cuadrada de 36 y le sume el valor absoluto de (-9)*/
SELECT SQRT(36)+ ABS(-9)
FROM DUAL;



/*45) Muestra el título de los trabajos de los empleados del departamento de “Accounting”
pero debe aparecer totalmente en mayúsculas. */
SELECT UPPER(J.JOB_TITLE)
FROM JOBS J
JOIN EMPLOYEES E ON J.JOB_ID = E.JOB_ID
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE UPPER(DEPARTMENT_NAME) = 'ACCOUNTING';


/*46) Ahora muestra el nombre y apellidos de todos los empleados en una sola columna,
ordenados primero por apellido y luego por nombre y que aparezca todo en minúsculas.*/
SELECT LOWER(FIRST_NAME || ' ' || LAST_NAME)
FROM EMPLOYEES
ORDER BY LAST_NAME, FIRST_NAME;

/*47) Obtén los datos de los empleados cuyo nombre tenga una longitud mayor de 5
caracteres. */
SELECT *
FROM EMPLOYEES
WHERE LENGTH(FIRST_NAME) > 5;


/*48) Obtén los datos de los empleados cuyo jefe trabaje en un departamento que tenga
un nombre de más de 10 caracteres. */
SELECT E.*
FROM EMPLOYEES E
JOIN EMPLOYEES J ON E.MANAGER_ID = J.MANAGER_ID --UNIMOS EMPLEADOS CON EMPLEADOS JEFE
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID --JEFE CON DEPARTAMENTO
WHERE LENGTH(D.DEPARTMENT_NAME) > 10;

/*49) Muestra todos los empleados cuyo nombre empieza por A, pero debes sustituir la
primera letra b que aparezca en esos nombres por v en todos. */
SELECT REPLACE(FIRST_NAME, 'b', 'v') AS NOMBRE_MODIFICADO, LAST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'A%';

/*50) Muestra el nombre y la comisión de todos los empleados del departamento de
“Marketing” o “Sales”, en caso de que el valor sea nulo de aparecer el texto “SIN
COMISIÓN”.*/

SELECT E.FIRST_NAME,NVL(TO_CHAR(E.COMMISSION_PCT), 'SIN COMISION') AS COMISION
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE UPPER(D.DEPARTMENT_NAME) IN ('MARKETING', 'SALES');



/*51) Para cada empleado muestra nombre, apellidos y la diferencia de tiempo en años
que hay entre el comiendo (start_date) y el final (end_date) de cada trabajo que ha
realizado (en la tabla job_history). */
SELECT E.FIRST_NAME,E.LAST_NAME, ROUND((JH.END_DATE - JH.START_DATE) / 365, 2) AS DIFERNCIA_TRABAJO
FROM EMPLOYEES E
JOIN JOB_HISTORY JH ON E.EMPLOYEE_ID = JH.EMPLOYEE_ID;

/*52) Para cada empleado muestra su nombre y apellidos y el año en que fue contratado
(sólo el año). */
SELECT FIRST_NAME, LAST_NAME, TO_CHAR(HIRE_DATE, 'YYYY')
FROM EMPLOYEES;

/*53) Ahora muestra las mismas columnas que en la consulta anterior, pero la fecha de
contratación (hire_date), debe aparecer en el siguiente formato (‘dd-mm-yyyy’).
Hay que utilizar la función TO_CHAR. */
SELECT FIRST_NAME, LAST_NAME, TO_CHAR(HIRE_DATE, 'dd-MM-YYYY')
FROM EMPLOYEES;


--------------------------------------------------------------------------------
----------------------------------FECHAS----------------------------------------
--------------------------------------------------------------------------------

/*1.- Muestra el apellido y el número de semanas que llevan contratados todos los trabajadores del
departamento 110. Redondea el número para que no salgan decimales y pon nombre a esta
columna. */
SELECT LAST_NAME, ROUND(((SYSDATE - HIRE_DATE)/7), 0) AS SEMANAS_TRABAJO
FROM EMPLOYEES 
WHERE DEPARTMENT_ID = 110;

/*2.- Muestra el apellido, la fecha de contratación con el formato DD-MON-YYYY y el número
del jefe de cada empleado. Si algún empleado no tiene jefe debe aparecer la expresión “No tiene
jefe”. Poner un alias a la columna de la fecha y a la del jefe.*/
SELECT LAST_NAME, TO_CHAR(HIRE_DATE, 'DD-MON-YYYY') AS FECHA_CONTRATACION, NVL(TO_CHAR(MANAGER_ID), 'No tiene jefe') AS JEFE
FROM EMPLOYEES;

/*3.- Muestra todos los datos de los empleados ordenados descendentemente por la fecha de
contratación. La fecha debe aparecer así: Ej.: 1980, 14 de enero. Ponle alias a la fecha. */

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, TO_CHAR(HIRE_DATE, 'YYYY, DD "de" MONTH') AS FECHA_FORMATEADA, 
    JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
FROM EMPLOYEES
ORDER BY HIRE_DATE DESC;


/*4.- Muestra el nombre y el apellido de los empleados que ganan más de 2000 dólares y cuya fecha
de contratación es anterior al 5/5/2003.*/
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE SALARY > 2000 AND HIRE_DATE <  TO_DATE('05/05/2003', 'DD/MM/YYYY');


/*5.- Si la Guerra de la Independencia fue en 1808, cuántos años han pasado. Escribe la sentencia
en SQL que permite hacer dicho cálculo. */
SELECT (TO_CHAR(SYSDATE, 'YYYY')-1808) AS DIFERENCIA_AÑOS
FROM DUAL;

/*6.- Muestra todos los empleados (apellido y fecha de alta) contratados después de junio sin
importar el año. Ordena el resultado por la fecha. */
SELECT LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'MM') > 06
ORDER BY HIRE_DATE;


/*7.- Obtén un informe con los empleados y la fecha de contratación de todos los empleados
contratados después de sus jefes. En el informe debe aparecer el apellido del empleado, su fecha
de contratación, el apellido de su jefe y la fecha de contratación. El formato de la fecha en los dos
casos debe ser del tipo: ej.: 20 de marzo de 2015. */
SELECT E.LAST_NAME AS EMPLEADO, 
       TO_CHAR(E.HIRE_DATE, 'DD "de" MONTH "de" YYYY') AS FECHA_EMPLEADO,
       J.LAST_NAME AS JEFE,
       TO_CHAR(J.HIRE_DATE, 'DD "de" MONTH "de" YYYY') AS FECHA_JEFE
FROM EMPLOYEES E
JOIN EMPLOYEES J ON E.MANAGER_ID = J.EMPLOYEE_ID
WHERE E.HIRE_DATE > J.HIRE_DATE;