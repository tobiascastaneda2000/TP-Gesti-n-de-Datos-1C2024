USE GD1C2024;
GO

CREATE SCHEMA LOS_MIGRADORES;
GO

/*
-- Verifica si el esquema ya existe
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'LOS_MIGRADORES')
BEGIN
    EXEC('CREATE SCHEMA LOS_MIGRADORES');
END
GO
*/
-- Eliminación de tablas si existen
DROP TABLE IF EXISTS LOS_MIGRADORES.Ticket_Detalle;
DROP TABLE IF EXISTS LOS_MIGRADORES.Promocion_Por_Ticket;
DROP TABLE IF EXISTS LOS_MIGRADORES.Promo_por_Producto;
DROP TABLE IF EXISTS LOS_MIGRADORES.Pago_Por_Descuento;
DROP TABLE IF EXISTS LOS_MIGRADORES.Descuento_MP;
DROP TABLE IF EXISTS LOS_MIGRADORES.Envio;
DROP TABLE IF EXISTS LOS_MIGRADORES.Pago;
DROP TABLE IF EXISTS LOS_MIGRADORES.Detalle_Pago;
DROP TABLE IF EXISTS LOS_MIGRADORES.Medio_de_Pago;
DROP TABLE IF EXISTS LOS_MIGRADORES.Ticket;
DROP TABLE IF EXISTS LOS_MIGRADORES.Cliente;
DROP TABLE IF EXISTS LOS_MIGRADORES.Promo_por_Regla;
DROP TABLE IF EXISTS LOS_MIGRADORES.Regla;
DROP TABLE IF EXISTS LOS_MIGRADORES.Producto_por_Promo;
DROP TABLE IF EXISTS LOS_MIGRADORES.Promocion;
DROP TABLE IF EXISTS LOS_MIGRADORES.Producto;
DROP TABLE IF EXISTS LOS_MIGRADORES.Subcategoria;
DROP TABLE IF EXISTS LOS_MIGRADORES.Categoria;
DROP TABLE IF EXISTS LOS_MIGRADORES.Empleado;
DROP TABLE IF EXISTS LOS_MIGRADORES.Caja_por_Tipo_de_Caja;
DROP TABLE IF EXISTS LOS_MIGRADORES.Caja;
DROP TABLE IF EXISTS LOS_MIGRADORES.Tipo_Caja;
DROP TABLE IF EXISTS LOS_MIGRADORES.Sucursal;
DROP TABLE IF EXISTS LOS_MIGRADORES.Super;
GO

/* CREACION TABLA Super */
CREATE TABLE LOS_MIGRADORES.Super (
    super_nombre NVARCHAR(255) PRIMARY KEY NOT NULL,
    super_cuit NVARCHAR(255) NOT NULL,
    super_iibb NVARCHAR(255),
    super_domicilio NVARCHAR(255),
    super_fecha_en_actividad DATETIME,
    super_condicion_fiscal NVARCHAR(255),
    super_localidad NVARCHAR(255) NOT NULL,
    super_provincia NVARCHAR(255) NOT NULL,
    super_razon_social NVARCHAR(255) NOT NULL
);
GO

--select PRODUCTO_SUB_CATEGORIA from gd_esquema.Maestra


/* CREACION TABLA Sucursal */
CREATE TABLE LOS_MIGRADORES.Sucursal (
	sucursal_nombre NVARCHAR(255) PRIMARY KEY,
	sucursal_direccion NVARCHAR(255) NOT NULL,
	sucursal_localidad NVARCHAR(255) NOT NULL,
	sucursal_provincia NVARCHAR(255) NOT NULL,
	sucursal_super NVARCHAR(255) NOT NULL,
)
GO

ALTER TABLE LOS_MIGRADORES.sucursal
ADD CONSTRAINT FK_sucursal_super
FOREIGN KEY (sucursal_super) REFERENCES LOS_MIGRADORES.Super(super_nombre);
GO
/* CREACION TABLA Tipo de caja */
CREATE TABLE LOS_MIGRADORES.Tipo_Caja (
    tipocaja_nombre NVARCHAR(255) PRIMARY KEY
);
GO

/* CREACION TABLA Caja */ --Por que hay filas donde no hay caja_numero pero si una sucursal???

CREATE TABLE LOS_MIGRADORES.Caja (
	caja_id INT IDENTITY(1,1) PRIMARY KEY,
	caja_numero INT NOT NULL,
	caja_sucursal NVARCHAR(255) NOT NULL
);
GO

ALTER TABLE LOS_MIGRADORES.Caja
ADD CONSTRAINT FK_caja_sucursal 
FOREIGN KEY (caja_sucursal) REFERENCES LOS_MIGRADORES.Sucursal(sucursal_nombre);
GO

/* CREACION TABLA Caja_por_Tipo_de_caja */

CREATE TABLE LOS_MIGRADORES.Caja_por_Tipo_de_Caja (
     caja_id INT,
	 tipocaja_nombre NVARCHAR(255)
	 PRIMARY KEY(caja_id, tipocaja_nombre)
)
GO

