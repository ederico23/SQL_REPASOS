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
SELECT NOMBRE, PAG_WEB
FROM PROVEEDORES
WHERE PAG_WEB IS NOT NULL ;




-------------------------------------------------------------------------------
---------------------------------HOJA 2----------------------------------------
-------------------------------------------------------------------------------