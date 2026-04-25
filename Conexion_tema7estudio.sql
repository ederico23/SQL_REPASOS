-------------------------------------------------------------------------------
---------------------------------HOJA 1----------------------------------------
-------------------------------------------------------------------------------

/*1) Mostrar los nombres de todos nuestros proveedores*/
SELECT NOMBRE
FROM PROVEEDORES;


/*2) Mostrar el nombre y el precio de cada uno de nuestros productos.*/
SELECT NOMBRE, PRECIO_VENTA
FROM PRODUCTOS;


/*3) ¿De qué provincias son nuestros clientes? (Que no se repitan las provincias en el resultado
de la consulta).*/
SELECT DISTINCT PROVINCIA
FROM CLIENTES;



/*4) Mostrar toda la información de nuestros empleados*/
SELECT *
FROM EMPLEADOS;


/*5) Muestra las ciudades de nuestros proveedores en orden alfabético junto con los nombres
de los proveedores con los que trabajamos en cada ciudad.*/
SELECT CIUDAD, NOMBRE
FROM PROVEEDORES
ORDER BY CIUDAD;


/*6) Haz un listado de la página web de cada uno de nuestros proveedores con el siguiente
formato (no hay que mostrar los datos en caso de que no tengan página web).
http://www.shinoman.com/ es la pag web de Shinoman, Incorporated*/
SELECT PAG_WEB || ' es la pag web de ' || NOMBRE  AS PAGINA_WEB
FROM PROVEEDORES
WHERE PAG_WEB IS NOT NULL ;


/*7) ¿Cuántos días cuesta el envío de cada pedido?0*/
SELECT NUMERO_PEDIDO, ((FECHA_ENVIO - FECHA_PEDIDO) || ' DIAS') AS "DIAS DE ENVIO"
FROM PEDIDOS;



/*8) ¿Cuál es el valor de inventario de cada producto? (El valor de inventario es lo que cuesta
cada producto por el stock que hay en la tienda).*/
SELECT NOMBRE, ((PRECIO_VENTA * STOCK)|| '€') AS INVENTARIO
FROM PRODUCTOS;



/*9) Mostrar el precio de cada producto reducido en un 5%.*/
SELECT NOMBRE, ((PRECIO_VENTA * 0.95) || '€') AS PRECIO_DESCUENTO
FROM PRODUCTOS;


/*10) Mostrar la lista de los pedidos que han hecho nuestros clientes en orden descendente de
fecha. Hay que ver los pedidos de cada cliente seguidos.*/
SELECT ID_CLIENTE, FECHA_PEDIDO
FROM PEDIDOS
ORDER BY ID_CLIENTE, FECHA_PEDIDO DESC;


/*11) Mostrar la lista de los nombres y direcciones de nuestros proveedores ordenados
alfabéticamente por el nombre del proveedor*/
SELECT NOMBRE, DIRECCION
FROM PROVEEDORES 
ORDER BY NOMBRE;


/*12) Mostrar el nombre y apellido de los clientes cuyo apellido sea Sanz.*/
SELECT NOMBRE, APELLIDOS
FROM CLIENTES
WHERE UPPER(APELLIDOS)= 'SANZ';


/*13) ¿Cuáles son los nombres de los clientes que viven en la provincia de MADRID?*/
SELECT NOMBRE
FROM CLIENTES
WHERE UPPER(PROVINCIA) = 'MADRID';


/*14) Mostrar el nombre y apellido de los clientes que (una consulta para cada punto):*/
--• viven en la provincia de MADRID 
SELECT NOMBRE, APELLIDOS
FROM CLIENTES 
WHERE UPPER(PROVINCIA) = 'MADRID';

--• viven en Belmonte
SELECT NOMBRE, APELLIDOS
FROM CLIENTES
WHERE UPPER(CIUDAD) = 'BELMONTE';

