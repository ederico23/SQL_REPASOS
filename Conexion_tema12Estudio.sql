/*Ejemplo1. En el siguiente ejemplo se borra el departamento número 20. Previamente, se crea un
departamento provisional al que se asignan los empleados del departamento 20, paro no borrarlos. También
se informa del número de empleados afectados.
Para que se visualice el resultado, es necesario modificar la variable de entorno SERVEROUTPUT, es decir,
tendremos que escribir: SET SERVEROUTPUT ON. */

SET serveroutput ON;
DECLARE
v_num_empleados NUMBER(2);
BEGIN
 INSERT INTO depart VALUES (99,'PROVISIONAL',NULL);
 UPDATE emple SET dept_no =99 WHERE dept_no = 20;
 v_num_empleados := SQL%ROWCOUNT ;
 DELETE FROM depart WHERE dept_no = 20;
 DBMS_OUTPUT.PUT_LINE(v_num_empleados|| ' empleados ubicados en PROVISIONAL');
EXCEPTION
 WHEN OTHERS THEN
 ROLLBACK;
 RAISE_APPLICATION_ERROR(-20000, 'Error en la aplicación');
END;
/
--------------------------------------------------------------------------------
---------------------------------HOJA 1-----------------------------------------
--------------------------------------------------------------------------------

/*1. Escribir un bloque PL/SQL que escriba el texto ‘Hola’*/
BEGIN
    DBMS_OUTPUT.PUT_LINE('hola');
END;
/


/*2. Escribir un procedimiento que reciba dos números y visualice su suma.*/
CREATE OR REPLACE PROCEDURE suma(
--parametros
    v_num_n1 IN NUMBER, --variable 1
    v_num_n2 IN NUMBER) -- variable 2
IS
--variables locales, resultados, o cosas q no se tienen q meter a la hora de llamar al metodo
    v_num_resultado NUMBER;
BEGIN
    v_num_resultado := v_num_n1 + v_num_n2; --meter el resultado de la suma de los numeros en resultado
    DBMS_OUTPUT.PUT_LINE('La suma de '|| v_num_n1 || ' y ' || v_num_n2 || ' es '|| v_num_resultado); --concatenar el resutlado
END suma;
/
EXECUTE suma(5,3);
/

--SELECCIONAR EL PROCEDIMIENTO F5, LUEGO EL EXECUTE F5


/*3. Codificar un procedimiento que reciba una cadena y la visualice al revés.*/
CREATE OR REPLACE PROCEDURE escribir_alReves(
--parametros
    v_string_palabra IN VARCHAR2) --variable 1
IS  
--variables localaes
    v_string_palabraReves VARCHAR2(32767); --donde vamos a meter la palabra al reves
    v_num_contador NUMBER := LENGTH(v_string_palabra); --contador de letras q tiene la palabra escrita
BEGIN
    WHILE v_num_contador > 0 LOOP --bucle mientras el contador de las letras sea > 0
        --palabraReves = nada + ultima letra, asi todo el rato   -- substr(palabra inicial, letra a coger, num de letras)
        v_string_palabraReves := v_string_palabraReves || SUBSTR(v_string_palabra, v_num_contador, 1);
        v_num_contador := v_num_contador - 1; --restar 1 al contador
    END LOOP;        
    DBMS_OUTPUT.PUT_LINE(v_string_palabraReves);
END escribir_alReves;
/
EXECUTE escribir_alReves('Hola');
/


/*4. Escribir una función que reciba una fecha y devuelva el año, en número,
correspondiente a esa fecha.*/

--TIENE Q SER UNA FUNCION
CREATE OR REPLACE FUNCTION devolver_anno(
--parametros
    v_date_fecha IN DATE)
RETURN NUMBER
IS
--variables locales
    v_string_annoNum NUMBER;
BEGIN
     v_string_annoNum := TO_CHAR(v_date_fecha, 'YYYY');--asignar el año de la fecha escrita a la variable
     RETURN v_string_annoNum; --devolver la variable
