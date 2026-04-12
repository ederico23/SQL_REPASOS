--ESTUDIO TEMA 6

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------HOJA 1------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------


/*1. Crea la tabla PROVINCIAS con los siguientes campos
Cod_provi de tipo number(2) y es la clave primaria
Nombre de tipo varchar2(25), es obligatorio
Pais de tipo varchar2(25) debe ser uno de los siguientes España, Portugal o Italia
Introduce la provincia 1 Ávila de España.*/


CREATE TABLE PROVINCIAS (

    COD_PROVI NUMBER(2) CONSTRAINT COD_PROVINCIAS_PK PRIMARY KEY,
    NOMBRE VARCHAR2(25) CONSTRAINT NOM_PROVINCIAS_NN NOT NULL,
    PAIS VARCHAR2(25) CONSTRAINT PAIS_PROVINCIAS_CH CHECK ( PAIS IN ('España', 'Portugal', 'Italia'))

);

INSERT INTO PROVINCIAS(COD_PROVI, NOMBRE, PAIS)
VALUES(
    1,
    'ÁVILA',
    'España'
);
    
    
   
   
/*2. Crea la tabla EMPRESAS con los siguientes campos:
Cod_empre number(2) es la clave
Nombre varchar2(25) obligatorio por defecto será empresa1
Fecha_crea de tipo fecha por defecto será un dia posterior a la fecha actual.
Introduce la empresa 20 llamada Alfa21 S.A.*/

CREATE TABLE EMPRESAS(
    
    COD_EMPRE NUMBER(2) CONSTRAINT COD_EMPRESAS_PK PRIMARY KEY,
    NOMBRE VARCHAR2(25) DEFAULT 'EMPRESA1' CONSTRAINT NOM_EMPRESAS_NN NOT NULL,
    FECHA_CREA DATE DEFAULT SYSDATE+1 

);

INSERT INTO EMPRESAS(COD_EMPRE, NOMBRE)
VALUES(
    20,
    'Alfa21 S.A.'
);


/*3. Crea la tabla CONTINENTES con los siguientes campos
Cod_conti de tipo number y es la clave primaria
Nombre de tipo varchar2(20) el valor por defecto es EUROPA y es obligatorio*/

CREATE TABLE CONTINENTES (

    COD_CONTI NUMBER(2) CONSTRAINT COD_CONTINENTES_PK PRIMARY KEY,
    NOMBRE VARCHAR2(20) DEFAULT 'EUROPA' CONSTRAINT NOM_CONTINENTES_NN NOT NULL
);


/*4. Crea la tabla ALUMNOS con los siguientes campos
codigo number(3) y es la clave primaria
nombre cadena de caracteres de longitud máxima 21, es obligatorio
apellido cadena de caracteres de longitud máxima 30, es obligatorio y ha de
estar en mayúsculas.
Curso de tipo number y ha de ser 1,2 o 3
Fecha_matri de tipo fecha y por defecto es la fecha actual*/

CREATE TABLE ALUMNOS (

    CODIGO NUMBER(3) CONSTRAINT COD_ALUMNOS_PK PRIMARY KEY,
    NOMBRE VARCHAR2(21) CONSTRAINT NOM_ALUMNOS_NN NOT NULL,
    APELLIDO VARCHAR2(30) CONSTRAINT APP_ALUMNOS_NN NOT NULL
        CONSTRAINT AP_ALUMNOS_CH CHECK (APELLIDO = UPPER(APELLIDO)),
    CURSO NUMBER(1) CONSTRAINT CUR_ALUMNOS_CH CHECK (CURSO IN (1, 2, 3)),
    FECHA_MATRI DATE DEFAULT SYSDATE
);