--• tienen como código postal 45915
SELECT NOMBRE, APELLIDOS
FROM CLIENTES
WHERE COD_POSTAL = 45915;

--• que hicieron pedidos en Mayo
--NO ME SALE NADA PQ NO HAY PEDIDOS
SELECT NOMBRE, APELLIDOS
FROM CLIENTES
WHERE ID_CLIENTE IN (SELECT ID_CLIENTE
                      FROM PEDIDOS
                      WHERE TO_CHAR(FECHA_PEDIDO, 'MM') = '05');



/*15) ¿Hay pedidos en los que la fecha de envío fue puesta accidentalmente anterior a la fecha de
pedido?*/
SELECT NUMERO_PEDIDO
FROM PEDIDOS
WHERE (FECHA_PEDIDO > FECHA_ENVIO);


/*16) Mostrar el nombre y apellidos de los clientes cuyos apellidos empiezan por 'Pe'*/
SELECT NOMBRE, APELLIDOS
FROM CLIENTES
WHERE UPPER(APELLIDOS) LIKE 'PE%';


/*17) Mostrar el nombre y dirección de los proveedores cuya dirección incluya la cadena 'del'*/
SELECT NOMBRE, DIRECCION
FROM PROVEEDORES
WHERE UPPER(DIRECCION) LIKE '%DEL%';



/*18) Listar el nombre y apellidos de los clientes que viven en Somosierra y cuyo apellido empieza
con la letra ‘S’*/
SELECT NOMBRE, APELLIDOS
FROM CLIENTES
WHERE UPPER(CIUDAD) = 'SOMOSIERRA' AND UPPER(APELLIDOS) LIKE 'S%';


/*19) Listar el nombre y apellidos de los clientes que viven en Somosierra o en la provincia de
ORENSE.*/
SELECT NOMBRE, APELLIDOS
FROM CLIENTES
WHERE UPPER(CIUDAD) = 'SOMOSIERRA' OR UPPER(PROVINCIA) = 'ORENSE';



/*20) Mostrar una lista de los nombres y número de teléfono de los proveedores de las provincias
de MADRID y CACERES.*/
SELECT NOMBRE, TELEFONO
FROM PROVEEDORES
WHERE UPPER(PROVINCIA) = 'MADRID' OR UPPER(PROVINCIA) = 'CACERES';



/*21) Mostrar los datos de los pedidos del cliente 1001 en los que las fechas de pedido y envío
coincidan.*/
SELECT * 
FROM PEDIDOS
WHERE ID_CLIENTE = 1001 AND FECHA_PEDIDO = FECHA_ENVIO;


/*22) Mostrar los datos de los pedidos del cliente 1001 o que cumplan que la fecha de envío es 4
días posterior a la fecha de pedido.*/
SELECT *
FROM PEDIDOS
WHERE ID_CLIENTE = 1001
    OR (FECHA_ENVIO - FECHA_PEDIDO) = 4;


/*23) Mostrar nombre, apellidos, provincia y código postal de los clientes que se apelliden Pelayo
en la provincia de CACERES o de los clientes cuyo código postal termine en 9*/
SELECT NOMBRE, APELLIDOS, PROVINCIA, COD_POSTAL
FROM CLIENTES
WHERE UPPER(APELLIDOS) = 'PELAYO' AND UPPER(CIUDAD) = 'CACERES' OR COD_POSTAL LIKE '%9';


/*24) Mostrar nombre, apellidos, provincia y código postal de los clientes que se apelliden Pelayo
y de cualquier otro cliente que viva en la provincia de CACERES o tenga un código postal que
termine en 9*/
SELECT NOMBRE,APELLIDOS, PROVINCIA, COD_POSTAL
FROM CLIENTES
WHERE UPPER(APELLIDOS) = 'PELAYO' OR UPPER(CIUDAD) = 'CACERES' OR COD_POSTAL LIKE '%9';