ALTER TABLE LOS_MIGRADORES.Caja_por_Tipo_de_Caja
ADD CONSTRAINT FK_caja_por_tipo_de_caja_a_caja 
FOREIGN KEY (caja_id) REFERENCES LOS_MIGRADORES.Caja(caja_id);
GO

ALTER TABLE LOS_MIGRADORES.Caja_por_Tipo_de_Caja
ADD CONSTRAINT FK_caja_por_tipo_de_caja_a_tipo_de_caja 
FOREIGN KEY (tipocaja_nombre) REFERENCES LOS_MIGRADORES.Tipo_Caja(tipocaja_nombre);
GO
/* CREACION TABLA Empleado */
CREATE TABLE LOS_MIGRADORES.Empleado (
    empleado_dni INT PRIMARY KEY,
    empleado_nombre NVARCHAR(255) NOT NULL,
    empleado_apellido NVARCHAR(255) NOT NULL,
	empleado_fecha_registro DATETIME NOT NULL,
	empleado_telefono INT NOT NULL,
	empleado_mail NVARCHAR(255) NOT NULL,
	empleado_fecha_nacimiento DATETIME NOT NULL,
	empleado_sucursal NVARCHAR(255)
);
GO



ALTER TABLE LOS_MIGRADORES.Empleado
ADD CONSTRAINT FK_empleado_sucursal
FOREIGN KEY (empleado_sucursal) REFERENCES LOS_MIGRADORES.Sucursal(sucursal_nombre);
GO

/* CREACION TABLA Categoria */

CREATE TABLE LOS_MIGRADORES.Categoria (
	categoria_nombre NVARCHAR(255) PRIMARY KEY
);
GO


/* CREACION TABLA Subcategoria */

CREATE TABLE LOS_MIGRADORES.Subcategoria (
    subcategoria_id INT IDENTITY PRIMARY KEY,
	subcategoria_nombre NVARCHAR(255),
	subcategoria_categoria NVARCHAR(255) NOT NULL
);
GO

ALTER TABLE LOS_MIGRADORES.Subcategoria
ADD CONSTRAINT FK_subcategoria_categoria 
FOREIGN KEY (subcategoria_categoria) REFERENCES LOS_MIGRADORES.Categoria(categoria_nombre);
GO


/* CREACION TABLA Producto */

CREATE TABLE LOS_MIGRADORES.Producto (
    producto_id INT IDENTITY(1,1) PRIMARY KEY,
    producto_nombre NVARCHAR(255) NOT NULL,
    producto_descripcion NVARCHAR(255) NOT NULL,
    producto_precio DECIMAL(12,2) NOT NULL,
    producto_marca NVARCHAR(255) NOT NULL,
	producto_subcategoria INT NOT NULL
);
GO

ALTER TABLE LOS_MIGRADORES.Producto
ADD CONSTRAINT FK_producto_subcategoria
FOREIGN KEY (producto_subcategoria) REFERENCES LOS_MIGRADORES.Subcategoria(subcategoria_id);
GO




/* CREACION TABLA Promocion */
--132 filas
CREATE TABLE LOS_MIGRADORES.Promocion (
    promo_codigo INT PRIMARY KEY,
    promo_descripccion NVARCHAR(255) NOT NULL,
    promo_fecha_inicio DATETIME NOT NULL,
    promo_fecha_fin DATETIME NOT NULL
); 
GO



/* CREACION TABLA Promo_por_Producto */
CREATE TABLE LOS_MIGRADORES.Producto_por_Promo(
    producto_id INT,
	promo_codigo INT,
	PRIMARY KEY(producto_id, promo_codigo)
	);
GO

ALTER TABLE LOS_MIGRADORES.Producto_por_Promo
ADD CONSTRAINT FK_producto
FOREIGN KEY (producto_id) REFERENCES LOS_MIGRADORES.Producto(producto_id);
GO

ALTER TABLE LOS_MIGRADORES.Producto_por_Promo
ADD CONSTRAINT FK_promo
FOREIGN KEY (promo_codigo) REFERENCES LOS_MIGRADORES.Promocion(promo_codigo);
GO

/* CREACION TABLA Regla */
--3 filas
CREATE TABLE LOS_MIGRADORES.Regla (
    regla_descripccion NVARCHAR(50) PRIMARY KEY, 
	regla_cant_aplica_descuento INT, 
	regla_cant_aplicable_regla INT,
    regla_descuento_aplicable_prod DECIMAL,
	regla_aplica_misma_marca INT,
	regla_aplica_mismo_prod INT, 
	regla_cant_max_prod INT);
GO

/* CREACION TABLA Promo_por_Regla */
CREATE TABLE LOS_MIGRADORES.Promo_por_Regla(
    regla_descripccion NVARCHAR(50),
	promo_codigo INT,
	PRIMARY KEY (regla_descripccion, promo_codigo)
	);
GO

ALTER TABLE LOS_MIGRADORES.Promo_por_Regla
ADD CONSTRAINT FK_regla_descripccion
FOREIGN KEY (regla_descripccion) REFERENCES LOS_MIGRADORES.Regla(regla_descripccion);
GO

