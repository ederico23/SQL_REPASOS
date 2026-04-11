--ESTUDIO TEMA 6

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
para la empresa de código 10 en la provincia 1 ¿Qué ocurre?¿Porqué?*/
        INSERT INTO EMPLEADOS(COD_EMPLE, NOMBRE, APELLIDO, SALARIO, COD_PROVI)
        VALUES(
        10,
        'Sergio',
        'Perez',
        10,
        1        
        );





















