--------------------------------------------------------------------------------
-----------------------------------HOJA 1---------------------------------------
--------------------------------------------------------------------------------

/*55) Selecciona los datos de los productos de los que haya como mucho 10 unidades en stock
pero con el precio redondeado a un decimal.*/
SELECT NUMERO_PRODUCTO, NOMBRE, DESCRIPCION, ROUND(PRECIO_VENTA, 1), STOCK, ID_CATEGORIA
FROM PRODUCTOS
WHERE STOCK <= 10;

/*56) Crea una consulta que muestre las dos soluciones de la siguiente ecuación de segundo
grado 3X2+2x-5=0.*/
SELECT 
    -- Primera solucion
    (-2 + SQRT(POWER(2,2) - 4 * 3 * -5)) / (2 * 3) AS SOLUCION_1,
    
    -- Segunda solucion
    (-2 - SQRT(POWER(2,2) - 4 * 3 * -5)) / (2 * 3) AS SOLUCION_2
FROM DUAL;

/*57) Crea una consulta que calcule la raíz cuadrada de 49 y le sume el valor absoluto de (-5).*/
SELECT SQRT(49)+ ABS(-5)
FROM DUAL;


/*58) Muestra el precio de venta medio de todos los productos.*/
SELECT ROUND(AVG(PRECIO_VENTA),2)
FROM PRODUCTOS;


/*59) Muestra el nombre y apellidos, ordenados alfabéticamente, de los empleados que han
vendido productos cuyo precio sea mayor que el precio medio de todos los productos.
Deben mostrarse los datos completamente en mayúsculas.*/
SELECT DISTINCT UPPER(E.NOMBRE), UPPER(E.APELLIDOS)
FROM EMPLEADOS E
JOIN PEDIDOS P ON E.ID_EMPLEADO = P.ID_EMPLEADO
JOIN DETALLES_PEDIDOS DP ON P.NUMERO_PEDIDO = DP.NUMERO_PEDIDO
JOIN PRODUCTOS PR ON DP.NUMERO_PRODUCTO = PR.NUMERO_PRODUCTO
WHERE PR.PRECIO_VENTA > (SELECT AVG(PRECIO_VENTA)
                          FROM PRODUCTOS)
ORDER BY UPPER(E.NOMBRE), UPPER(E.APELLIDOS);


/*60) Calcula el número de productos que hay en la categoría 3*/
SELECT COUNT(*)
FROM PRODUCTOS
WHERE ID_CATEGORIA = 3;


/*61) Muestra el precio de venta mayor y el precio de venta menor de los productos.*/
SELECT MAX(PRECIO_VENTA) AS "PRECIO VENTA MAX", MIN(PRECIO_VENTA) AS "PRECIO VENTA MIN"
FROM PRODUCTOS;


/*62) Muestra los datos de los productos que tienen el precio más alto.*/
SELECT *
FROM PRODUCTOS
WHERE PRECIO_VENTA = (SELECT MAX(PRECIO_VENTA)
                        FROM PRODUCTOS);


/*63) Muestra los productos que pertenezcan a categorías en las que la longitud de su columna
descripción sea mayor de 8.*/
SELECT NOMBRE
FROM PRODUCTOS
WHERE ID_CATEGORIA IN (SELECT ID_CATEGORIA
                        FROM CATEGORIAS
                        WHERE LENGTH(DESCRIPCION) > 8);
                        

/*64) Muestra los nombres de los empleados con longitud máxima 10 y rellena los que sean
menor que 10 con * por la derecha hasta que tengan longitud 10.*/              
SELECT RPAD(NOMBRE, 10, '*') AS NOMBRE_RELLENO
FROM EMPLEADOS;

/*65) Actualiza los datos de la tabla PRODUCTOS de manera que en la columna descripción de los
productos que pertenecen a la categoría 1 ponga 'Es un accesorio'.
Actualiza los datos de la tabla PRODUCTOS de manera que en la columna descripción de los
productos que pertenecen a la categoría 2 ponga 'Es una bicicleta'.
Muestra ahora el nombre, descripción y el precio de venta de todos los productos, en caso
de que la descripción tenga valor nulo debe aparecer el texto 'PRODUCTO SIN
DESCRIPCIÓN'.*/
UPDATE PRODUCTOS
SET DESCRIPCION = 'Es un accesorio'
WHERE ID_CATEGORIA =1;

UPDATE PRODUCTOS
SET DESCRIPCION = 'Es una bicicleta'
WHERE ID_CATEGORIA = 2;

SELECT NOMBRE, NVL(DESCRIPCION, 'PRODUCTO SIN DESCRIPCION') , PRECIO_VENTA
FROM PRODUCTOS;


/*66) Calcula el número de productos que no tienen descripción (valor nulo en esa columna)*/
SELECT COUNT(*)
FROM PRODUCTOS
WHERE DESCRIPCION IS NULL;


/*67) Para cada pedido muestra el código del pedido, el identificador del cliente, el nombre del
cliente y el mes en que fue realizado el pedido (solo el mes).*/
SELECT P.NUMERO_PEDIDO, P.ID_CLIENTE, C.NOMBRE, TO_CHAR(P.FECHA_PEDIDO, 'MONTH') AS MES_PEDIDO
FROM PEDIDOS P
JOIN CLIENTES C ON P.ID_CLIENTE = C.ID_CLIENTE;

/*68) Ahora muestra las mismas columnas que en la consulta anterior, pero la fecha de pedido
debe aparecer en el siguiente formato (‘dd-mm-yyyy’). Hay que utilizar la función TO_CHAR.*/
SELECT P.NUMERO_PEDIDO, P.ID_CLIENTE, C.NOMBRE, TO_CHAR(P.FECHA_PEDIDO, 'dd-mm-yyyy') AS pedido
FROM PEDIDOS P
JOIN CLIENTES C ON P.ID_CLIENTE = C.ID_CLIENTE;

/*69) Obtener qué fecha será el próximo miércoles.*/
SELECT NEXT_DAY(SYSDATE, 'MIÉRCOLES') AS PROXIMO_MIERCOLES
FROM DUAL;

/*70) Obtener los nombres de los productos ordenados por el número de caracteres que tiene*/
SELECT NOMBRE
FROM PRODUCTOS
ORDER BY LENGTH(NOMBRE) DESC;

