--------------------------------------------------------------------------------
-----------------------------------HOJA 1---------------------------------------
--------------------------------------------------------------------------------
  
/*71) Calcula cuánto se ha recaudado en total con todos los pedidos.*/
SELECT SUM(PRECIO_TOTAL)
FROM PEDIDOS;

/*72) Muestra el precio más alto de cada categoría y el identificador de la categoría a la que
pertenece ese precio.*/
SELECT MAX(P.PRECIO_VENTA), C.ID_CATEGORIA
FROM PRODUCTOS P
JOIN CATEGORIAS C ON P.ID_CATEGORIA = C.ID_CATEGORIA
GROUP BY C.ID_CATEGORIA
ORDER BY C.ID_CATEGORIA;

/*73) Calcula el precio de venta medio de los productos de cada categoría, junto con el
identificador de la categoría.*/
SELECT ROUND(AVG(P.PRECIO_VENTA), 2),C.ID_CATEGORIA
FROM PRODUCTOS P
JOIN CATEGORIAS C ON P.ID_CATEGORIA = C.ID_CATEGORIA
GROUP BY C.ID_CATEGORIA
ORDER BY C.ID_CATEGORIA;


/*74) Muestra el precio más alto de cada categoría junto con el identificador y la descripción
de la categoría a la que pertenece ese precio, ordenado por identificador de la categoría.*/
SELECT ROUND(MAX(P.PRECIO_VENTA), 2),C.ID_CATEGORIA, C.DESCRIPCION
FROM PRODUCTOS P
JOIN CATEGORIAS C ON P.ID_CATEGORIA = C.ID_CATEGORIA
GROUP BY C.ID_CATEGORIA, C.DESCRIPCION
ORDER BY C.ID_CATEGORIA;

/*75) Muestra el número de productos que hay en cada categoría.*/
SELECT COUNT(*) AS NUMERO_PRODUCTOS, C.ID_CATEGORIA
FROM PRODUCTOS P
JOIN CATEGORIAS C ON P.ID_CATEGORIA = C.ID_CATEGORIA
GROUP BY C.ID_CATEGORIA
ORDER BY C.ID_CATEGORIA;


/*76) Ahora muestra la descripción e identificador de la categoría que tiene más productos
junto con el número de productos que tiene.*/
SELECT C.ID_CATEGORIA, C.DESCRIPCION, COUNT(*)
FROM PRODUCTOS P
JOIN CATEGORIAS C ON P.ID_CATEGORIA = C.ID_CATEGORIA
GROUP BY C.ID_CATEGORIA, C.DESCRIPCION
--EL HAVING ACTUA COMO UN WHERE PERO SOLO ACTUA DESPUES DE CONTAR LOS GRUPOS, ES DECIR
--DE TODOS LOS GRUPOS QUE HAS CREADO, MUESTRAME SOLO LOS QUE SEA IGUAL A ...
HAVING COUNT(*) = (SELECT MAX(COUNT(*))  --SELECCIONAR EL NUM MAXIMO
                    FROM PRODUCTOS 
                    GROUP BY ID_CATEGORIA);

/*77) Selecciona cuánto dinero se ha gastado en total en cada categoría el cliente con
identificador 1001.*/
SELECT ID_CLIENTE, SUM(PRECIO_TOTAL)AS PRECIO_TOTAL
FROM PEDIDOS
WHERE ID_CLIENTE = 1001
GROUP BY ID_CLIENTE;

/*78) Muestra la descripción de las categorías que tengan más de 5 productos en venta.*/
SELECT DISTINCT C.DESCRIPCION
FROM CATEGORIAS C
JOIN PRODUCTOS P ON C.ID_CATEGORIA = P.ID_CATEGORIA
WHERE P.STOCK > 5;


/*79) Muestra nombre, apellidos e identificador de los clientes que se han gastado más de
14000 € en productos de la categoría 1.*/
SELECT C.NOMBRE, C.APELLIDOS, C.ID_CLIENTE 
FROM CLIENTES C
JOIN PEDIDOS P ON C.ID_CLIENTE = P.ID_CLIENTE
JOIN DETALLES_PEDIDOS DP ON P.NUMERO_PEDIDO = DP.NUMERO_PEDIDO
JOIN PRODUCTOS PR ON DP.NUMERO_PRODUCTO = PR.NUMERO_PRODUCTO
WHERE P.PRECIO_TOTAL > 14000 AND PR.ID_CATEGORIA = 1
GROUP BY C.ID_CLIENTE, C.NOMBRE, C.APELLIDOS
ORDER BY C.NOMBRE;


/*80) Muestra para cada empleado cuánto dinero ha hecho en pedidos.*/
SELECT E.ID_EMPLEADO, E.NOMBRE, SUM(P.PRECIO_TOTAL) AS DINERO_PEDIDOS
FROM EMPLEADOS E
JOIN PEDIDOS P ON E.ID_EMPLEADO = P.ID_EMPLEADO
GROUP BY E.ID_EMPLEADO, E.NOMBRE;


/*81) Muestra cuánto han recaudado en pedidos los empleados 701,702 y 703*/
SELECT SUM(P.PRECIO_TOTAL) AS SUMA_PEDIDOS
FROM PEDIDOS P
JOIN EMPLEADOS E ON P.ID_EMPLEADO = E.ID_EMPLEADO
WHERE E.ID_EMPLEADO IN (701, 702, 703);

/*82) Ahora muestra los 3 empleados que más dinero han recaudado en pedidos. Debe
aparecer el identificador del empleado, el nombre y el dinero recaudado*/
SELECT * --CORTA EL RESULTADO
FROM (
    --CONSULTA NORMAL
    SELECT E.ID_EMPLEADO, E.NOMBRE, SUM(P.PRECIO_TOTAL) AS DINERO_RECAUDADO
    FROM EMPLEADOS E
    JOIN PEDIDOS P ON E.ID_EMPLEADO = P.ID_EMPLEADO
    GROUP BY E.ID_EMPLEADO, E.NOMBRE
    ORDER BY DINERO_RECAUDADO DESC)
WHERE ROWNUM <= 3; --LOS 3 PRIMEROS DE LA CONSULTA


/*83) Busca el proveedor o proveedores junto con el nombre del producto que tiene menos
días de envío. Debes mostrar nombre de proveedor junto con el nombre del producto
que tiene menos días de envío.*/
SELECT PPR.NOMBRE, P.NOMBRE
FROM PRODUCTOS_PROVEEDORES PPR
JOIN PEDIDOS P ON PPR.NUMERO_PRODUCTO = P.NUMERO_PRODUCTO
WHERE MIN(P.FECHA_ENVIO - P.FECHA_PEDIDO);


SELECT PR.NOMBRE AS PROVEEDOR, P.NOMBRE AS PRODUCTO, P.DIAS_ENVIO
FROM PROVEEDORES PR
JOIN PRODUCTOS P ON PR.ID_PROV = P.ID_PROV
WHERE P.DIAS_ENVIO = (SELECT MIN(DIAS_ENVIO) FROM PRODUCTOS);