/*25) Mostrar los datos de los proveedores que tienen su sede en CACERES, ORENSE o MADRID.*/
SELECT * 
FROM PROVEEDORES
WHERE UPPER(PROVINCIA) = 'ORENSE' OR  UPPER(PROVINCIA) = 'CACERES' OR UPPER(PROVINCIA) = 'MADRID';

--OPCION2
SELECT * 
FROM PROVEEDORES
WHERE UPPER(PROVINCIA)IN ('CACERES', 'ORENSE', 'MADRID');


/*26) Listar los clientes cuyo apellido empieza por H*/
SELECT NOMBRE, APELLIDOS
FROM CLIENTES
WHERE UPPER(APELLIDOS) LIKE 'H%';


/*27) Listar los clientes que no viven en Robledo ni en Somosierra*/
SELECT *
FROM CLIENTES
WHERE UPPER(CIUDAD) NOT IN( 'ROBLEDO' , 'SOMOSIERRA');


/*28) Mostrar el número de pedido, el id_cliente y la fecha de pedido de todos los pedidos que ha
realizado el cliente 1001 ordenado por fecha de pedido.*/
SELECT NUMERO_PEDIDO, ID_CLIENTE, FECHA_PEDIDO
FROM PEDIDOS
WHERE ID_CLIENTE = 1001
ORDER BY FECHA_PEDIDO;


/*29) Mostrar un listado en orden alfabético de los nombres de productos que empiezan por
'Dog'*/
SELECT NOMBRE
FROM PRODUCTOS
WHERE UPPER(NOMBRE)LIKE 'DOG%'
ORDER BY NOMBRE;


/*30) Listar los nombres de todos los proveedores con sede en Batres, Belmonte o Robledo*/
SELECT NOMBRE 
FROM PROVEEDORES
WHERE UPPER(CIUDAD) IN ('BATRES', 'BELMONTE', 'ROBLED0');


/*31) Mostrar en orden alfabético la lista de los nombres de productos cuyo precio de venta sea
igual o superior a 125.00 euros.*/
SELECT NOMBRE
FROM PRODUCTOS
WHERE PRECIO_VENTA >= 125
ORDER BY NOMBRE;


/*32) Listar en orden alfabético los nombres de los proveedores que no tienen página web*/
SELECT NOMBRE
FROM PROVEEDORES
WHERE PAG_WEB IS NULL
ORDER BY NOMBRE;

/*33) Intersección: Listar los número de pedidos en los que se han pedido tanto bicicletas
(sabiendo que sus números de producto son 1, 2, 6 y 11) como cascos (sabiendo que sus
números de producto son 10, 25 y 26).*/
SELECT NUMERO_PEDIDO FROM DETALLES_PEDIDOS 
WHERE NUMERO_PRODUCTO IN (1, 2, 6, 11)

INTERSECT

SELECT NUMERO_PEDIDO FROM DETALLES_PEDIDOS 
WHERE NUMERO_PRODUCTO IN (10, 25, 26);
    

/*34) Diferencia: Listar los número de pedidos que han comprado alguna bicicleta (sabiendo que
sus números de producto son 1, 2, 6 y 11) pero no cascos (sabiendo que sus números de
producto son 10, 25 y 26).*/
SELECT NUMERO_PEDIDO FROM DETALLES_PEDIDOS 
WHERE NUMERO_PRODUCTO IN (1, 2, 6, 11)

MINUS

SELECT NUMERO_PEDIDO FROM DETALLES_PEDIDOS 
WHERE NUMERO_PRODUCTO IN (10, 25, 26);


/*35) Unión: Listar los número de pedidos que han comprado alguna bicicleta (sabiendo que sus
números de producto son 1, 2, 6 y 11) o algún casco (sabiendo que sus números de producto
son 10, 25 y 26). */

--USANDO JOIN
SELECT NUMERO_PEDIDO FROM DETALLES_PEDIDOS 
WHERE NUMERO_PRODUCTO IN (1, 2, 6, 11)

UNION