ALTER TABLE LOS_MIGRADORES.Promo_por_Regla
ADD CONSTRAINT FK_promo_codigo
FOREIGN KEY (promo_codigo) REFERENCES LOS_MIGRADORES.Promocion(promo_codigo);
GO


/* CREACION TABLA Cliente */

CREATE TABLE LOS_MIGRADORES.Cliente (
    cliente_dni INT PRIMARY KEY,
    cliente_nombre NVARCHAR(255) NOT NULL,
    cliente_apellido NVARCHAR(255) NOT NULL,
	cliente_fecha_registro DATETIME NOT NULL,
	cliente_telefono INT NOT NULL,
	cliente_mail NVARCHAR(255) NOT NULL,
	cliente_fecha_nacimiento DATETIME NOT NULL,
	cliente_domicilio NVARCHAR(255) NOT NULL,
	cliente_localidad NVARCHAR(255) NOT NULL,
	cliente_provincia NVARCHAR(255) NOT NULL
);
GO

/* CREACION TABLA Ticket */
CREATE TABLE LOS_MIGRADORES.Ticket(
    ticket_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
    ticket_numero DECIMAL(18,0),
    ticket_fecha_hora DATETIME NOT NULL,
    ticket_tipo_comprobante NVARCHAR(255) NOT NULL,
    ticket_subtotal_productos DECIMAL(18,2) NOT NULL,
    ticket_total_descuento_aplicado DECIMAL(18,2) NOT NULL,
    ticket_total_descuento_aplicado_mp DECIMAL(18,2) NOT NULL,
    ticket_total_ticket DECIMAL(18,2) NOT NULL,
    ticket_sucursal NVARCHAR(255) NOT NULL,
    ticket_caja INT NOT NULL,
    ticket_empleado INT NOT NULL,
    ticket_cliente INT,
	ticket_tipo_caja NVARCHAR(255) NOT NULL
);
GO



--select TICKET_NUMERO from gd_esquema.Maestra
/* restricción de clave externa para sucursal_id */
ALTER TABLE LOS_MIGRADORES.Ticket
ADD CONSTRAINT FK_ticket_sucursal
FOREIGN KEY (ticket_sucursal) 
REFERENCES LOS_MIGRADORES.Sucursal(sucursal_nombre);
GO
/* restricción de clave externa para caja_codigo */
ALTER TABLE LOS_MIGRADORES.Ticket
ADD CONSTRAINT FK_ticket_caja
FOREIGN KEY (ticket_caja) 
REFERENCES LOS_MIGRADORES.Caja(caja_id);
GO
/* restricción de clave externa para empleado_dni */
ALTER TABLE LOS_MIGRADORES.Ticket
ADD CONSTRAINT FK_ticket_empleado
FOREIGN KEY (ticket_empleado) 
REFERENCES LOS_MIGRADORES.Empleado(empleado_dni);
GO
/* restricción de clave externa para cliente_id */
ALTER TABLE LOS_MIGRADORES.Ticket
ADD CONSTRAINT FK_ticket_cliente
FOREIGN KEY (ticket_cliente) 
REFERENCES LOS_MIGRADORES.Cliente(cliente_dni);
GO

ALTER TABLE LOS_MIGRADORES.Ticket
ADD CONSTRAINT FK_ticket_tipo_caja
FOREIGN KEY (ticket_tipo_caja) 
REFERENCES LOS_MIGRADORES.Tipo_Caja(tipocaja_nombre);
GO
/* CREACION TABLA Ticket_Detalle */
CREATE TABLE LOS_MIGRADORES.Ticket_Detalle (
    ticket_id DECIMAL(18,0) NOT NULL,
    producto_id INT NOT NULL,
    ticket_det_cantidad DECIMAL(18,0) NOT NULL,
    ticket_det_precio DECIMAL(18,2),  
    ticket_det_total DECIMAL(18,2) NOT NULL,
    promo_aplicada_descuento DECIMAL(18,2) NULL,
    PRIMARY KEY (ticket_id, producto_id),
    FOREIGN KEY (ticket_id) REFERENCES LOS_MIGRADORES.Ticket(ticket_id),
    FOREIGN KEY (producto_id) REFERENCES LOS_MIGRADORES.Producto(producto_id)
);
GO


/* CREACION TABLA Promocion_Por_Ticket */
CREATE TABLE LOS_MIGRADORES.Promocion_Por_Ticket (
    ticket_id DECIMAL(18,0),
    producto_id INT,
    promo_codigo INT,
    PRIMARY KEY (ticket_id, producto_id, promo_codigo),
    FOREIGN KEY (ticket_id) REFERENCES LOS_MIGRADORES.Ticket(ticket_id),
    FOREIGN KEY (producto_id) REFERENCES LOS_MIGRADORES.Producto(producto_id),
    FOREIGN KEY (promo_codigo) REFERENCES LOS_MIGRADORES.Promocion(promo_codigo)
);
GO
/* CREACION TABLA Medio_de_Pago */
CREATE TABLE LOS_MIGRADORES.Medio_de_Pago (
    medio_pago_nombre NVARCHAR(255) PRIMARY KEY NOT NULL,
    medio_pago_tipo NVARCHAR(255) NOT NULL
);
GO

