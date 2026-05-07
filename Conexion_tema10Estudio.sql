--------------------------------------------------------------------------------
----------------------------------HOJA 1----------------------------------------
--------------------------------------------------------------------------------

/*84. Incrementa el precio de venta de todos los productos en un 10%. El departamento de
ventas quiere deshacer los cambios lo antes posible. */
UPDATE PRODUCTOS
SET PRECIO_VENTA = PRECIO_VENTA * 1.1;

ROLLBACK;


/*85. Tenemos que subir un 4% los precios de los productos de la categoría 'Ropa' y deshacerlos
lo más tarde posible.
a) Mostrar un listado con los nombres de los productos, el precio actual y el precio que
tendrán después de la subida.
b) Actualizar los precios de venta de dichos productos subiéndolos un 4%. */

--A
SELECT NOMBRE, PRECIO_VENTA AS PRECIO_ANTES, (PRECIO_VENTA * 1.04) AS PRECIO_DESPUES
FROM PRODUCTOS
WHERE ID_CATEGORIA = (SELECT ID_CATEGORIA
                        FROM CATEGORIAS
                        WHERE UPPER(DESCRIPCION)='ROPA');

--B
UPDATE PRODUCTOS
SET PRECIO_VENTA = PRECIO_VENTA * 1.04
WHERE ID_CATEGORIA = (SELECT ID_CATEGORIA
                        FROM CATEGORIAS
                        WHERE UPPER(DESCRIPCION) = 'ROPA');
                        
ROLLBACK;


/*86. Comprueba si la precisión de los campos numéricos de las tablas PEDIDOS y
PEDIDOS_HISTORICO coincide. Si no es así modifica la tabla PEDIDOS_HISTORICO para que
haya coincidencia. */

--modificar PRECIO_TOTAL a NUMBER(7,2)
ALTER TABLE PEDIDOS_HISTORICO
MODIFY (PRECIO_TOTAL NUMBER(7,2));

/*87. Nuestra empresa es líder del mercado y puede permitirse hacer lo que le apetezca. Por eso
ha decidido que aplicará con efecto retroactivo las últimas subidas de precio.
Para eso los datos que hasta ahora teníamos en la tabla PEDIDOS los guardaremos en la
tabla PEDIDOS_HISTORICO. Confirmarlo lo más tarde posible. */
INSERT INTO PEDIDOS_HISTORICO
SELECT * FROM PEDIDOS;

COMMIT;


/*88. Incrementar un 5% los precios de los productos de la categoría 'Ropa' y a continuación
actualizar en la tabla PEDIDOS el precio total de cada pedido de acuerdo a los nuevos
precios de los productos y lo mismo en la tabla DETALLES_PEDIDOS. **** Confirmarlo lo
más tarde posible. ********/
UPDATE PRODUCTOS
SET PRECIO_VENTA = PRECIO_VENTA * 1.05
WHERE ID_CATEGORIA = (SELECT ID_CATEGORIA
                        FROM CATEGORIAS
                        WHERE UPPER(DESCRIPCION) = 'ROPA');

UPDATE DETALLES_PEDIDOS DP --ACT DP 
SET PRECIO =(SELECT PRECIO_VENTA --ESTABLECER PRECIO  EL PRECIO_VENTA
              FROM PRODUCTOS P -- DE PRODUCTOS
              WHERE P.NUMERO_PRODUCTO = DP.NUMERO_PRODUCTO) -- DONDE EL NUMERO_PRODUCTO DE PRODUCTOS SEA IGUAL AL DE DP
WHERE NUMERO_PRODUCTO IN(SELECT NUMERO_PRODUCTO -- SI EL NUMERO_PRODUCTO ESTÁ ENTRE EL NUMERO_PRODUCTO
                         FROM PRODUCTOS -- DE PRODUCTOS
                         WHERE ID_CATEGORIA = (SELECT ID_CATEGORIA -- DONDE LA CATEGORIA = A LA CATEGORIA
                                                FROM CATEGORIAS -- DE CATEGORIAS
                                                WHERE UPPER(DESCRIPCION) = 'ROPA')); -- DONDE LA DESCRIPCION = ROPA
                        
UPDATE PEDIDOS P --ACT PEDIDOS
SET PRECIO_TOTAL = (SELECT SUM(CANTIDAD * PRECIO) -- ESTABLECER EL PRECIO_TOTAL EL RESULTADO DE CANTIDAD * PRECIO
                    FROM DETALLES_PEDIDOS DP -- DE DETALLES PEDIDOS
                    WHERE DP.NUMERO_PEDIDO = P.NUMERO_PEDIDO); -- DONDE EL NUMERO_PEDIDO DE DP = AL DE P
                    