END devolver_anno;
/

--select function(todate pq es una fecha(fecha, formato)) from dual
SELECT devolver_anno(TO_DATE('05/10/2007', 'DD/MM/YYYY')) AS AÑO_DEVOLVER
FROM DUAL;
/

/*5. Escribir un bloque PL/SQL que haga uso de la función anterior.*/
BEGIN
    DBMS_OUTPUT.PUT_LINE(devolver_anno(TO_DATE('05/10/2007', 'DD/MM/YYYY')));
END;
/

/*6. Dado el siguiente procedimiento:
CREATE OR REPLACE PROCEDURE crear_depart (
 p_num_dept depart.dept_no%TYPE,
 p_dnombre depart.dnombre%TYPE DEFAULT 'PROVISIONAL',
 p_loc depart.loc%TYPE DEFAULT 'PROVISIONAL')
IS
BEGIN
 INSERT INTO depart
 VALUES (p_num_dept, p_dnombre, p_loc);
END crear_depart;
Indicar cuáles de las siguientes llamadas son correctas y cuáles incorrectas, en este
último caso escribir la llamada correcta usando la notación posicional (en los casos que
se pueda):
1º. crear_depart; --NO SE PUEDE
2º. crear_depart(50); --SI SE PUEDE
3º. crear_depart('COMPRAS'); --NO SE PUEDE
4º. crear_depart(50,'COMPRAS'); --NO SE PUEDE
5º. crear_depart('COMPRAS', 50); --NO SE PUEDE
6º. crear_depart('COMPRAS', 'VALENCIA'); --NO SE PUEDE
7º. crear_depart(50, 'COMPRAS', 'VALENCIA'); --NO SE PUEDE
8º. crear_depart('COMPRAS', 50, 'VALENCIA'); --NO SE PUEDE
9º. crear_depart('VALENCIA', ‘COMPRAS’);--NO SE PUEDE
10º. crear_depart('VALENCIA', 50);*/--NO SE PUEDE

EXECUTE crear_depart;--NO SE PUEDE
/
EXECUTE crear_depart(50); --SI SE PUEDE
/
EXECUTE crear_depart('COMPRAS'); --NO SE PUEDE
/
EXECUTE crear_depart(50,'COMPRAS'); --SI SE PUEDE
/
EXECUTE crear_depart('COMPRAS', 50); --NO SE PUEDE
/
EXECUTE crear_depart('COMPRAS', 'VALENCIA'); --NO SE PUEDE
/
EXECUTE crear_depart(50, 'COMPRAS', 'VALENCIA'); --SI SE PUEDE
/
EXECUTE crear_depart('COMPRAS', 50, 'VALENCIA'); --NO SE PUEDE
/
EXECUTE crear_depart('VALENCIA', 'COMPRAS');--NO SE PUEDE
/
EXECUTE crear_depart('VALENCIA', 50);*/--NO SE PUEDE
/



/*7. Desarrollar una función que devuelva el número de años completos que hay entre dos
fechas que se pasan como argumentos.*/
CREATE OR REPLACE FUNCTION diferencia_anno(
--parametros
    v_date_fecha1 IN DATE,
    v_date_fecha2 IN DATE)
RETURN NUMBER
IS
--variables locales
    v_num_fecha1 NUMBER;
    v_num_fecha2 NUMBER;
    v_num_diferencia NUMBER;
BEGIN
     --v_num_fecha1 := TO_CHAR(v_date_fecha1,'dd/MM/YYYY');
     --v_num_fecha2 := TO_CHAR(v_date_fecha2,'dd/MM/YYYY');
     v_num_diferencia := MONTHS_BETWEEN(v_date_fecha1, v_date_fecha2);
     RETURN TRUNC(ABS(v_num_diferencia/12));
END diferencia_anno;
/