SELECT NUMERO_PEDIDO FROM DETALLES_PEDIDOS 
WHERE NUMERO_PRODUCTO IN (10, 25, 26);


--SIN USAR JOIN
SELECT DISTINCT NUMERO_PEDIDO 
FROM DETALLES_PEDIDOS 
WHERE NUMERO_PRODUCTO IN (1, 2, 6, 11, 10, 25, 26);


/*36) Clientes y empleados que tienen el mismo nombre*/
SELECT NOMBRE
FROM CLIENTES

INTERSECT

SELECT NOMBRE
FROM EMPLEADOS;


/*37) Clientes cuyos nombres no coinciden con los de ningún empleado.*/
SELECT NOMBRE
FROM CLIENTES

MINUS

SELECT NOMBRE
FROM EMPLEADOS;


/*38) Ciudades en las que viven clientes pero ningún empleado.*/
SELECT CIUDAD
FROM CLIENTES

MINUS

SELECT CIUDAD
FROM EMPLEADOS;

-------------------------------------------------------------------------------
---------------------------------HOJA 2----------------------------------------
-------------------------------------------------------------------------------

/*39. Listar todos los números de pedidos en los que se ha vendido algún producto cuyo número
de producto es mayor que el número del producto con nombre 'Shinoman 105 SC Frenos'. No
deben repetirse números de pedido.*/
SELECT DISTINCT NUMERO_PEDIDO
FROM DETALLES_PEDIDOS
WHERE NUMERO_PRODUCTO > (SELECT NUMERO_PRODUCTO
                         FROM PRODUCTOS
                         WHERE UPPER(NOMBRE) = 'SHINOMAN 105 SC FRENOS');


/*40. Selecciona todos los nombres de proveedores que llevan productos que empiezan por la
letra C y se enviaron en pedidos antes del 1 de Marzo del 2008.*/
SELECT PROV.NOMBRE
FROM PROVEEDORES PROV --PROV PARA ACORTAR
JOIN PRODUCTOS PROD ON PROV.ID_PROV = PROD.ID_PROV --CONECTAMOS LA TABLA A TRAVES DE LA PK(LO QUE ES LA FK DE OTRA TABLA)
JOIN DETALLES_PEDIDOS DP ON PROD.NUMERO_PRODUCTO = DP.NUMERO_PRODUCTO 
JOIN PEDIDOS P ON DP.NUMERO_PEDIDO = P.NUMERO_PEDIDO
WHERE UPPER(PROV.NOMBRE)LIKE 'C%' 
    AND PED.FECHA_PEDIDO < TO_DATE('01/03/2008', 'DD/MM/YYYY'); --QUE SEA MENOR QUE ESA FECHA

/*41. Selecciona todos los nombres de proveedores que llevan productos que empiezan por la
letra V y no se han vendido.*/
SELECT PROV.NOMBRE
FROM PROVEEDORES PROV
JOIN PRODUCTOS_PROVEEDORES PP ON PROV.ID_PROV = PP.ID_PROV
JOIN PRODUCTOS P ON PP.NUMERO_PRODUCTO = P.NUMERO_PRODUCTO
WHERE UPPER(P.NOMBRE) LIKE 'V%' 
    AND P.NUMERO_PRODUCTO NOT IN (SELECT NUMERO_PRODUCTO 
                                  FROM DETALLES_PEDIDOS); -- QUE EL NUMERO_PRODUCTO NO ESTÉ EN DETALLES PEDIDOS
                                  