COMMIT;


/*89. A partir de la tabla pedidos crea la tabla saldos_pendientes con los mismos campos que la
tabla pedidos y en el campo precio_total el valor de la diferencia entre el precio_total
actualizado y el precio_total antes de la actualización (éste último se encuentra en la tabla
pedidos_historico). */

CREATE TABLE SALDOS_PENDIENTES AS(
    SELECT P.NUMERO_PEDIDO, P.FECHA_PEDIDO, P.FECHA_ENVIO, (P.PRECIO_TOTAL - PH.PRECIO_TOTAL) AS PRECIO_TOTAL
    FROM PEDIDOS P
    JOIN PEDIDOS_HISTORICO PH ON P.NUMERO_PEDIDO = PH.NUMERO_PEDIDO
);


/*90. Ejecuta la sentencia rollback. ¿Qué pasa? ¿Por qué?*/
ROLLBACK;
--NO PASA NADA PQ LA SENTENCIA DE CREATE TABLE VIENE CON UN COMMIT AUTOMATICO

/*91. Mostrar el nombre del proveedor y el promedio por proveedor del número de días que se
tarda en realizar el envío de los productos. Hay que mostrar aquellos cuyo promedio sea
mayor que el promedio de todos los proveedores. */
SELECT P.NOMBRE, ROUND(AVG(PP.DIAS_ENVIO),2) AS DIAS_ENVIO
FROM PROVEEDORES P
JOIN PRODUCTOS_PROVEEDORES PP ON P.ID_PROV = PP.ID_PROV
GROUP BY P.NOMBRE
HAVING AVG(PP.DIAS_ENVIO) > (SELECT AVG(DIAS_ENVIO)
                             FROM PRODUCTOS_PROVEEDORES);
                             

/*92. Hacer una consulta que muestre el nombre del producto y el total vendido de aquellos
productos que superan el promedio de ventas de su categoría. */            

--CALCULA EL TOTAL VENDIDO DE CADA PRODUCTO
SELECT P.NOMBRE, SUM(DP.CANTIDAD) AS TOTAL_VENDIDO
FROM PRODUCTOS P
JOIN DETALLES_PEDIDOS DP ON P.NUMERO_PRODUCTO = DP.NUMERO_PRODUCTO
GROUP BY P.NOMBRE, P.ID_CATEGORIA, P.NUMERO_PRODUCTO
--CALCULAR PROMEDIO DE VENTAS
HAVING SUM(DP.CANTIDAD) > (
                        SELECT AVG(TOTAL_POR_PRODUCTO)
                        FROM (
                                SELECT SUM(DP2.CANTIDAD) AS TOTAL_POR_PRODUCTO
                                FROM PRODUCTOS P2
                                JOIN DETALLES_PEDIDOS DP2 ON P2.NUMERO_PRODUCTO = DP2.NUMERO_PRODUCTO
                                --PERO SOLO DE LA CATEGORIA DE FUERA DE ESTE SELECT
                                WHERE P2.ID_CATEGORIA = P.ID_CATEGORIA
                                GROUP BY P2.NUMERO_PRODUCTO
                        ));



/*93. Listar por cada cliente y fecha de pedido el nombre completo y el coste total del pedido si
éste supera los 1000 euros. El coste del pedido hay que calcularlo a partir de la tabla
detalles_pedidos. */
SELECT C.ID_CLIENTE, P.FECHA_PEDIDO, C.NOMBRE, C.APELLIDOS, SUM(DP.CANTIDAD * DP.PRECIO)
FROM CLIENTES C
JOIN PEDIDOS P ON C.ID_CLIENTE = P.ID_CLIENTE
JOIN DETALLES_PEDIDOS DP ON P.NUMERO_PEDIDO = DP.NUMERO_PEDIDO
GROUP BY C.ID_CLIENTE,  P.FECHA_PEDIDO, C.NOMBRE, C.APELLIDOS, DP.PRECIO
HAVING SUM(DP.CANTIDAD*DP.PRECIO) > 1000;


/*94. ¿Cuántos pedidos hay de un sólo producto?*/
SELECT COUNT(*) AS TOTAL_PEDIDOS
FROM (
        SELECT NUMERO_PEDIDO
        FROM DETALLES_PEDIDOS
        GROUP BY NUMERO_PEDIDO --AGRUPAR POR NU NUMERO DE PEDIDO
        HAVING COUNT(*) = 1 -- PEDIDOS Q SOLO TIENEN 1 PRODUCTO
    );