/*CREACION TABLA Detalle_pago*/
CREATE TABLE LOS_MIGRADORES.Detalle_Pago (
    detallepago_id INT IDENTITY(1,1) PRIMARY KEY,
	detallepago_tarjeta_numero NVARCHAR(255) NOT NULL,
	detallepago_tarjeta_fecha_vencimiento DATETIME NOT NULL,
	detallepago_tarjeta_cuotas INT NOT NULL,
);
GO

/* CREACION TABLA Pago */
CREATE TABLE LOS_MIGRADORES.Pago (
    pago_id INT IDENTITY(1,1) PRIMARY KEY,
	pago_fecha DATETIME NOT NULL,
	pago_importe INT NOT NULL,
	pago_descuento_aplicado INT NOT NULL,
	pago_ticket_id DECIMAL(18,0) NOT NULL,
	pago_medio_pago NVARCHAR(255),
	pago_detalle_pago INT NULL
);
GO

ALTER TABLE LOS_MIGRADORES.Pago
ADD CONSTRAINT FK_pago_ticket_numero
FOREIGN KEY (pago_ticket_id) REFERENCES LOS_MIGRADORES.Ticket(ticket_id);
GO

ALTER TABLE LOS_MIGRADORES.Pago
ADD CONSTRAINT FK_pago_medio_pago
FOREIGN KEY (pago_medio_pago) REFERENCES LOS_MIGRADORES.Medio_de_Pago(medio_pago_nombre);
GO

ALTER TABLE LOS_MIGRADORES.Pago
ADD CONSTRAINT FK_pago_detalle_pago
FOREIGN KEY (pago_detalle_pago) REFERENCES LOS_MIGRADORES.Detalle_Pago(detallepago_id);
GO




/* CREACION TABLA Descuento_MP */
CREATE TABLE LOS_MIGRADORES.Descuento_MP (
    descuento_codigo DECIMAL(18,0) PRIMARY KEY NOT NULL,
    descuento_descripcion NVARCHAR(255) NOT NULL,
    descuento_fecha_inicio DATETIME NOT NULL,
    descuento_fecha_fin DATETIME NOT NULL,
    descuento_porcentaje_desc DECIMAL(18,2) NOT NULL,
    descuento_tope DECIMAL(18,2) NOT NULL,
    pago_medio_pago_id NVARCHAR(255) NOT NULL
);
GO

ALTER TABLE LOS_MIGRADORES.Descuento_MP
ADD CONSTRAINT FK_Descuento_MP_Medio_de_Pago
FOREIGN KEY (pago_medio_pago_id) REFERENCES LOS_MIGRADORES.Medio_de_Pago(medio_pago_nombre);
GO

/* CREACION TABLA Pago_por_descuento */
CREATE TABLE LOS_MIGRADORES.Pago_Por_Descuento (
    pago_id INT,
    descuento_id DECIMAL(18,0),
    PRIMARY KEY (pago_id, descuento_id)
); 
GO

/* restricción de clave externa para pago_id */
ALTER TABLE LOS_MIGRADORES.Pago_Por_Descuento
ADD CONSTRAINT FK_pago_id
FOREIGN KEY (pago_id) 
REFERENCES LOS_MIGRADORES.Pago(pago_id);
GO

/* restricción de clave externa para descuento_codigo */
ALTER TABLE LOS_MIGRADORES.Pago_Por_Descuento
ADD CONSTRAINT FK_descuento_id
FOREIGN KEY (descuento_id) 
REFERENCES LOS_MIGRADORES.Descuento_MP(descuento_codigo);
GO
/* CREACION TABLA Envio */

CREATE TABLE LOS_MIGRADORES.Envio (
    envio_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    envio_costo DECIMAL(18,2),
    envio_fecha_programada DATETIME,
    envio_hora_inicio DECIMAL(18,0),
    envio_hora_fin DECIMAL(18,0),
    envio_fecha_entrega DATETIME,
    envio_estado NVARCHAR(255),
    ticket_id DECIMAL(18,0),
    FOREIGN KEY (ticket_id) REFERENCES LOS_MIGRADORES.Ticket(ticket_id)
);
GO
/*Migracion de datos*/

/* Migracion de datos tabla Super */

PRINT 'Migrando datos a tabla Super...'
--1 fila
INSERT INTO LOS_MIGRADORES.Super (super_nombre, super_cuit, super_iibb, super_domicilio, super_fecha_en_actividad, super_condicion_fiscal, super_localidad, super_provincia, super_razon_social)
SELECT distinct SUPER_NOMBRE, SUPER_CUIT, SUPER_IIBB, SUPER_DOMICILIO, SUPER_FECHA_INI_ACTIVIDAD, SUPER_CONDICION_FISCAL, SUPER_LOCALIDAD, SUPER_PROVINCIA, SUPER_RAZON_SOC
FROM gd_esquema.Maestra
where SUPER_NOMBRE is not null
GO