/*5. Crea la tabla EMPLEADOS con los siguientes campos
Cod_emple number(2) y es clave
Nombre cadena de caracteres de longitud máxima 20 y es obligatorio
Apellido cadena de caracteres de longitud máxima 25
Salario número de 7 cifras con dos decimales debe ser mayor que 0
Además tiene dos campos que son claves ajenas de las tablas provincias y
empresas respectivamente. Para la clave ajena de provincias indicaremos un
borrado en cascada.
NOTA: EN TOTAL DEBE HABER SEIS CAMPOS*/

CREATE TABLE EMPLEADOS (

    COD_EMPLE NUMBER(2) CONSTRAINT COD_EMPLEADOS_PK PRIMARY KEY,
    NOMBRE VARCHAR2(20) CONSTRAINT NOM_EMPLEADOS_NN NOT NULL,
    APELLIDO VARCHAR2(25),
    SALARIO NUMBER(7, 2) CONSTRAINT SAL_EMPLEADOS_CH CHECK (SALARIO > 0),
    
    COD_PROVI NUMBER(2) CONSTRAINT EMPLEADOS_PROVCOD_FK REFERENCES PROVINCIAS(COD_PROVI) ON DELETE CASCADE,
    COD_EMPRE NUMBER(2) CONSTRAINT EMPLEADOS_EMPRECOD_FK REFERENCES EMPRESAS(COD_EMPRE)

);


    /*Introduce en la tabla EMPLEADOS, la empleada 300 de nombre Veronica Lopez y
        salario 3000 ¿Qué ocurre?¿Por qué?*/
        INSERT INTO EMPLEADOS(COD_EMPLE, NOMBRE, APELLIDO, SALARIO)
        VALUES(
        300,
        'Veronica',
        'Lopez',
        3000
        );
        --valor mayor que el que permite la columna (cod_emple)

    /*Introduce los mismos datos que antes pero el código del empleado será 30.*/
        INSERT INTO EMPLEADOS(COD_EMPLE, NOMBRE, APELLIDO, SALARIO)
        VALUES(
        30,
        'Veronica',
        'Lopez',
        3000
        );
        
     /*Introduce en la tabla EMPLEADOS el empleado 10 llamado Sergio Perez que trabaja
    parala empresa de código 10 en la provincia 1 ¿Qué ocurre?¿Porqué?*/
        INSERT INTO EMPLEADOS(COD_EMPLE, NOMBRE, APELLIDO, SALARIO, COD_PROVI)
        VALUES(
        10,
        'Sergio',
        'Perez',
        10,
        1        
        );


    /*Introduce en la tabla EMPLEADOS el empleado 10 llamado Sergio Perez que trabaja
    para la empresa Alfa21 y vive en Ávila.*/
    INSERT INTO EMPLEADOS(COD_EMPLE, NOMBRE, APELLIDO, COD_EMPRE, COD_PROVI)
    VALUES(
        10,
        'Sergio',
        'Perez',
        20,
        1
    );




/*6. Crea la tabla PROVINCIAS y PERSONAS con la estructura que se muestra a
continuación, en negrita la clave principal y codprovin referencia a cod_provincia.
Además pondremos la opción de BORRADO EN CASCADA.*/

CREATE TABLE PROVINCIAS2(
    
    COD_PROVIN NUMBER(2) CONSTRAINT COD_PROVIN2_PK PRIMARY KEY,
    NOM_PROVINCIA VARCHAR2(15) CONSTRAINT NOM_PROVIN2_NN NOT NULL,
    POBLACION NUMBER(10)

);


CREATE TABLE PERSONAS (
    
    DNI VARCHAR2(9) CONSTRAINT DNI_PERS_PK PRIMARY KEY,
    NOMBRE VARCHAR2(15) CONSTRAINT NOMP_PERS_NN NOT NULL,
    DIRECCION VARCHAR2(30) CONSTRAINT DIREC_PERS_NN NOT NULL,
    
    COD_PROVIN NUMBER(2)CONSTRAINT COD_PERSPROVIN_FK REFERENCES PROVINCIAS2(COD_PROVIN) ON DELETE CASCADE

);