/*42. Intersección: Listar los clientes que han comprado tanto productos que contengan la cadena
'Bike' en el nombre como productos que contengan la cadena 'Casco' en el nombre.*/                            
SELECT C.NOMBRE
FROM CLIENTES C
JOIN PEDIDOS P ON C.ID_CLIENTE = P.ID_CLIENTE
JOIN DETALLES_PEDIDOS DP ON P.NUMERO_PEDIDO = DP.NUMERO_PEDIDO
JOIN PRODUCTOS PROD ON DP.NUMERO_PRODUCTO = PROD.NUMERO_PRODUCTO
WHERE UPPER(PROD.NOMBRE) LIKE '%BIKE%'
INTERSECT 
SELECT C.NOMBRE
FROM CLIENTES C
JOIN PEDIDOS P ON C.ID_CLIENTE = P.ID_CLIENTE
JOIN DETALLES_PEDIDOS DP ON P.NUMERO_PEDIDO = DP.NUMERO_PEDIDO
JOIN PRODUCTOS PROD ON DP.NUMERO_PRODUCTO = PROD.NUMERO_PRODUCTO
WHERE UPPER(PROD.NOMBRE) LIKE '%CASCO%';

                                  
/*43. Diferencia: Listar los clientes que han comprado algún producto que contenga la cadena
'Bike' en el nombre pero ningún producto que contenga la cadena 'Casco' en el nombre.*/
SELECT C.NOMBRE
FROM CLIENTES C
JOIN PEDIDOS P ON C.ID_CLIENTE = P.ID_CLIENTE
JOIN DETALLES_PEDIDOS DP ON P.NUMERO_PEDIDO = DP.NUMERO_PEDIDO
JOIN PRODUCTOS PROD ON DP.NUMERO_PRODUCTO = PROD.NUMERO_PRODUCTO
WHERE UPPER(PROD.NOMBRE) LIKE '%BIKE%'
MINUS
SELECT C.NOMBRE
FROM CLIENTES C
JOIN PEDIDOS P ON C.ID_CLIENTE = P.ID_CLIENTE
JOIN DETALLES_PEDIDOS DP ON P.NUMERO_PEDIDO = DP.NUMERO_PEDIDO
JOIN PRODUCTOS PROD ON DP.NUMERO_PRODUCTO = PROD.NUMERO_PRODUCTO
WHERE UPPER(PROD.NOMBRE) LIKE '%CASCO%';

/*44. Unión: Listar los clientes que han comprado algún producto que contenga la cadena 'Bike' o
la cadena 'Casco' en el nombre.*/
SELECT C.NOMBRE
FROM CLIENTES C
JOIN PEDIDOS P ON C.ID_CLIENTE = P.ID_CLIENTE
JOIN DETALLES_PEDIDOS DP ON P.NUMERO_PEDIDO = DP.NUMERO_PEDIDO
JOIN PRODUCTOS PROD ON DP.NUMERO_PRODUCTO = PROD.NUMERO_PRODUCTO
WHERE UPPER(PROD.NOMBRE) LIKE '%BIKE%'
UNION
SELECT C.NOMBRE
FROM CLIENTES C
JOIN PEDIDOS P ON C.ID_CLIENTE = P.ID_CLIENTE
JOIN DETALLES_PEDIDOS DP ON P.NUMERO_PEDIDO = DP.NUMERO_PEDIDO
JOIN PRODUCTOS PROD ON DP.NUMERO_PRODUCTO = PROD.NUMERO_PRODUCTO
WHERE UPPER(PROD.NOMBRE) LIKE '%CASCO%';


/*45. Clientes que viven en una ciudad que no coincide con ninguna de los empleados.*/
SELECT NOMBRE
FROM CLIENTES
WHERE CIUDAD NOT IN(SELECT CIUDAD
                    FROM EMPLEADOS);