/* Migracion de datos tabla Sucursal */
--8 filas
INSERT INTO LOS_MIGRADORES.Sucursal (sucursal_nombre, sucursal_direccion, sucursal_localidad, sucursal_provincia, sucursal_super)
SELECT distinct m.SUCURSAL_NOMBRE, m.SUCURSAL_DIRECCION, m.SUCURSAL_LOCALIDAD, m.SUCURSAL_PROVINCIA, SUPER_NOMBRE
FROM gd_esquema.Maestra m
where SUCURSAL_NOMBRE is not null
GO
PRINT 'Migracion completa a tabla Sucursal...'


/* Migracion de datos tabla Tipo de caja */
INSERT INTO LOS_MIGRADORES.Tipo_Caja (tipocaja_nombre)
SELECT distinct CAJA_TIPO
FROM gd_esquema.Maestra
where CAJA_TIPO is not null;
GO
PRINT 'Migracion completa a tabla Tipo_caja...'

/* Migracion de datos tabla Caja */
PRINT 'Migrando datos a tabla Caja...'
--63 filas
INSERT INTO LOS_MIGRADORES.Caja (caja_numero, caja_sucursal)
SELECT distinct CAJA_NUMERO, SUCURSAL_NOMBRE
FROM gd_esquema.Maestra
where CAJA_NUMERO is not null
GO


/* Migracion de datos tabla Caja_por_Tipo_de_caja */
--63 filas
INSERT INTO LOS_MIGRADORES.Caja_por_Tipo_de_Caja(caja_id, tipocaja_nombre)
SELECT distinct c.caja_id, m.CAJA_TIPO
FROM gd_esquema.Maestra m
join LOS_MIGRADORES.Caja c on m.CAJA_NUMERO = c.caja_numero and m.SUCURSAL_NOMBRE = c.caja_sucursal
where CAJA_TIPO is not null
GO
PRINT 'Migracion completa a tabla Caja_por_Tipo_de_caja...'

/* Migracion de datos tabla Empleado */
--63 filas

INSERT INTO LOS_MIGRADORES.Empleado (empleado_dni, empleado_nombre, empleado_apellido, empleado_fecha_registro, empleado_telefono, empleado_mail, empleado_fecha_nacimiento, empleado_sucursal)
SELECT DISTINCT EMPLEADO_DNI, EMPLEADO_NOMBRE, EMPLEADO_APELLIDO, EMPLEADO_FECHA_REGISTRO, EMPLEADO_TELEFONO, EMPLEADO_MAIL, EMPLEADO_FECHA_NACIMIENTO, SUCURSAL_NOMBRE 
FROM gd_esquema.Maestra
WHERE empleado_dni is not null;
GO
PRINT 'Migracion completa a tabla Empleado...'

/* Migracion de datos tabla Categoria */
--7 filas
INSERT INTO LOS_MIGRADORES.Categoria (categoria_nombre)
SELECT distinct PRODUCTO_CATEGORIA
FROM gd_esquema.Maestra
where PRODUCTO_CATEGORIA is not null
GO
PRINT 'Migracion completa a tabla Categoria...'

/* Migracion de datos tabla Subcategoria */
--43 filas
INSERT INTO LOS_MIGRADORES.Subcategoria (subcategoria_nombre, subcategoria_categoria)
select distinct PRODUCTO_SUB_CATEGORIA, PRODUCTO_CATEGORIA from gd_esquema.Maestra
where PRODUCTO_CATEGORIA is not null and PRODUCTO_CATEGORIA is not null
GO
PRINT 'Migracion completa a tabla Subcategoria...'

/* Migracion de datos tabla Producto */
--3742 filas
--tarda 17 segundos
INSERT INTO LOS_MIGRADORES.Producto (producto_nombre, producto_descripcion, producto_precio, producto_marca, producto_subcategoria)
SELECT distinct m.PRODUCTO_NOMBRE, m.PRODUCTO_DESCRIPCION, m.PRODUCTO_PRECIO, m.PRODUCTO_MARCA, 
(select subcategoria_id from LOS_MIGRADORES.Subcategoria 
where subcategoria_nombre = m.PRODUCTO_SUB_CATEGORIA and subcategoria_categoria = m.PRODUCTO_CATEGORIA)
FROM gd_esquema.Maestra m 
where PRODUCTO_NOMBRE is not null
GO 
PRINT 'Migracion completa a tabla Producto...'

/* Migracion de datos tabla Promocion */
--132 filas
INSERT INTO LOS_MIGRADORES.Promocion(promo_codigo, promo_descripccion, promo_fecha_inicio, promo_fecha_fin)
select distinct PROMO_CODIGO, PROMOCION_DESCRIPCION, PROMOCION_FECHA_FIN, PROMOCION_FECHA_INICIO from gd_esquema.Maestra
where PROMO_CODIGO is not null
GO 
PRINT 'Migracion completa a tabla Promocion...'