SELECT diferencia_anno(TO_DATE('05/10/2007', 'dd/MM/YYYY'), TO_DATE('05/10/2026', 'dd/MM/YYYY')) as DIFERENCIA FROM DUAL;
/


/*8. Escribir una función que, haciendo uso de la función anterior devuelva los trienios que
hay entre dos fechas. (Un trienio son tres años completos).*/
CREATE OR REPLACE FUNCTION calcular_trienio(
--parametros
    v_date_fecha1 IN DATE,
    v_date_fecha2 IN DATE)
RETURN NUMBER
IS
BEGIN
     RETURN TRUNC(diferencia_anno(v_date_fecha1, v_date_fecha2) / 3);
END calcular_trienio;
/

SELECT calcular_trienio(TO_DATE('05/10/2007', 'dd/MM/YYYY'), TO_DATE('05/10/2026', 'dd/MM/YYYY')) as DIFERENCIA FROM DUAL;
/


/*9. Codificar un procedimiento que reciba una lista de hasta 5 números y visualice su
suma.*/
CREATE OR REPLACE PROCEDURE sumaNumeros(
--parametros
    v_num1 IN NUMBER,
    v_num2 IN NUMBER,
    v_num3 IN NUMBER,
    v_num4 IN NUMBER,
    v_num5 IN NUMBER)
IS 
    v_num_resultado NUMBER;
BEGIN
    v_num_resultado := (v_num1 + v_num2 + v_num3 + v_num4 + v_num5);
    DBMS_OUTPUT.PUT_LINE('La suma de los numeros introducidos es ' || v_num_resultado);
END sumaNumeros;
/
EXECUTE sumaNumeros(5,5,5,5,5);
/


/*10. Escribir una función que devuelva solamente caracteres alfabéticos sustituyendo
cualquier otro carácter por blancos a partir de una cadena que se pasará en la llamada.*/
CREATE OR REPLACE FUNCTION cambiarCaracteres(
    v_string_palabra IN VARCHAR2)
RETURN VARCHAR2
IS
    v_string_modificada VARCHAR2(32767);
    v_num_contador NUMBER;
BEGIN
    v_num_contador := 1;
    WHILE v_num_contador <= LENGTH(v_string_palabra) LOOP
        IF REGEXP_LIKE(SUBSTR(v_string_palabra,v_num_contador,1), '[A-Za-z]') THEN
        v_string_modificada := v_string_modificada || SUBSTR(v_string_palabra,v_num_contador,1);
        ELSE
        v_string_modificada := v_string_modificada || ' ';
        END IF;
    v_num_contador := v_num_contador + 1;
    END LOOP;
    RETURN v_string_modificada;
END cambiarCaracteres;
/
SELECT cambiarCaracteres('h0la') AS CAMBIO_PALABRA FROM dual;
/


/*11. Implementar un procedimiento que reciba un importe y visualice el desglose del
cambio en unidades monetarias de 1 cent., 2 cents., 5 cents., 10 cents., 20 cents., 50
cents., 1€, 2€, 5€, 10€, 20€, 50€ en orden inverso al que aparecen aquí enumeradas.*/
CREATE OR REPLACE PROCEDURE dinero(
    v_num_importe IN NUMBER)
IS 
    v_num_sobrante NUMBER;--lo que sobra 
    v_num_monedas NUMBER;--num de monedas q llevan
