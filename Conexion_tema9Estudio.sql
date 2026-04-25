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
SELECT



