/* Migracion de datos tabla Promo_por_Producto */ 
--Devuelve 889, deberia devolver 1305??
/*Explicacion en el documento*/
INSERT INTO LOS_MIGRADORES.Producto_por_Promo(producto_id, promo_codigo)
SELECT DISTINCT p.producto_id, m.PROMO_CODIGO
FROM gd_esquema.Maestra m
JOIN LOS_MIGRADORES.Subcategoria s ON m.PRODUCTO_SUB_CATEGORIA = s.subcategoria_nombre
JOIN LOS_MIGRADORES.Producto p ON p.producto_subcategoria = s.subcategoria_id 
    and p.producto_descripcion = m.PRODUCTO_DESCRIPCION 
    and p.producto_nombre = m.PRODUCTO_NOMBRE 
    and p.producto_precio = m.PRODUCTO_PRECIO 
    and p.producto_marca = m.PRODUCTO_MARCA
WHERE m.PROMO_CODIGO IS NOT NULL
ORDER BY m.PROMO_CODIGO;
GO
PRINT 'Migracion completa a tabla Promo_por_Producto...'




/* Migracion de datos tabla Regla */
--3 filas
INSERT INTO LOS_MIGRADORES.Regla(regla_descripccion, regla_cant_aplica_descuento, regla_cant_aplicable_regla,
regla_descuento_aplicable_prod, regla_aplica_misma_marca, regla_aplica_mismo_prod, regla_cant_max_prod)
select distinct REGLA_DESCRIPCION,
REGLA_CANT_APLICA_DESCUENTO,
REGLA_CANT_APLICABLE_REGLA, 
REGLA_DESCUENTO_APLICABLE_PROD,
REGLA_APLICA_MISMA_MARCA, REGLA_APLICA_MISMO_PROD, 
REGLA_CANT_MAX_PROD
from gd_esquema.Maestra
where REGLA_DESCRIPCION is not null
GO
PRINT 'Migracion completa a tabla Regla...'


/* Migracion de datos tabla Promo_por_Regla */
--132 filas
INSERT INTO LOS_MIGRADORES.Promo_por_Regla (regla_descripccion, promo_codigo)
select distinct REGLA_DESCRIPCION, PROMO_CODIGO from gd_esquema.Maestra
where REGLA_DESCRIPCION is not null and PROMO_CODIGO is not null 
GO
PRINT 'Migracion completa a tabla Promo_por_Regla...'


/* Migracion de datos tabla Cliente */
--6862 filas
INSERT INTO LOS_MIGRADORES.Cliente (cliente_dni, cliente_nombre, cliente_apellido, cliente_fecha_registro, cliente_telefono, cliente_mail, cliente_fecha_nacimiento, cliente_domicilio, cliente_localidad, cliente_provincia)
SELECT distinct CLIENTE_DNI, CLIENTE_NOMBRE, CLIENTE_APELLIDO, CLIENTE_FECHA_REGISTRO, CLIENTE_TELEFONO, CLIENTE_MAIL, CLIENTE_FECHA_NACIMIENTO, CLIENTE_DOMICILIO, CLIENTE_LOCALIDAD, CLIENTE_PROVINCIA 
FROM gd_esquema.Maestra
where CLIENTE_DNI is not null
GO
PRINT 'Migracion completa a tabla Cliente...'


/* Migracion de datos tabla Ticket */
--31 segundos
--70068 filas, deberia devolver 70025?


INSERT INTO LOS_MIGRADORES.Ticket (ticket_numero, ticket_fecha_hora, ticket_tipo_comprobante, ticket_subtotal_productos, ticket_total_descuento_aplicado, ticket_total_descuento_aplicado_mp, ticket_total_ticket, ticket_sucursal, ticket_caja, ticket_empleado, ticket_cliente, ticket_tipo_caja
)
SELECT m.TICKET_NUMERO, m.TICKET_FECHA_HORA, m.TICKET_TIPO_COMPROBANTE, 
m.TICKET_SUBTOTAL_PRODUCTOS , m.TICKET_TOTAL_DESCUENTO_APLICADO, m.TICKET_TOTAL_DESCUENTO_APLICADO_MP,
m.TICKET_TOTAL_TICKET ,m.SUCURSAL_NOMBRE, c.caja_id, max(m.EMPLEADO_DNI), max(m2.CLIENTE_DNI), m.CAJA_TIPO
FROM gd_esquema.Maestra m
JOIN LOS_MIGRADORES.Caja c on c.caja_numero = m.CAJA_NUMERO and c.caja_sucursal = m.SUCURSAL_NOMBRE
JOIN gd_esquema.Maestra m2 on m.TICKET_NUMERO = m2.TICKET_NUMERO and m.TICKET_FECHA_HORA = m2.TICKET_FECHA_HORA 
and m.TICKET_TIPO_COMPROBANTE = m2.TICKET_TIPO_COMPROBANTE and  
m.TICKET_SUBTOTAL_PRODUCTOS = m2.TICKET_SUBTOTAL_PRODUCTOS and m.TICKET_TOTAL_DESCUENTO_APLICADO = m2.TICKET_TOTAL_DESCUENTO_APLICADO and
m.TICKET_TOTAL_DESCUENTO_APLICADO_MP = m2.TICKET_TOTAL_DESCUENTO_APLICADO_MP
   WHERE m.TICKET_NUMERO is not null
   GROUP BY m.TICKET_NUMERO, m.TICKET_FECHA_HORA, m.TICKET_TIPO_COMPROBANTE, 