--------------------------------------------------------------------------------
----------------------------------HOJA 2----------------------------------------
--------------------------------------------------------------------------------

/*95. Hacer un descuento del 2% en los pedidos que se han enviado con una demora superior a
30 días desde la fecha del pedido.
Hay que modificar el precio en cada línea de detalles_pedidos y luego, a partir de
detalles_pedidos recalcular el precio_total del pedido*/

--MODIFICAR1
UPDATE DETALLES_PEDIDOS --ACTUALIZAR DETALLES PEDIDOS
SET PRECIO = PRECIO * 0.98 --ESTABLECER ESTE DESCUENTO
WHERE NUMERO_PEDIDO IN ( --DONDE EL NUMERO PEDIDO ESTE DENTRO DE 
    SELECT NUMERO_PEDIDO  --EL NUMERO_PEDIDO 
    FROM PEDIDOS --DE PEDIDOS
    WHERE (FECHA_ENVIO - FECHA_PEDIDO) > 30 --Y DONDE HAYA ESTA DIFERENCIA DE DIAS
);
--RECALCULAR
UPDATE PEDIDOS P --ACTUALIZAR PEDIDOS P
SET PRECIO_TOTAL = ( --ESTANBLECER ESTE PRECIO_TOTAL 
                    SELECT SUM(CANTIDAD*PRECIO) --SUMAR LA MULTIPLICACION DE CANTIDAD * PRECIO PARA SABER EL PRECIO_TOTAL DEL PEDIDO 
                    FROM DETALLES_PEDIDOS DP --DE DETALLES PEDIDOS DP
                    WHERE DP.NUMERO_PEDIDO = P.NUMERO_PEDIDO) --DONDE EL NUMERO_PEDIDO DE DP Y DE P SEAN IGUALES
WHERE (FECHA_ENVIO - FECHA_PEDIDO) > 30; --DONDE HAYA ESTA DIFERENCIA DE DIAS


/*96. Aplicar un 5% de descuento a todos los pedidos de los clientes que hicieron una compra
superior a 20000 € en el mes de octubre de 2007.
Hay que modificar el precio en cada línea de detalles_pedidos y luego, a partir de
detalles_pedidos recalcular el precio_total del pedido*/

--MODIFICAR
UPDATE DETALLES_PEDIDOS
SET PRECIO = PRECIO * 0.95
WHERE NUMERO_PEDIDO IN (
                        SELECT NUMERO_PEDIDO
                        FROM PEDIDOS
                        WHERE ID_CLIENTE in ( --FILTRAMOS LOS ID_CLIENTE Q HICIERON PEDIDOS  20000 EN 10/07
                                            SELECT ID_CLIENTE
                                            FROM PEDIDOS 
                                            WHERE TO_CHAR(FECHA_PEDIDO, 'MM-YYYY') = '10-2007'
                                            GROUP BY ID_CLIENTE
                                            HAVING SUM(PRECIO_TOTAL) > 20000
                                            )
                        );

--RECALCULAR
UPDATE PEDIDOS P
SET PRECIO_TOTAL = (
                    SELECT SUM(DP.CANTIDAD * DP.PRECIO)
                    FROM DETALLES_PEDIDOS DP
                    WHERE DP.NUMERO_PEDIDO = P.NUMERO_PEDIDO
                    )
WHERE ID_CLIENTE in ( --FILTRAMOS LOS ID_CLIENTE Q HICIERON PEDIDOS  20000 EN 10/07
                    SELECT ID_CLIENTE
                    FROM PEDIDOS 
                    WHERE TO_CHAR(FECHA_PEDIDO, 'MM-YYYY') = '10-2007'
                    GROUP BY ID_CLIENTE
                    HAVING SUM(PRECIO_TOTAL) > 20000
                    );


/*97. Hacer que el precio de venta de todos los productos de la categoría 2 sea al menos un 45%
superior al precio del proveedor que tenga el precio más barato para dicho producto.
Redondear los precios sin decimales. */

UPDATE PRODUCTOS P
SET PRECIO_VENTA = (
                    SELECT ROUND(MIN(PRECIO_POR_MAYOR) * 1.45 ,0)
                    FROM PRODUCTOS_PROVEEDORES PP
                    WHERE P.NUMERO_PRODUCTO = PP.NUMERO_PRODUCTO
                    )
WHERE ID_CATEGORIA = 2;


/*98. Poner como precio de venta de los productos de la categoría 'Accesorios' el máximo precio
al por mayor que nos pongan los proveedores para ese producto más un 35%. */

