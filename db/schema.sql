-- =========================================================
-- schema.sql  |  Práctica 1 - Programación Web III
-- Base de datos de un negocio (tienda): creación de tablas
-- Motor: PostgreSQL (compatible con MySQL cambiando SERIAL por INT AUTO_INCREMENT)
-- =========================================================

DROP TABLE IF EXISTS detalle_pedido;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS categorias;

-- 1. CATEGORIAS: una categoría tiene muchos productos
CREATE TABLE categorias (
    id      SERIAL PRIMARY KEY,
    nombre  VARCHAR(50) NOT NULL UNIQUE
);

-- 2. PRODUCTOS: cada producto pertenece a una categoría
CREATE TABLE productos (
    id            SERIAL PRIMARY KEY,
    nombre        VARCHAR(100)  NOT NULL,
    categoria_id  INT           NOT NULL,
    precio        DECIMAL(10,2) NOT NULL CHECK (precio >= 0),
    stock         INT           NOT NULL DEFAULT 0 CHECK (stock >= 0),
    CONSTRAINT fk_productos_categoria
        FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- 3. CLIENTES: un cliente tiene muchos pedidos
CREATE TABLE clientes (
    id        SERIAL PRIMARY KEY,
    nombre    VARCHAR(100) NOT NULL,
    telefono  VARCHAR(20),
    email     VARCHAR(100) NOT NULL UNIQUE
);

-- 4. PEDIDOS: cada pedido pertenece a un cliente
CREATE TABLE pedidos (
    id          SERIAL PRIMARY KEY,
    cliente_id  INT         NOT NULL,
    fecha       DATE        NOT NULL DEFAULT CURRENT_DATE,
    estado      VARCHAR(20) NOT NULL DEFAULT 'pendiente'
                CHECK (estado IN ('pendiente', 'pagado', 'enviado', 'entregado', 'cancelado')),
    CONSTRAINT fk_pedidos_cliente
        FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- 5. DETALLE_PEDIDO: tabla intermedia que une pedidos y productos (N:M)
CREATE TABLE detalle_pedido (
    id               SERIAL PRIMARY KEY,
    pedido_id        INT           NOT NULL,
    producto_id      INT           NOT NULL,
    cantidad         INT           NOT NULL CHECK (cantidad > 0),
    precio_unitario  DECIMAL(10,2) NOT NULL CHECK (precio_unitario >= 0),
    CONSTRAINT fk_detalle_pedido
        FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (producto_id) REFERENCES productos(id)
);