/*7. Crear la tabla EJEMPLO1 y asignar a la columna fecha la fecha del sistema
DNI VARCHAR2(10)
NOMBRE VARCHAR2(30)
EDAD NUMBER(2)
FECHA DATE
Insertar una fila con los valores siguientes, 1234, PEPA, 21 sin la columna fecha,
comprobando después que efectivamente añade la fecha actual.*/

CREATE TABLE EJEMPLO1 (
    
    DNI VARCHAR2(10) CONSTRAINT DNI_EJ1_PK PRIMARY KEY,
    NOMBRE VARCHAR2(30),
    EDAD NUMBER(2),
    FECHA DATE DEFAULT SYSDATE

);

INSERT INTO EJEMPLO1(DNI, NOMBRE, EDAD)
VALUES(
1234,
'PEPA',
21
);


/*8. Crear la tabla EJEMPLO3 cuyas columnas y restricciones son las siguientes:
DNI VARCHAR2(10)
NOMBRE VARCHAR2(30)
EDAD NUMBER(2)
CURSO NUMBER
Restricciones
- El DNI no puede ser nulo
- La clave principal es le DNI
- La EDAD ha de estar comprendida entre 5 y 20 años
- El NOMBRE ha de estar en mayúsculas
- El curso sólo puede almacenar 1,2 o 3
Insertar: las filas siguientes y si da error indicar por qué:
1111 Pepe 4 1 (error) NOMBRE MAYÚSCULAS
1111 PEPE 10 2
2222 MARIA 12 5 (error) CURSO 1,2 O 3
2222 MARIA 12 2*/

CREATE TABLE EJEMPLO3 (

    DNI VARCHAR2(10) CONSTRAINT DNI_EJ3_PK PRIMARY KEY,
    NOMBRE VARCHAR2(30) CONSTRAINT NOM_EJ3_CH CHECK( NOMBRE = UPPER(NOMBRE)),
    EDAD NUMBER(2) CONSTRAINT EDAD_EJ3_CH CHECK( EDAD BETWEEN 5 AND 20),
    CURSO NUMBER CONSTRAINT CURSO_EJ3_CH CHECK (CURSO IN(1,2,3))

);

INSERT INTO EJEMPLO3
VALUES(
1111,
'Pepe',
4,
1
);

INSERT INTO EJEMPLO3
VALUES(
1111,
'PEPE',
10,
2
);

INSERT INTO EJEMPLO3
VALUES(
2222,
'MARIA',
12,
5
);

INSERT INTO EJEMPLO3
VALUES(
2222,
'MARIA',
10,
2
);


/*9. Crea las tabla siguientes con lo campos y restricciones:
ALUMNOS
Codigo number (2 )PK
Nombre varchar2(25) obligatorio
MODULOS
Codigo number PK,
Nombre varchar2(25)
NOTAS
Cod_alumno number(2)
Cod_modulo number
Nota number(2),
(Cod-alumno, modulo) es la clave primaria
Nota ha de ser un número comprendido entre 0 y 10
Debe además tener dos campos que hacen referencia a la tabla MODULOS y
ALUMNOS*/

CREATE TABLE ALUMNO (

    CODIGO NUMBER(2) CONSTRAINT COD_ALU_PK PRIMARY KEY,
    NOMBRE VARCHAR2(25) CONSTRAINT NOM_ALU_NN NOT NULL

);

CREATE TABLE MODULOS(

    CODIGO NUMBER(2) CONSTRAINT COD_MOD_PK PRIMARY KEY,
    NOMBRE VARCHAR2(25)
    
);

CREATE TABLE NOTAS(
    
    COD_ALUMNO NUMBER(2),
    COD_MODULO NUMBER(2),
    NOTA NUMBER(2) CONSTRAINT NOTA_NOTAS_CH CHECK (NOTA BETWEEN 0 AND 10)

);


------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------HOJA 2------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