UPDATE PRODUCTOS P
SET PRECIO_VENTA = (
                    SELECT ROUND(MAX(PRECIO_POR_MAYOR) * 1.35, 0)
                    FROM PRODUCTOS_PROVEEDORES PP
                    WHERE P.NUMERO_PRODUCTO = PP.NUMERO_PRODUCTO
                    )
WHERE ID_CATEGORIA = (
                      SELECT ID_CATEGORIA
                      FROM CATEGORIAS
                      WHERE UPPER(DESCRIPCION) = 'ACCESORIOS'
                      );                    


/*99. Añadir una nueva empleada con los siguientes datos: Susana Maroto, Pinares 16,
Villamanta, MADRID, 28610, código de área 425 y número de teléfono 555-7825*/
INSERT INTO EMPLEADOS
VALUES (
        (SELECT MAX(ID_EMPLEADO) + 1 
        FROM EMPLEADOS),
        'Susana',
        'Maroto',
        'Pinares 16',
        'Villamanta',
        'MADRID',
        '28610',
        425,
        '555-7825'
        );


/*100. Hemos contratado al cliente David Sanz. Añade una fila a la tabla EMPLEADOS con
todos los datos de David Sanz que están en la tabla Clientes. El id_empleado ha de ser el
siguiente al mayor valor de id_empleado que hay en la tabla. */

INSERT INTO EMPLEADOS (ID_EMPLEADO, NOMBRE, APELLIDOS, DIRECCION, CIUDAD, PROVINCIA, COD_POSTAL, CODIGO_AREA, TELEFONO)
SELECT (SELECT MAX(ID_EMPLEADO) + 1 
        FROM EMPLEADOS),
        NOMBRE, 
        APELLIDOS,
        DIRECCION,
        CIUDAD, 
        PROVINCIA,
        COD_POSTAL,
        CODIGO_AREA,
        TELEFONO
FROM CLIENTES
WHERE NOMBRE = 'David' AND APELLIDOS = 'Sanz';


/*101. Insertar un nuevo producto en la tabla de PRODUCTOS con los siguientes valores:
 El numero_producto ha de ser el siguiente al mayor valor de numero_producto
que hay en la tabla.
 nombre: Super Mega Spinner
 precio_venta: 895
 id_categoria: el valor que tenga en la tabla CATEGORIAS la categoria 'Bicicletas' 
*/
INSERT INTO PRODUCTOS (NUMERO_PRODUCTO, NOMBRE, PRECIO_VENTA, ID_CATEGORIAS)
VALUES (
        (SELECT MAX(NUMERO_PRODUCTO) +1 FROM PRODUCTOS),
        'Super Mega Spinner',
        895,
        (SELECT ID_CATEGORIA FROM CATEGORIAS WHERE UPPER(DESCRIPCION) = 'BICICLETAS')
        );


/*102. Insertar un nuevo cliente con los siguientes datos:
 El id_cliente ha de ser el siguiente al mayor valor de id_cliente que hay en la tabla.
 María Baquero
 Cantarranas 17
 Braojos
 MADRID
 28737
 área 425
 teléfono: 555-9876 */

INSERT INTO CLIENTES(
    ID_CLIENTE, NOMBRE, APELLIDOS, DIRECCION, 
    CIUDAD, PROVINCIA, COD_POSTAL, CODIGO_AREA, TELEFONO
)
VALUES(
        (SELECT MAX(ID_CLIENTE) + 1 FROM CLIENTES),
        'Maria',
        'Baquero',
        'Cantarranas 17',
        'Braojos',
        'MADRID',
        '28737',
        425,
        '555-9876'
       );

/*103. Insertar un nuevo proveedor llamado 'Super Mega Bicicletas'. El id_prov ha de ser el
siguiente al mayor valor de id_ prov que hay en la tabla. El resto de los datos son:
 calle Principal 12
 Castroviejo
 LA RIOJA
 26637
 TELF: (941) 555-6543
 FAX: (941) 555-6542
 pag_web:http://www.supermegabicicletas.com
 email: ventas@supermegabicicletas.com */



INSERT INTO PROVEEDORES (
    ID_PROV, NOMBRE, DIRECCION, CIUDAD, PROVINCIA, 
    COD_POSTAL, TELEFONO, FAX, PAG_WEB, EMAIL
)
VALUES (
    (SELECT MAX(ID_PROV) + 1 FROM PROVEEDORES),
    'Super Mega Bicicletas',
    'calle Principal 12',
    'Castroviejo',
    'LA RIOJA',
    '26637',
    '(941) 555-6543',
    '(941) 555-6542',
    'http://www.supermegabicicletas.com',
    'ventas@supermegabicicletas.com'
);



