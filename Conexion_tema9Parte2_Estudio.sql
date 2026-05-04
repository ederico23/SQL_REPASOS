/*1. Encuentra el tipo de oficio, job_id, que más empleados tiene (debe aparecer también
el número de esos empleados)*/
SELECT *
FROM (
    SELECT JOB_ID, COUNT(*) AS NUM_EMPLEADOS
    FROM EMPLOYEES 
    GROUP BY JOB_ID
    ORDER BY NUM_EMPLEADOS DESC)
WHERE ROWNUM = 1;


/*2.- Cuántos departamentos hay en total entre China (China) y Japón (Japan)*/
SELECT COUNT(D.DEPARTMENT_ID) AS TOTAL_DEPTS
FROM DEPARTMENTS D
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
WHERE C.COUNTRY_NAME IN ('China', 'Japan');


/*3.- Cuántos departamentos distintos hay en Toronto. Muestra también su ubicación
(location_id)*/
SELECT L.LOCATION_ID, COUNT(D.DEPARTMENT_ID) AS TOTAL_DEPTS
FROM LOCATIONS L 
JOIN DEPARTMENTS D ON L.LOCATION_ID = D.LOCATION_ID
WHERE UPPER(L.CITY) = 'TORONTO'
GROUP BY L.LOCATION_ID
ORDER BY L.LOCATION_ID;


/*4.- Visualizar los departamentos en los que el salario medio es mayor o igual que la media de
todos los salarios*/
SELECT DEPARTMENT_ID, ROUND(AVG(SALARY),2) AS SALARIO_MEDIO
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= (SELECT AVG(SALARY)
                        FROM EMPLOYEES);--COMPARA EL SALARIO MEDIO DE ESE DEPT CON EL RESTO DE EMPLEADOS
                        
                        
/*5.- Encuentra el cargo (job_id), que más empleados tiene (debe aparecer el número de esos
empleados)*/                        
SELECT *
FROM (SELECT JOB_ID, COUNT(EMPLOYEE_ID) AS NUM_EMPLEADOS
    FROM EMPLOYEES
    GROUP BY JOB_ID
    ORDER BY NUM_EMPLEADOS DESC)
WHERE ROWNUM = 1;


/*6.- Visualizar el número de empleados del departamento de VENTAS*/
SELECT COUNT(EMPLOYEE_ID) AS NUM_EMPLEADOS
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE UPPER(DEPARTMENT_NAME) = 'SALES');


/*7.- En la tabla empleados, visualiza para cada uno de los jefes, manager_id, el nº de empleados
que están a su cargo y la media de los salarios de estos empleados pero solo para aquellos
jefes que tienen 4,5 ó 6 empleados, la media de los salarios debe aparecer con dos decimales
solamente.*/
SELECT MANAGER_ID, COUNT(EMPLOYEE_ID), ROUND(AVG(SALARY),2) AS SALARIOS
FROM EMPLOYEES
GROUP BY MANAGER_ID
HAVING COUNT(MANAGER_ID) IN (4,5,6);


/*8.- Visualiza los nombres de los continentes con más de seis países en la tabla countries*/
SELECT R.REGION_NAME
FROM REGIONS R
JOIN COUNTRIES C ON R.REGION_ID = C.REGION_ID
GROUP BY R.REGION_NAME
HAVING COUNT(C.COUNTRY_ID) >6;


/*9.- Selecciona los empleados cuyo salario sea superior al salario medio de los empleados que
son representantes de ventas (job_id=’SA_MAN’)*/
SELECT EMPLOYEE_ID
FROM EMPLOYEES
WHERE SALARY > (SELECT ROUND(AVG(SALARY),2)
                FROM EMPLOYEES
                WHERE UPPER(JOB_ID) = 'SA_MAN');


/*10.- Encuentra los nombres de los empleados más antiguos de cada departamento (debes
mostrar el department_id y el nombre y el apellido del empleado)*/
SELECT DEPARTMENT_ID, FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE (DEPARTMENT_ID, HIRE_DATE) IN ( --BUSCAR AL EMPLEADO Q COINCIDA SU DEPT Y HIRE_DATE CON
                                    SELECT DEPARTMENT_ID, MIN(HIRE_DATE) -- EL DEPT Y LA FECHA MIN DE HIRE_DATE
                                    FROM EMPLOYEES
                                    GROUP BY DEPARTMENT_ID
                                    )
ORDER BY DEPARTMENT_ID;


/*11.- 2.-Selecciona el nombre, apellidos y el nombre del departamento de los empleados que
no trabajan en New York*/
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE UPPER(L.CITY) NOT IN ('NEW YORK');


/*12.- Obtener el apellido de los empleados junto con el apellido de su correspondiente jefe
ordenado por el apellido del jefe. Haced el ejercicio de dos maneras, suponiendo unión
interna y suponiendo unión externa.*/
--inner join interna
SELECT E.LAST_NAME AS EMPLEADO, J.LAST_NAME AS JEFE
FROM EMPLOYEES E
JOIN EMPLOYEES J ON E.MANAGER_ID = J.EMPLOYEE_ID --CODIGO DEL JEFE(J) DE MI EMPLEADO (E) DEBE SER EL CODIGO DE EMPLEADO DE LA TABLA J
ORDER BY JEFE;

--left join externa
SELECT E.LAST_NAME AS EMPLEADO, J.LAST_NAME AS JEFE
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES J ON E.MANAGER_ID = J.MANAGER_ID --LEFT JOIN HACE QUE PONGA TODOS LOS Q ESTEN EN LA IZQ, AUNQ NO PAREJA
ORDER BY JEFE;


/*13.- A partir de la tabla employees, obtener la fecha de alta, de manera que aparezca el
nombre del mes con todas sus letras, el número del día del mes, y el año, pero solo para
aquellos empleados que tienen jefe*/

SELECT TO_CHAR(HIRE_DATE, 'MONTH') AS MES, TO_CHAR(HIRE_DATE, 'dd') AS DIA, TO_CHAR(HIRE_DATE, 'YYYY') AS AÑO
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL;