/*1. Crea la tabla EMPLEADOS3 a partir de la tabla employees de modo que tenga todos sus
campos y los datos correspondientes a los empleados del departamento 100.
Comprueba cómo es la estructura de la tabla empleados3 y compárala con la de
employees, sus campos, tipos, restricciones heredadas de la tabla EMPLOYEES, ¿Cuál es la
clave primaria de esta nueva tabla?*/

CREATE TABLE EMPLEADOS3 AS
    SELECT *
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 100;
    
    
/*2. Crea la tabla DEPARTAMENTOS2 con los mismos datos y campos que la tabla departments.*/
CREATE TABLE DEPARTAMENTOS2 AS
    SELECT *
    FROM DEPARTMENTS;

/*3. Añade dos nuevas columnas a la tabla EMPLEADOS3, una de ellas es hobby, de tipo cadena
de caracteres, de longitud variable, máximo 40. La otra es NHIJOS de tipo Number(2).*/

ALTER TABLE EMPLEADOS3
ADD (
    HOBBY VARCHAR2(40),
    NHIJOS NUMBER(2)
);


/*4. Añade una nueva columna llamada EDAD de tipo NUMBER(3) NOT NULL, ¿Qué
ocurre?¿Por qué?*/

ALTER TABLE EMPLEADOS3
ADD (
EDAD NUMBER(3) CONSTRAINT EDAD_EMP3_NN NOT NULL
);
--ERROR PQ YA CONTIENE FILAS (EMPLEADOS DEPT100)
--SQL RELLENA LOS VALORES CON NULL, AL PONER NOT NULL NO PUEDE CREAR VALOR NULO, SE BLOQUEA LA OPERACION

/*5. Explica qué harías para poder definir la columna EDAD como NOT NULL?*/
--PONER UN DEFAULT 0 NOT NULL, ASI:
    ALTER TABLE EMPLEADOS3 
    ADD (
    EDAD NUMBER(3) DEFAULT 0 NOT NULL
    );
    
/*6. Borra las columnas EDAD Y NHIJOS de la tabla EMPLEADOS3.*/ 
ALTER TABLE EMPLEADOS3 
DROP (EDAD, NHIJOS);


/*7. Modifica la longitud del campo HOBBY a 30 caracteres como máximo.*/

ALTER TABLE EMPLEADOS3
MODIFY HOBBY VARCHAR2(30);


/*8. Modifica la longitud del campo FIRST_NAME a 5 caracteres como máximo. ¿Qué ocurre?
¿Por qué?*/

ALTER TABLE EMPLEADOS3
MODIFY FIRST_NAME VARCHAR2(5);
-- NO SE PUEDE REDUCIR PQ LA LONGITUD PQ ALGUN VALOR ES MAS GRANDE


/*9. Modifica la longitud del campo employee_id de modo que sea de tipo number con 5
dígitos, ninguno de ellos decimal. ¿Qué ocurre? Modifícala ahora a tipo number con 8
dígitos.*/

ALTER TABLE EMPLEADOS3 
MODIFY EMPLOYEE_ID NUMBER(5);
--la columna que desea  modificar debe estar vacía para disminuir la precisión o escala

ALTER TABLE EMPLEADOS3 
MODIFY EMPLOYEE_ID NUMBER(8);


/*10. Trata de borrar la columna DEPARTMENT_ID de la tabla DEPARTMENTS. ¿Qué ocurre?
¿Por qué?*/

ALTER TABLE DEPARTMENTS
DROP(DEPARTMENT_ID);
--no se puede borrar la columna de claves principales


/*11. Crea la clave primaria, el campo employee_id de la tabla empleados3, llama a la restricción
PK_EMPLE3. Comprueba en la estructura de la tabla que efectivamente es clave primaria.*/

ALTER TABLE EMPLEADOS3
ADD (
CONSTRAINT PK_EMPLE3 PRIMARY KEY (EMPLOYEE_ID)
);


DESCRIBE EMPLEADOS3;


