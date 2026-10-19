-- =========================================================
-- seed.sql  |  Datos de prueba realistas
-- 3 categorías, 12 productos, 6 clientes, 10 pedidos, 25 líneas de detalle
-- Ejecutar DESPUÉS de schema.sql
-- =========================================================

-- 3 CATEGORÍAS
INSERT INTO categorias (id, nombre) VALUES
(1, 'Bebidas'),
(2, 'Abarrotes'),
(3, 'Limpieza');

-- 12 PRODUCTOS (precios en Bs.)
INSERT INTO productos (id, nombre, categoria_id, precio, stock) VALUES
(1,  'Coca-Cola 2 L',             1, 12.00, 40),
(2,  'Agua Vital 2 L',            1,  7.50, 35),
(3,  'Jugo Del Valle 1 L',        1, 10.00,  4),
(4,  'Cerveza Paceña 620 ml',     1, 13.00, 60),
(5,  'Arroz Caisy 1 kg',          2,  9.00, 50),
(6,  'Azúcar Guabirá 1 kg',       2,  8.00,  3),
(7,  'Aceite Fino 1 L',           2, 18.00, 25),
(8,  'Fideo Lazzaroni 400 g',     2,  6.50,  2),
(9,  'Detergente OLA 1 kg',       3, 22.00, 15),
(10, 'Lavandina Sapolio 1 L',     3,  8.50,  4),
(11, 'Jabón Bolívar 200 g',       3,  5.00, 70),
(12, 'Papel higiénico Elite x4',  3, 15.00, 20);

-- 6 CLIENTES
INSERT INTO clientes (id, nombre, telefono, email) VALUES
(1, 'Juan Mamani Quispe',     '71234567', 'juan.mamani@gmail.com'),
(2, 'María Choque Limachi',   '72345678', 'maria.choque@gmail.com'),
(3, 'Carlos Condori Apaza',   '73456789', 'carlos.condori@hotmail.com'),
(4, 'Ana Flores Ticona',      '74567890', 'ana.flores@gmail.com'),
(5, 'Luis Gutiérrez Vargas',  '75678901', 'luis.gutierrez@yahoo.com'),
(6, 'Sofía Rojas Huanca',     '76789012', 'sofia.rojas@gmail.com');   -- sin pedidos

-- 10 PEDIDOS
INSERT INTO pedidos (id, cliente_id, fecha, estado) VALUES
(1,  1, '2026-10-01', 'entregado'),
(2,  1, '2026-10-03', 'entregado'),
(3,  1, '2026-10-10', 'enviado'),
(4,  2, '2026-10-02', 'entregado'),
(5,  2, '2026-10-08', 'pagado'),
(6,  2, '2026-10-15', 'pendiente'),
(7,  3, '2026-10-05', 'entregado'),
(8,  4, '2026-10-06', 'cancelado'),
(9,  4, '2026-10-12', 'pagado'),
(10, 5, '2026-10-14', 'pendiente');

-- 25 LÍNEAS DE DETALLE
INSERT INTO detalle_pedido (id, pedido_id, producto_id, cantidad, precio_unitario) VALUES
(1,  1,  1, 2, 12.00),
(2,  1,  5, 3,  9.00),
(3,  1, 11, 4,  5.00),
(4,  2,  4, 6, 13.00),
(5,  2,  7, 1, 18.00),
(6,  3,  2, 3,  7.50),
(7,  3,  9, 1, 22.00),
(8,  3, 12, 2, 15.00),
(9,  4,  6, 2,  8.00),
(10, 4,  8, 5,  6.50),
(11, 4,  3, 1, 10.00),
(12, 5,  1, 4, 12.00),
(13, 5, 10, 2,  8.50),
(14, 6,  5, 2,  9.00),
(15, 6,  7, 2, 18.00),
(16, 6, 11, 3,  5.00),
(17, 7,  4, 12, 13.00),
(18, 7,  2, 2,  7.50),
(19, 8,  9, 1, 22.00),
(20, 8, 12, 1, 15.00),
(21, 9,  3, 2, 10.00),
(22, 9,  6, 1,  8.00),
(23, 9,  8, 3,  6.50),
(24, 10, 1, 1, 12.00),
(25, 10, 10, 1, 8.50);

-- Ajustar las secuencias de SERIAL (solo PostgreSQL) para que los
-- próximos INSERT sin id no choquen con los ids ya usados
SELECT setval('categorias_id_seq',     (SELECT MAX(id) FROM categorias));
SELECT setval('productos_id_seq',      (SELECT MAX(id) FROM productos));
SELECT setval('clientes_id_seq',       (SELECT MAX(id) FROM clientes));
SELECT setval('pedidos_id_seq',        (SELECT MAX(id) FROM pedidos));
SELECT setval('detalle_pedido_id_seq', (SELECT MAX(id) FROM detalle_pedido));
