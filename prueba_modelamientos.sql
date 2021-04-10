CREATE DATABASE prueba;
\c prueba;

CREATE TABLE cliente(
    id SERIAL,
    nombre VARCHAR(30),
    rut VARCHAR(9) UNIQUE,
    direccion VARCHAR(300),
    PRIMARY KEY(id));

CREATE TABLE factura(
    nro_fc INT, 
    fecha_de_factura TIMESTAMP, 
    subtotal INT, 
    iva INT, 
    total INT,
    id_cliente INT,
    PRIMARY KEY (nro_fc),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id));

CREATE TABLE categoria(
    id SERIAL,
    nombre VARCHAR(30),
    descripcion VARCHAR(100),
    PRIMARY KEY(id));

CREATE TABLE productos(
    id SERIAL,
    nombre VARCHAR(30),
    descripcion VARCHAR(100),
    valor_unit INT,
    id_categoria INT,
    PRIMARY KEY(id),
    FOREIGN KEY(id_categoria) REFERENCES categoria(id));

CREATE TABLE fc_productos(
    id SERIAL,
    id_productos INT,
    nro_fc_factura INT,
    cantidad INT,
    valor_total_producto INT,
    PRIMARY KEY(id),
    FOREIGN KEY(id_productos) REFERENCES productos(id),
    FOREIGN KEY(nro_fc_factura) REFERENCES factura(nro_fc));

INSERT INTO cliente(nombre, rut, direccion) VALUES ('miguel', '123456789', 'tarpaca'), ('patricia', '987654321', 'san francisco'), ('diego', '111111111', 'coquimbo'), ('andrea', '999999999', 'copiapo'), ('enzo', '888888888', 'irarrazaval');

INSERT INTO categoria(nombre, descripcion) VALUES ('lacteos', 'productos lacteos'), ('carnes', 'solo vacuno'), ('dulces', 'todo tipo de golosinas');

INSERT INTO productos(nombre, descripcion, valor_unit, id_categoria) VALUES ('carne molida', 'sin grasa', 100, 2), ('mantequilla', 'sin sal', 25, 1), ('leche descremada', 'colun', 20, 1), ('bebida chocolatada', 'soprole', 25, 1), ('costilla', 'paleta', 120, 2), ('papas americanas', 'lays', 20, 3), ('nachos', 'pancho villa', 22, 3), ('nutella', 'original', 50, 3);

INSERT INTO factura(nro_fc, fecha_de_factura, subtotal, iva, total, id_cliente) VALUES (001, '2021-01-09 19:02:55', 125, 24, 149, 1), (002, '2021-01-10 07:00:01', 165, 31, 196, 1);

INSERT INTO factura(nro_fc, fecha_de_factura, subtotal, iva, total, id_cliente) VALUES(003, '2021-02-01 12:00:00', 92, 17, 109, 2), (004, '2021-02-02 13:04:00', 45, 9, 54, 2), (005, '2021-02-02 17:14:00', 145, 28, 173, 2);

INSERT INTO factura(nro_fc, fecha_de_factura, subtotal, iva, total, id_cliente) VALUES(006, '2021-02-01 21:12:00', 120, 23, 143, 3);

INSERT INTO factura(nro_fc, fecha_de_factura, subtotal, iva, total, id_cliente) VALUES(007, '2021-02-20 11:00:00', 72, 14, 86, 4), (008, '2021-02-21 13:15:00', 165, 31, 196, 4), (009, '2021-02-22 19:03:00', 170, 32, 202, 4), (010, '2021-02-25 22:38:10', 20, 4, 24, 4);

INSERT INTO fc_productos(id_productos, nro_fc_factura, cantidad, valor_total_producto) VALUES (1, 001, 1, 100), (2, 001, 1, 25), (3, 002, 1, 20), (4, 002, 1, 25), (5, 002, 1, 120), (6, 003, 1, 20), (7, 003, 1, 22), (8, 003, 1, 50), (3, 004, 1, 20), (4, 004, 1, 25), (3, 005, 5, 100), (2, 005, 1, 25), (3, 005, 1, 20), (6, 006, 6, 120), (8, 007, 1, 50), (7, 007, 1, 22), (4, 008, 1, 25), (5, 008, 1, 120), (6, 008, 1, 20), (1, 009, 1, 100), (2, 009, 1, 25), (3, 009, 1, 20), (4, 009, 1, 25), (3, 010, 1, 20);

--¿Que cliente realizó la compra más cara?
SELECT nombre, id, nro_fc, total FROM cliente INNER JOIN factura ON id_cliente=cliente.id  ORDER BY total DESC LIMIT 1;

--¿Que cliente pagó sobre 100 de monto?
SELECT nombre, id, nro_fc, total FROM cliente INNER JOIN factura ON id_cliente=cliente.id WHERE total>100;

--¿Cuantos clientes han comprado el producto 6.
SELECT COUNT(id_cliente) FROM factura INNER JOIN fc_productos ON factura.nro_fc = fc_productos.nro_fc_factura WHERE id_productos= 6;