m.TICKET_SUBTOTAL_PRODUCTOS, m.TICKET_TOTAL_DESCUENTO_APLICADO, m.TICKET_TOTAL_DESCUENTO_APLICADO_MP,
m.TICKET_TOTAL_TICKET, m.SUCURSAL_NOMBRE, c.caja_id, m.CAJA_TIPO
order by TICKET_NUMERO
GO
PRINT 'Migracion completa a tabla Ticket...'

/* Migracion de datos tabla Ticket_Detalle */
--Tarda 4 segundos
--273189 resultados
INSERT INTO LOS_MIGRADORES.Ticket_Detalle (ticket_id, producto_id, ticket_det_cantidad, ticket_det_precio, ticket_det_total, promo_aplicada_descuento)
SELECT 
    (
        SELECT DISTINCT ticket_id 
        FROM LOS_MIGRADORES.Ticket t 
        WHERE m.TICKET_NUMERO = t.ticket_numero 
          AND m.TICKET_FECHA_HORA = t.ticket_fecha_hora 
          AND m.TICKET_TIPO_COMPROBANTE = t.ticket_tipo_comprobante
    ) AS ticket_id,
    (
        SELECT DISTINCT p.producto_id
        FROM LOS_MIGRADORES.Producto p 
        JOIN LOS_MIGRADORES.Subcategoria s ON s.subcategoria_id = p.producto_subcategoria 
        WHERE m.PRODUCTO_NOMBRE = p.producto_nombre 
          AND s.subcategoria_nombre = m.PRODUCTO_SUB_CATEGORIA
          AND m.PRODUCTO_PRECIO = p.producto_precio
    ) AS producto_id,
    SUM(ISNULL(m.TICKET_DET_CANTIDAD, 0)) AS ticket_det_cantidad,
    AVG(ISNULL(m.TICKET_DET_PRECIO, 0.0)) AS ticket_det_precio,
    SUM(ISNULL(m.TICKET_DET_TOTAL, 0.0)) AS ticket_det_total,
    SUM(ISNULL(m.PROMO_APLICADA_DESCUENTO, 0.0)) AS promo_aplicada_descuento
FROM gd_esquema.Maestra m
WHERE m.TICKET_NUMERO IS NOT NULL 
  AND m.PRODUCTO_NOMBRE IS NOT NULL
GROUP BY m.TICKET_NUMERO, m.TICKET_FECHA_HORA, m.TICKET_TIPO_COMPROBANTE, m.PRODUCTO_NOMBRE, m.PRODUCTO_SUB_CATEGORIA, m.PRODUCTO_PRECIO;
PRINT 'Migracion completa a tabla Ticket_Detalle...'



/*Migración de datos a la tabla Promocion_Por_Ticket*/
--268398 filas
--8 segundos
INSERT INTO LOS_MIGRADORES.Promocion_Por_Ticket (ticket_id, 
   producto_id, promo_codigo
)
SELECT
    (
        SELECT DISTINCT ticket_id 
        FROM LOS_MIGRADORES.Ticket t 
        WHERE m.TICKET_NUMERO = t.ticket_numero 
          AND m.TICKET_FECHA_HORA = t.ticket_fecha_hora 
          AND m.TICKET_TIPO_COMPROBANTE = t.ticket_tipo_comprobante
    ) AS ticket_id,
	(
        SELECT DISTINCT producto_id 
        FROM LOS_MIGRADORES.Producto p 
        JOIN LOS_MIGRADORES.Subcategoria s ON s.subcategoria_id = p.producto_subcategoria 
        WHERE m.PRODUCTO_NOMBRE = p.producto_nombre 
          AND s.subcategoria_nombre = m.PRODUCTO_SUB_CATEGORIA
		  AND p.producto_precio = m.PRODUCTO_PRECIO
    ) AS producto_id, m.promo_codigo
FROM gd_esquema.Maestra m

WHERE m.ticket_numero IS NOT NULL
    AND m.PRODUCTO_NOMBRE IS NOT NULL
    AND m.promo_codigo IS NOT NULL
GROUP BY m.TICKET_NUMERO, m.TICKET_FECHA_HORA, m.TICKET_TIPO_COMPROBANTE, m.PRODUCTO_NOMBRE,
m.PRODUCTO_SUB_CATEGORIA, m.PRODUCTO_PRECIO, m.promo_codigo
GO
PRINT 'Migracion completa a tabla Promocion_Por_Ticket...'

/* Migracion de datos tabla Medio de pago */
--7 filas
 INSERT INTO LOS_MIGRADORES.Medio_de_Pago(medio_pago_nombre, medio_pago_tipo)
    SELECT DISTINCT m.PAGO_MEDIO_PAGO, m.PAGO_TIPO_MEDIO_PAGO
    FROM gd_esquema.Maestra m
    WHERE m.PAGO_MEDIO_PAGO IS NOT NULL AND m.PAGO_TIPO_MEDIO_PAGO IS NOT NULL;
