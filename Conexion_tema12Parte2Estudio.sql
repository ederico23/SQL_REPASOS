SET SERVEROUTPUT ON;
/*1. Desarrollar un procedimiento que visualice el apellido del cliente y la fecha de pedido de todos los
pedidos ordenados por apellido.*/

CREATE OR REPLACE PROCEDURE verApellidos
IS
    CURSOR c_apellido IS 
        SELECT c.apellidos, p.fecha_pedido
        FROM clientes c
        JOIN pedidos p ON c.id_cliente = p.id_cliente
        ORDER BY c.apellidos;
    
    v_reg c_apellido%ROWTYPE;
    
BEGIN 
    OPEN c_apellido;
    FETCH c_apellido INTO v_reg;
    
    WHILE c_apellido%FOUND LOOP 
        DBMS_OUTPUT.PUT_LINE(v_reg.apellidos || ' ' || v_reg.fecha_pedido);
        FETCH c_apellido INTO v_reg;
    END LOOP;
    
    CLOSE c_apellido;
END verApellidos;
/
EXECUTE verApellidos();
/


/*2. Codificar un procedimiento que muestre la descripción de cada categoría y el número de productos
que tiene.*/
CREATE OR REPLACE PROCEDURE contarProductos
IS
    CURSOR c_contar IS
        SELECT c.descripcion, COUNT(p.numero_producto) AS disponible
        FROM categorias c
        JOIN productos p ON c.id_categoria = p.id_categoria
        GROUP BY c.descripcion
        ORDER BY c.descripcion;
        
        v_reg c_contar%ROWTYPE;
        
BEGIN 
    OPEN c_contar;
    FETCH c_contar INTO v_reg;
    
    WHILE c_contar%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE(v_reg.descripcion || ' ' || v_reg.disponible);
        FETCH c_contar INTO v_reg;
    END LOOP;
    CLOSE c_contar;
END contarProductos;
/
EXECUTE contarProductos();
/
        


        