/*46. Lista de los clientes que han comprado algún producto que contenga la cadena 'Bike' en el
nombre seguida de la lista de los que han comprado algún producto que contenga la cadena
'Casco' en el nombre (cruce de tablas).*/
SELECT C.NOMBRE
FROM CLIENTES C
JOIN PEDIDOS P ON C.ID_CLIENTE = P.ID_CLIENTE
JOIN DETALLES_PEDIDOS DP ON P.NUMERO_PEDIDO = DP.NUMERO_PEDIDO
JOIN PRODUCTOS PR ON DP.NUMERO_PRODUCTO = PR.NUMERO_PRODUCTO
WHERE UPPER(PR.NOMBRE) LIKE '%BIKE%'
UNION
SELECT C.NOMBRE
FROM CLIENTES C
JOIN PEDIDOS P ON C.ID_CLIENTE = P.ID_CLIENTE
JOIN DETALLES_PEDIDOS DP ON P.NUMERO_PEDIDO = DP.NUMERO_PEDIDO
JOIN PRODUCTOS PR ON DP.NUMERO_PRODUCTO = PR.NUMERO_PRODUCTO
WHERE UPPER(PR.NOMBRE) LIKE '%CASCO%';


/*47. Seleccionar los nombres de los productos que pertenecen a la categoría 'Componentes'*/
SELECT NOMBRE
FROM PRODUCTOS
WHERE ID_CATEGORIA = (SELECT ID_CATEGORIA
                        FROM CATEGORIAS
                        WHERE UPPER(DESCRIPCION) = 'COMPONENTES');


/*48. Selecciona los productos cuyo precio sea mayor o igual que el de todos los demás.*/
SELECT NOMBRE
FROM PRODUCTOS
WHERE PRECIO_VENTA >= (SELECT AVG(PRECIO_VENTA)
                        FROM PRODUCTOS);
                        
/*49. Selecciona los productos cuyo precio sea menor que el producto 'Eagle SA-120 Pedales sin
clip', ordenados por el precio de venta*/
SELECT NOMBRE
FROM PRODUCTOS
WHERE PRECIO_VENTA >= (SELECT PRECIO_VENTA
                        FROM PRODUCTOS
                        WHERE UPPER(NOMBRE) = 'EAGLE SA-120 PEDALES SIN CLIP')
ORDER BY PRECIO_VENTA;    


/*50. Modifica la descripción de la categoría 5 a 'Baca para el coche' y luego selecciona todos los
productos que no pertenecen a las categorías 'Ruedas' ni 'Baca para el coche'.*/
UPDATE CATEGORIAS
SET DESCRIPCION = 'Baca para el coche'
WHERE ID_CATEGORIA = 5;

SELECT P.NOMBRE
FROM PRODUCTOS P
JOIN CATEGORIAS C ON P.ID_CATEGORIA = C.ID_CATEGORIA
WHERE UPPER(C.DESCRIPCION) NOT IN('RUEDAS', 'BACA PARA EL COCHE');

/*51. Seleccionar los productos cuyo precio de venta sea mayor que cualquier producto de la
categoría 'Componentes'*/
SELECT NOMBRE
FROM PRODUCTOS 
WHERE PRECIO_VENTA > ALL(SELECT P.PRECIO_VENTA
                        FROM PRODUCTOS P
                        JOIN CATEGORIAS C ON P.ID_CATEGORIA = C.ID_CATEGORIA
                        WHERE UPPER(C.DESCRIPCION) = 'COMPONENTES');


/*52. Selecciona los clientes que son de la misma ciudad que el cliente con id 1001, en la lista no
tiene que salir el cliente 1001.*/
SELECT NOMBRE
FROM CLIENTES
WHERE CIUDAD = (SELECT CIUDAD
                FROM CLIENTES
                WHERE ID_CLIENTE = 1001)
    AND ID_CLIENTE <> 1001;
    
    

/*53. Encuentra los productos que tienen el precio de venta mínimo de su categoría*/
SELECT ID_CATEGORIA, MIN(PRECIO_VENTA)
FROM PRODUCTOS
GROUP BY ID_CATEGORIA
ORDER BY ID_CATEGORIA;

/*54. Selecciona las categorías que no tienen productos*/
SELECT ID_CATEGORIA
FROM CATEGORIAS
WHERE ID_CATEGORIA NOT IN (SELECT ID_CATEGORIA
                              FROM PRODUCTOS);