BEGIN
    v_num_sobrante := v_num_importe * 100; --pasar a centimos
    --50€
    v_num_monedas :=TRUNC(v_num_sobrante/5000);
    v_num_sobrante := MOD(v_num_sobrante, 5000);
    DBMS_OUTPUT.PUT_LINE('50€: ' || v_num_monedas);
    --20€
    v_num_monedas :=TRUNC(v_num_sobrante/2000);
    v_num_sobrante := MOD(v_num_sobrante, 2000);
    DBMS_OUTPUT.PUT_LINE('20€: ' || v_num_monedas);
    --10€
    v_num_monedas :=TRUNC(v_num_sobrante/1000);
    v_num_sobrante := MOD(v_num_sobrante, 1000);
    DBMS_OUTPUT.PUT_LINE('10€: ' || v_num_monedas);
    --5€
    v_num_monedas :=TRUNC(v_num_sobrante/500);
    v_num_sobrante := MOD(v_num_sobrante, 500);
    DBMS_OUTPUT.PUT_LINE('5€: ' || v_num_monedas);
    --2€
    v_num_monedas := v_num_monedas + TRUNC(v_num_sobrante/200);
    v_num_sobrante := MOD(v_num_sobrante, 200);
    DBMS_OUTPUT.PUT_LINE('2€: ' || v_num_monedas);
    --1€
    v_num_monedas :=TRUNC(v_num_sobrante/100);
    v_num_sobrante := MOD(v_num_sobrante, 100);
    DBMS_OUTPUT.PUT_LINE('1€: ' || v_num_monedas);
    --50cts
    v_num_monedas :=TRUNC(v_num_sobrante/50);
    v_num_sobrante := MOD(v_num_sobrante, 50);
    DBMS_OUTPUT.PUT_LINE('50cts: ' || v_num_monedas);
    --20cts
    v_num_monedas :=TRUNC(v_num_sobrante/20);
    v_num_sobrante := MOD(v_num_sobrante, 20);
    DBMS_OUTPUT.PUT_LINE('20cts: ' || v_num_monedas);
    --10cts
    v_num_monedas :=TRUNC(v_num_sobrante/10);
    v_num_sobrante := MOD(v_num_sobrante, 10);
    DBMS_OUTPUT.PUT_LINE('10cts: ' || v_num_monedas);
    --5cts
    v_num_monedas :=TRUNC(v_num_sobrante/5);
    v_num_sobrante := MOD(v_num_sobrante, 5);
    DBMS_OUTPUT.PUT_LINE('5cts: ' || v_num_monedas);
    --2cts
    v_num_monedas :=TRUNC(v_num_sobrante/2);
    v_num_sobrante := MOD(v_num_sobrante, 2);
    DBMS_OUTPUT.PUT_LINE('2cts: ' || v_num_monedas);
    --1cts
    v_num_monedas := TRUNC(v_num_sobrante/1);
    v_num_sobrante := MOD(v_num_sobrante, 1);
    DBMS_OUTPUT.PUT_LINE('1cts: ' || v_num_monedas);
END dinero;
/
EXECUTE dinero(1243);
/


/*12. Codificar un procedimiento que permita borrar un empleado cuyo número se pasará
en la llamada.*/
CREATE OR REPLACE PROCEDURE eliminar(
    v_num_id IN emple.emp_no%TYPE)
IS
BEGIN
    DELETE FROM emple
    WHERE emp_no = v_num_id;
END eliminar;
/
EXECUTE eliminar(7369);
/

select * 
from emple;


/*13. Escribir un procedimiento que modifique la localidad de un departamento. El
procedimiento recibirá como parámetros el número del departamento y la localidad
nueva.*/
CREATE OR REPLACE PROCEDURE modificarLocalidad(
    v_num_depart IN depart.dept_no%TYPE,
    v_string_localidad IN depart.loc%TYPE)
IS
BEGIN
    UPDATE DEPART
    SET loc = v_string_localidad
    WHERE dept_no = v_num_depart;
END modificarLocalidad;
/
EXECUTE modificarLocalidad(99, 'ZARAGOZA');
/

select *
from depart;


/*14. Visualizar todos los procedimientos y funciones del usuario almacenados en la base de
datos y su situación (valid o invalid).*/

SELECT OBJECT_NAME, OBJECT_TYPE, STATUS
FROM USER_OBJECTS
WHERE OBJECT_TYPE IN ('PROCEDURE','FUNCTION');