/*12. Añade una nueva restricción a EMPLEADOS3, llámala salario de modo que el salario esté
entre 1000 y 4000. ¿Qué ocurre? Pon ahora los valores 1000 y 20000.*/

ALTER TABLE EMPLEADOS3
ADD (
    CONSTRAINT SAL_EMPLE3_CH CHECK (SALARY BETWEEN 1000 AND 4000)
);
--restricción de control violada



/*13. Crea una nueva tabla llamada departamentos como copia de la tabla departments.*/
CREATE TABLE DEPARTAMENTOS AS
SELECT * 
FROM DEPARTMENTS;


/*14. Inserta la siguiente fila (10,'Admin', 203, 1700) en la tabla departamentos.*/

INSERT INTO DEPARTAMENTOS
VALUES (
10,
'Admin',
203, 
1700
);


/*15. Crea una nueva restricción para la tabla departamentos de modo que department_id sea
clave primaria. ¿Qué ocurre? Propón una solución.*/

ALTER TABLE DEPARTAMENTOS
ADD CONSTRAINT ID_DEPART_PK PRIMARY KEY (DEPARTMENT_ID);
--clave primaria violada pq hay 2 department_id 10, entonces la solucion seria:

DELETE
FROM DEPARTAMENTOS WHERE DEPARTMENT_NAME = 'Admin';


/*16. Crea una nueva restricción en la tabla empleados3 de modo que la comisión no pueda ser
mayor del 5%.*/

ALTER TABLE EMPLEADOS3
ADD (
CONSTRAINT COM_EMP3_CH CHECK (COMMISSION_PCT <= 0.05)
);



/*17. Actualiza todas las filas de empleados3 poniendo a todos los empleados una comisión del
9%. ¿Qué ocurre? Pon ahora una comisión del 2%.*/

UPDATE EMPLEADOS3
SET COMMISSION_PCT = 0.09;
--ERROR, TAMAÑO MUY GRANDE

UPDATE EMPLEADOS3
SET COMMISSION_PCT = 0.02;


/*18. Crea una nueva restricción para la tabla empleados3 que se llame fk_emple3, de modo
que department_id sea clave ajena de departamentos con borrado en cascada.*/

ALTER TABLE EMPLEADOS3
ADD (
    CONSTRAINT FK_EMPLE3
        FOREIGN KEY (DEPARTMENT_ID)
        REFERENCES DEPARTAMENTOS(DEPARTMENT_ID)
        ON DELETE CASCADE
);



/*19. Crea la tabla tiendas sin restricciones con la siguiente descripción, pon los tipos adecuados
a los siguientes campos 
NIF, NOMBRE, DIRECCIÓN, POBLACIÓN, CIUDAD, PROVINCIA, CODPOSTAL*/

CREATE TABLE TIENDAS(
    NIF NUMBER(9),
    NOMBRE VARCHAR2(20),
    DIRECCION VARCHAR2(50),
    POBLACION VARCHAR2(30),
    CIUDAD VARCHAR2(30),
    PROVINCIA VARCHAR2(30),
    COD_POSTAL VARCHAR2(5)
);

    /*Añade las siguientes restricciones: la clave primaria es NIF, la provincia ha de almacenarse en
    mayúscula, el nombre es NO NULO, la ciudad debe ser Zaragoza, Huesca o Teruel.*/
    
    ALTER TABLE TIENDAS 
    ADD (
        CONSTRAINT NIF_TIENDAS_PK PRIMARY KEY (NIF),
        CONSTRAINT PROVIN_TIENDAS_CH CHECK(PROVINCIA = UPPER(PROVINCIA)),  
        CONSTRAINT CIU_TIENDAS_CH CHECK(CIUDAD IN('Zaragoza', 'Huesca', 'Teruel'))
    );

    ALTER TABLE TIENDAS 
    MODIFY (NOMBRE CONSTRAINT NOM_TIENDAS_NN NOT NULL);


DESC TIENDAS;















