-- =========================================================
-- consultas.sql  |  7 consultas sobre la base del negocio
-- Ejecutar DESPUÉS de schema.sql y seed.sql
-- =========================================================

-- 1. ¿Qué productos hay y a qué categoría pertenece cada uno? (ordenados por nombre)
--    JOIN + ORDER BY
SELECT p.id,
       p.nombre  AS producto,
       c.nombre  AS categoria,
       p.precio,
       p.stock
FROM productos p
JOIN categorias c ON c.id = p.categoria_id
ORDER BY p.nombre ASC;

-- 2. ¿Qué productos tienen menos de 5 unidades en stock?
--    WHERE
SELECT id, nombre, stock
FROM productos
WHERE stock < 5
ORDER BY stock ASC;

-- 3. ¿Cuál es el precio promedio de los productos en cada categoría?
--    GROUP BY + AVG
SELECT c.nombre                 AS categoria,
       ROUND(AVG(p.precio), 2)  AS precio_promedio,
       COUNT(p.id)              AS cantidad_productos
FROM categorias c
JOIN productos p ON p.categoria_id = c.id
GROUP BY c.nombre
ORDER BY precio_promedio DESC;

-- 4. ¿Qué pedidos hizo el cliente "juan.mamani@gmail.com", con su fecha y estado?
--    JOIN + WHERE
SELECT cl.nombre AS cliente,
       pe.id     AS pedido,
       pe.fecha,
       pe.estado
FROM pedidos pe
JOIN clientes cl ON cl.id = pe.cliente_id
WHERE cl.email = 'juan.mamani@gmail.com'
ORDER BY pe.fecha;

-- 5. ¿Cuánto dinero suma en total cada pedido?
--    SUM + GROUP BY
SELECT pe.id                                     AS pedido,
       cl.nombre                                 AS cliente,
       SUM(d.cantidad * d.precio_unitario)       AS total_bs
FROM pedidos pe
JOIN clientes cl       ON cl.id = pe.cliente_id
JOIN detalle_pedido d  ON d.pedido_id = pe.id
GROUP BY pe.id, cl.nombre
ORDER BY pe.id;

-- 6. ¿Qué clientes hicieron más de 2 pedidos?
--    GROUP BY + HAVING
SELECT cl.id,
       cl.nombre,
       COUNT(pe.id) AS total_pedidos
FROM clientes cl
JOIN pedidos pe ON pe.cliente_id = cl.id
GROUP BY cl.id, cl.nombre
HAVING COUNT(pe.id) > 2;

-- 7. Eliminar a los clientes que no tienen ningún pedido
--    DELETE (en los datos de prueba solo Sofía Rojas no tiene pedidos)
DELETE FROM clientes
WHERE id NOT IN (SELECT DISTINCT cliente_id FROM pedidos);

-- Verificación: Sofía ya no debe aparecer
SELECT * FROM clientes;