GO
PRINT 'Migracion completa a tabla Medio_de_Pago...'

/* Migracion de datos tabla Descuento */
--308 filas
    INSERT INTO LOS_MIGRADORES.Descuento_MP (descuento_codigo, descuento_descripcion, descuento_fecha_inicio, 
	descuento_fecha_fin, descuento_porcentaje_desc, descuento_tope, pago_medio_pago_id
    )
    SELECT DISTINCT m.DESCUENTO_CODIGO, m.DESCUENTO_DESCRIPCION, m.DESCUENTO_FECHA_INICIO,
	m.DESCUENTO_FECHA_FIN, m.DESCUENTO_PORCENTAJE_DESC, m.DESCUENTO_TOPE, m.PAGO_MEDIO_PAGO
    FROM gd_esquema.Maestra m
    WHERE m.DESCUENTO_CODIGO IS NOT NULL;
GO
PRINT 'Migracion completa a tabla Descuento...'


/* Migracion de datos tabla Pago_detalle */
--14553 filas
INSERT INTO LOS_MIGRADORES.Detalle_Pago (detallepago_tarjeta_numero, detallepago_tarjeta_fecha_vencimiento, detallepago_tarjeta_cuotas)
SELECT DISTINCT PAGO_TARJETA_NRO, PAGO_TARJETA_FECHA_VENC, PAGO_TARJETA_CUOTAS
FROM gd_esquema.Maestra m
WHERE PAGO_TARJETA_NRO IS NOT NULL;
GO
PRINT 'Migracion completa a tabla Pago_detalle...'

/* Migracion de datos tabla Pago */
--17068 filas
INSERT INTO LOS_MIGRADORES.Pago (pago_fecha, pago_importe, pago_descuento_aplicado, pago_ticket_id, pago_medio_pago, pago_detalle_pago)
SELECT DISTINCT m.PAGO_FECHA, m.PAGO_IMPORTE, m.PAGO_DESCUENTO_APLICADO, (
        SELECT DISTINCT ticket_id 
        FROM LOS_MIGRADORES.Ticket t 
        WHERE m.TICKET_NUMERO = t.ticket_numero 
          AND m.TICKET_FECHA_HORA = t.ticket_fecha_hora 
          AND m.TICKET_TIPO_COMPROBANTE = t.ticket_tipo_comprobante
    ) as ticket_id, PAGO_MEDIO_PAGO, (
        SELECT DISTINCT detallepago_id 
        FROM LOS_MIGRADORES.Detalle_Pago dp
        WHERE m.PAGO_TARJETA_NRO = dp.detallepago_tarjeta_numero 
          AND m.PAGO_TARJETA_FECHA_VENC = dp.detallepago_tarjeta_fecha_vencimiento 
          AND m.PAGO_TARJETA_CUOTAS = dp.detallepago_tarjeta_cuotas
    ) as detallepago_id
FROM gd_esquema.Maestra m
WHERE pago_fecha IS NOT NULL;
GO
PRINT 'Migracion completa a tabla Pago...'

/* Migracion de datos tabla Pago_por_descuento */
--17068 filas
    INSERT INTO LOS_MIGRADORES.Pago_Por_Descuento (
        pago_id, descuento_id
    )
    SELECT DISTINCT (select pago_id from LOS_MIGRADORES.Pago p JOIN LOS_MIGRADORES.Ticket t on t.ticket_id = p.pago_ticket_id 
	where p.pago_fecha = m.PAGO_FECHA and t.ticket_numero = m.TICKET_NUMERO  and pago_id is not null) as pago_id, 
	m.DESCUENTO_CODIGO
    FROM gd_esquema.Maestra m
    WHERE m.PAGO_FECHA IS NOT NULL AND m.DESCUENTO_CODIGO IS NOT NULL AND m.PAGO_MEDIO_PAGO <> 'Efectivo';
GO
PRINT 'Migracion completa a tabla Pago_por_descuento...'


/* Migracion de datos tabla Envio */

INSERT INTO LOS_MIGRADORES.Envio (envio_costo, envio_fecha_programada, envio_hora_inicio, envio_hora_fin, envio_fecha_entrega, envio_estado, ticket_id)
--6862 filas
SELECT DISTINCT
    m.envio_costo, m.envio_fecha_programada, m.envio_hora_inicio, 
    m.envio_hora_fin, m.envio_fecha_entrega, m.envio_estado, 
	(SELECT DISTINCT ticket_id 
        FROM LOS_MIGRADORES.Ticket t 
        WHERE m.TICKET_NUMERO = t.ticket_numero 
          AND m.TICKET_FECHA_HORA = t.ticket_fecha_hora 
          AND m.TICKET_TIPO_COMPROBANTE = t.ticket_tipo_comprobante
    ) as ticket_id
FROM gd_esquema.Maestra m
WHERE m.ticket_numero IS NOT NULL
AND ENVIO_COSTO IS NOT NULL
GO
PRINT 'Migracion completa a tabla Envio...'

PRINT 'Migracion finalizada...'