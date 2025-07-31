USE GD1C2024;
GO

/*-------------------ELIMINAR FUNCIONES SI EXISTEN-------------------*/

IF OBJECT_ID('devolverCuatri', 'FN') IS NOT NULL
    DROP FUNCTION devolverCuatri;
GO

IF OBJECT_ID('devolverRangoEtareo', 'FN') IS NOT NULL
    DROP FUNCTION devolverRangoEtareo;
GO

IF OBJECT_ID('devolverTurno', 'FN') IS NOT NULL
    DROP FUNCTION devolverTurno;
GO

IF OBJECT_ID('entregaATiempo', 'FN') IS NOT NULL
    DROP FUNCTION entregaATiempo;
GO
IF OBJECT_ID('devolverTiempoDeFecha', 'FN') IS NOT NULL
    DROP FUNCTION devolverTiempoDeFecha;
GO
IF OBJECT_ID('devolverImporteDeCuotas', 'FN') IS NOT NULL
    DROP FUNCTION devolverImporteDeCuotas;
GO

/*-------------------ELIMINAR PROCEDIMIENTOS SI EXISTEN-------------------*/


IF OBJECT_ID('MigrarTiemposSinRepetir', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE MigrarTiemposSinRepetir;
END
GO


/*-------------------ELIMINAR VISTAS SI EXISTEN-------------------*/

IF OBJECT_ID('LOS_MIGRADORES.Vista_TicketPromedioMensual', 'V') IS NOT NULL
    DROP VIEW LOS_MIGRADORES.Vista_TicketPromedioMensual;
GO

IF OBJECT_ID('LOS_MIGRADORES.Vista_CantidadUnidadesPromedio', 'V') IS NOT NULL
    DROP VIEW LOS_MIGRADORES.Vista_CantidadUnidadesPromedio;
GO

IF OBJECT_ID('LOS_MIGRADORES.PorcentajeAnualDeVentas', 'V') IS NOT NULL
    DROP VIEW LOS_MIGRADORES.PorcentajeAnualDeVentas;
GO

IF OBJECT_ID('LOS_MIGRADORES.CantidadVentasRegistradasPorTurno', 'V') IS NOT NULL
    DROP VIEW LOS_MIGRADORES.CantidadVentasRegistradasPorTurno;
GO

IF OBJECT_ID('dbo.v_PorcentajeDescuentoAplicadoEnFuncionDelTotal', 'V') IS NOT NULL
    DROP VIEW dbo.v_PorcentajeDescuentoAplicadoEnFuncionDelTotal;
GO

IF OBJECT_ID('dbo.v_tres_categorias_productos_mayor_descuentos_aplicado', 'V') IS NOT NULL
    DROP VIEW dbo.v_tres_categorias_productos_mayor_descuentos_aplicado;
GO

IF OBJECT_ID('dbo.v_cumplimiento_envios', 'V') IS NOT NULL
    DROP VIEW dbo.v_cumplimiento_envios;
GO

IF OBJECT_ID('dbo.v_cantidad_envios_por_rango_etario_cuatrimestre', 'V') IS NOT NULL
    DROP VIEW dbo.v_cantidad_envios_por_rango_etario_cuatrimestre;
GO

IF OBJECT_ID('dbo.v_5LocalidadesMayorCosto', 'V') IS NOT NULL
    DROP VIEW dbo.v_5LocalidadesMayorCosto;
GO

IF OBJECT_ID('dbo.v_tres_sucursales_mayor_importe_en_cuotas', 'V') IS NOT NULL
    DROP VIEW dbo.v_tres_sucursales_mayor_importe_en_cuotas;
GO

IF OBJECT_ID('dbo.v_promedio_importe_rango_etareo', 'V') IS NOT NULL
    DROP VIEW dbo.v_promedio_importe_rango_etareo;
GO

IF OBJECT_ID('dbo.v_porcentaje_desc_aplicado', 'V') IS NOT NULL
    DROP VIEW dbo.v_porcentaje_desc_aplicado;
GO

IF OBJECT_ID('dbo.v_porcentaje_anual_ventas', 'V') IS NOT NULL
    DROP VIEW dbo.v_porcentaje_anual_ventas;
GO

IF OBJECT_ID('dbo.v_porcentaje_cumplimiento_envios', 'V') IS NOT NULL
    DROP VIEW dbo.v_porcentaje_cumplimiento_envios;
GO


/*-------------------ELIMINAR RESTRICCIONES DE CLAVES FORÁNEAS---------------------*/

-- Eliminar claves foráneas en BI_Venta si existen
IF OBJECT_ID('LOS_MIGRADORES.BI_Venta', 'U') IS NOT NULL
BEGIN
    ALTER TABLE LOS_MIGRADORES.BI_Venta DROP CONSTRAINT IF EXISTS FK_Venta_Empleado;
    ALTER TABLE LOS_MIGRADORES.BI_Venta DROP CONSTRAINT IF EXISTS FK_Venta_Tiempo;
    ALTER TABLE LOS_MIGRADORES.BI_Venta DROP CONSTRAINT IF EXISTS FK_Venta_Sucursal;
    ALTER TABLE LOS_MIGRADORES.BI_Venta DROP CONSTRAINT IF EXISTS FK_Venta_TipoCaja;
    ALTER TABLE LOS_MIGRADORES.BI_Venta DROP CONSTRAINT IF EXISTS FK_Venta_Producto;
END;

-- Eliminar claves foráneas en BI_Pago si existen
IF OBJECT_ID('LOS_MIGRADORES.BI_Pago', 'U') IS NOT NULL
BEGIN
    ALTER TABLE LOS_MIGRADORES.BI_Pago DROP CONSTRAINT IF EXISTS FK_Pago_MedioDePago;
    ALTER TABLE LOS_MIGRADORES.BI_Pago DROP CONSTRAINT IF EXISTS FK_Pago_Cliente;
    ALTER TABLE LOS_MIGRADORES.BI_Pago DROP CONSTRAINT IF EXISTS FK_Pago_Descuento;
END;

-- Eliminar claves foráneas en BI_Envio si existen
IF OBJECT_ID('LOS_MIGRADORES.BI_Envio', 'U') IS NOT NULL
BEGIN
    ALTER TABLE LOS_MIGRADORES.BI_Envio DROP CONSTRAINT IF EXISTS FK_Envio_FechaProgramada;
    ALTER TABLE LOS_MIGRADORES.BI_Envio DROP CONSTRAINT IF EXISTS FK_Envio_FechaEntrega;
    ALTER TABLE LOS_MIGRADORES.BI_Envio DROP CONSTRAINT IF EXISTS FK_Envio_Cliente;
END;

/*-------------------ELIMINAR TABLAS SI EXISTEN---------------------*/

IF OBJECT_ID('LOS_MIGRADORES.BI_Venta', 'U') IS NOT NULL
    DROP TABLE LOS_MIGRADORES.BI_Venta;
GO

IF OBJECT_ID('LOS_MIGRADORES.BI_Pago', 'U') IS NOT NULL
    DROP TABLE LOS_MIGRADORES.BI_Pago;
GO

IF OBJECT_ID('LOS_MIGRADORES.BI_Envio', 'U') IS NOT NULL
    DROP TABLE LOS_MIGRADORES.BI_Envio;
GO

IF OBJECT_ID('LOS_MIGRADORES.BI_Promocion', 'U') IS NOT NULL
    DROP TABLE LOS_MIGRADORES.BI_Promocion;
GO

IF OBJECT_ID('LOS_MIGRADORES.BI_Empleado', 'U') IS NOT NULL
    DROP TABLE LOS_MIGRADORES.BI_Empleado;
GO

IF OBJECT_ID('LOS_MIGRADORES.BI_Tipo_Caja', 'U') IS NOT NULL
    DROP TABLE LOS_MIGRADORES.BI_Tipo_Caja;
GO

IF OBJECT_ID('LOS_MIGRADORES.BI_Sucursal', 'U') IS NOT NULL
    DROP TABLE LOS_MIGRADORES.BI_Sucursal;
GO

IF OBJECT_ID('LOS_MIGRADORES.BI_Producto', 'U') IS NOT NULL
    DROP TABLE LOS_MIGRADORES.BI_Producto;
GO

IF OBJECT_ID('LOS_MIGRADORES.BI_Cliente', 'U') IS NOT NULL
    DROP TABLE LOS_MIGRADORES.BI_Cliente;
GO

IF OBJECT_ID('LOS_MIGRADORES.BI_Tiempo', 'U') IS NOT NULL
    DROP TABLE LOS_MIGRADORES.BI_Tiempo;
GO

IF OBJECT_ID('LOS_MIGRADORES.BI_Turno', 'U') IS NOT NULL
    DROP TABLE LOS_MIGRADORES.BI_Turno;
GO

IF OBJECT_ID('LOS_MIGRADORES.BI_Medio_de_Pago', 'U') IS NOT NULL
    DROP TABLE LOS_MIGRADORES.BI_Medio_de_Pago;
GO

IF OBJECT_ID('LOS_MIGRADORES.BI_Promocion_Cargada', 'U') IS NOT NULL
    DROP TABLE LOS_MIGRADORES.BI_Promocion_Cargada;
GO



/*-------------------FUNCIONES AUXILIARES---------------------------*/

CREATE FUNCTION devolverCuatri(@FECHA DATETIME)
RETURNS INT
AS
BEGIN
    DECLARE @ANIO INT, @CUATRI INT;
    SET @ANIO = MONTH(@FECHA);

    IF(@ANIO >= 1 AND @ANIO <= 4)
    BEGIN
        SET @CUATRI = 1;
    END

    IF(@ANIO >= 5 AND @ANIO <= 8)
    BEGIN
        SET @CUATRI = 2;
    END

    IF(@ANIO >= 9 AND @ANIO <= 12)
    BEGIN
        SET @CUATRI = 3;
    END

    RETURN @CUATRI;
END;
GO

CREATE FUNCTION devolverRangoEtareo(@FECHA_NACIMIENTO DATETIME)
RETURNS CHAR(8)
AS
BEGIN
    DECLARE @FECHA_ACTUAL DATETIME, @DIFF INT, @RANGO CHAR(8);
    SET @FECHA_ACTUAL = GETDATE();

    SET @DIFF = DATEDIFF(YEAR, @FECHA_NACIMIENTO, @FECHA_ACTUAL);

    IF(@DIFF < 25)
    BEGIN
        SET @RANGO = '<25';
    END

    IF(@DIFF >= 25 AND @DIFF <= 35)
    BEGIN
        SET @RANGO = '25-35';
    END

    IF(@DIFF >= 35 AND @DIFF <= 50)
    BEGIN
        SET @RANGO = '35-50';
    END

    IF(@DIFF > 50)
    BEGIN
        SET @RANGO = '>50';
    END

	ELSE
	BEGIN
	   SET @RANGO = 'Desconocido'
	END

    RETURN @RANGO;
END;
GO

CREATE FUNCTION devolverTurno(@FECHA DATETIME)
RETURNS CHAR(12)
AS
BEGIN
    DECLARE @HORA INT, @TURNO CHAR(12);
    SET @HORA = DATEPART(HOUR, @FECHA);

    IF(@HORA >= 8 AND @HORA < 12)
    BEGIN
        SET @TURNO = '08:00-12:00';
    END

    IF(@HORA >= 12 AND @HORA < 16)
    BEGIN
        SET @TURNO = '12:00-16:00';
    END

    IF(@HORA >= 16 AND @HORA < 20)
    BEGIN
        SET @TURNO = '16:00-20:00';
    END

	IF(@HORA < 8 OR @HORA >= 20)
	BEGIN
	    SET @TURNO = 'Otro Horario';
	END

    RETURN @TURNO;
END;
GO

CREATE FUNCTION entregaATiempo(@FECHA_PROGRAMADA DATETIME, @FECHA_ENTREGA DATETIME)
RETURNS BIT
BEGIN
    DECLARE @BIT BIT
    IF( @FECHA_ENTREGA >= @FECHA_PROGRAMADA)
	BEGIN
	    SET @BIT = 1
	END
	ELSE
	BEGIN
	    SET @BIT = 0
	END
	RETURN @BIT
END
GO

CREATE FUNCTION devolverImporteDeCuotas (
    @IMPORTE DECIMAL(18, 2),
    @CUOTAS INT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @RESULT DECIMAL(18, 2);

    IF @CUOTAS IS NULL
    BEGIN
        SET @RESULT = 0;
    END
    ELSE
    BEGIN
        SET @RESULT = @IMPORTE;
    END

    RETURN @RESULT;
END
GO


/*---------------TABLAS DIMENSIONES---------------------------*/

CREATE TABLE LOS_MIGRADORES.BI_Empleado (
    empleado_dni INT PRIMARY KEY,
    empleado_nombre NVARCHAR(255) NOT NULL,
    empleado_apellido NVARCHAR(255) NOT NULL,
    empleado_fecha_registro DATETIME NOT NULL,
    empleado_telefono INT NOT NULL,
    empleado_mail NVARCHAR(255) NOT NULL,
    empleado_fecha_nacimiento DATETIME NOT NULL,
    empleado_sucursal NVARCHAR(255),
    empleado_rango_etareo CHAR(8)  /* USAR FUNCION devolverRangoEtareo */
);
GO

CREATE TABLE LOS_MIGRADORES.BI_Tipo_Caja (
    tipocaja_nombre NVARCHAR(255) PRIMARY KEY
);
GO


CREATE TABLE LOS_MIGRADORES.BI_Sucursal (
    sucursal_nombre NVARCHAR(255) PRIMARY KEY,
    sucursal_direccion NVARCHAR(255) NOT NULL,
    sucursal_localidad NVARCHAR(255) NOT NULL,
    sucursal_provincia NVARCHAR(255) NOT NULL,
    sucursal_super NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_MIGRADORES.BI_Producto (
    producto_id INT IDENTITY(1,1) PRIMARY KEY,
    producto_nombre NVARCHAR(255) NOT NULL,
    producto_descripcion NVARCHAR(255) NOT NULL,
    producto_precio DECIMAL(12,2) NOT NULL,
    producto_marca NVARCHAR(255) NOT NULL,
    producto_subcategoria NVARCHAR(255) NOT NULL,
	producto_categoria NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE LOS_MIGRADORES.BI_Cliente (
    cliente_dni INT PRIMARY KEY,
    cliente_nombre NVARCHAR(255) NOT NULL,
    cliente_apellido NVARCHAR(255) NOT NULL,
    cliente_fecha_registro DATETIME NOT NULL,
    cliente_telefono INT NOT NULL,
    cliente_mail NVARCHAR(255) NOT NULL,
    cliente_fecha_nacimiento DATETIME NOT NULL,
    cliente_domicilio NVARCHAR(255) NOT NULL,
    cliente_localidad NVARCHAR(255) NOT NULL,
    cliente_provincia NVARCHAR(255) NOT NULL,
    cliente_rango_etareo CHAR(8) /* USAR FUNCION devolverRangoEtareo */
);
GO

CREATE TABLE LOS_MIGRADORES.BI_Tiempo (
	tiempo_id INT IDENTITY PRiMARY KEY,
    tiempo_anio INT NOT NULL,
    tiempo_mes INT NOT NULL,
    tiempo_cuatri INT NOT NULL /* USAR FUNCION devolverCuatri */
);
GO
/*
CREATE TABLE LOS_MIGRADORES.BI_Turno (
    turno_fecha_hora DATETIME PRIMARY KEY,
    turno_clasificacion CHAR(12) /* USAR FUNCION devolverTurno */
);
GO*/

CREATE TABLE LOS_MIGRADORES.BI_Medio_de_Pago (
    medio_pago_nombre NVARCHAR(255) PRIMARY KEY NOT NULL,
    medio_pago_tipo NVARCHAR(255) NOT NULL
);
GO


CREATE TABLE LOS_MIGRADORES.BI_Promocion_Cargada (
    promo_codigo INT PRIMARY KEY,
    promo_descripccion NVARCHAR(255) NOT NULL,
    promo_fecha_inicio DATETIME NOT NULL,
    promo_fecha_fin DATETIME NOT NULL
); 
GO

/***********************************************************/
CREATE TABLE LOS_MIGRADORES.BI_Pago (
    medio_de_pago_id NVARCHAR(255) NOT NULL,
	sucursal_id NVARCHAR(255),
	tiempo_id INT,
	cliente_rango_etareo CHAR(8),
	importe_pago_en_cuotas DECIMAL(12,2),
	importe_pago_total DECIMAL(12,2),
	descuento_total DECIMAL(12,2)
    PRIMARY KEY (tiempo_id, medio_de_pago_id, sucursal_id, cliente_rango_etareo)
);
GO
ALTER TABLE LOS_MIGRADORES.BI_Pago
ADD CONSTRAINT FK_Pago_MedioDePago FOREIGN KEY (medio_de_pago_id)
REFERENCES LOS_MIGRADORES.BI_Medio_de_Pago(medio_pago_nombre);

ALTER TABLE LOS_MIGRADORES.BI_Pago
ADD CONSTRAINT FK_Pago_Tiempo FOREIGN KEY (tiempo_id)
REFERENCES LOS_MIGRADORES.BI_Tiempo(tiempo_id);

ALTER TABLE LOS_MIGRADORES.BI_Pago
ADD CONSTRAINT FK_Pago_Sucursal FOREIGN KEY (sucursal_id)
REFERENCES LOS_MIGRADORES.BI_Sucursal(sucursal_nombre);


/**************************TABLAS HECHOS*********************************/

/**************************  VENTA  *********************************/

CREATE TABLE LOS_MIGRADORES.BI_Venta(
    empleado_id INT,
    tiempo_id INT,
    producto_id INT,
    sucursal_id NVARCHAR(255),
    turno_id char(12),
    tipo_de_caja_id NVARCHAR(255),
    importe_total_ventas DECIMAL(12,0),
    cantidad_articulos INT,
	cantidad_ventas INT,
    PRIMARY KEY (empleado_id, tiempo_id, producto_id, sucursal_id, turno_id, tipo_de_caja_id)
);
GO

ALTER TABLE LOS_MIGRADORES.BI_Venta
ADD CONSTRAINT FK_Venta_Empleado FOREIGN KEY (empleado_id)
REFERENCES LOS_MIGRADORES.BI_Empleado(empleado_dni);
GO

ALTER TABLE LOS_MIGRADORES.BI_Venta
ADD CONSTRAINT FK_Venta_Tiempo FOREIGN KEY (tiempo_id)
REFERENCES LOS_MIGRADORES.BI_Tiempo(tiempo_id);
GO

ALTER TABLE LOS_MIGRADORES.BI_Venta
ADD CONSTRAINT FK_Venta_Sucursal FOREIGN KEY (sucursal_id)
REFERENCES LOS_MIGRADORES.BI_Sucursal(sucursal_nombre);
GO

ALTER TABLE LOS_MIGRADORES.BI_Venta
ADD CONSTRAINT FK_Venta_TipoCaja FOREIGN KEY (tipo_de_caja_id)
REFERENCES LOS_MIGRADORES.BI_Tipo_Caja(tipocaja_nombre);
GO

ALTER TABLE LOS_MIGRADORES.BI_Venta
ADD CONSTRAINT FK_Venta_Producto FOREIGN KEY (producto_id)
REFERENCES LOS_MIGRADORES.BI_Producto(producto_id);
GO


/**************************   ENVIO    *********************************/


CREATE TABLE LOS_MIGRADORES.BI_Envio(
	envio_fecha_entrega INT,
	envio_fecha_programada INT,
	envio_cliente INT,
	sucursal_id NVARCHAR(255),
    envio_costo DECIMAL(18,2),
	cantidad_envios_cumplidos INT,
	cantidad_envios INT,
    PRIMARY KEY (envio_fecha_entrega, envio_fecha_programada, envio_cliente, sucursal_id)
);
GO

ALTER TABLE LOS_MIGRADORES.BI_Envio
ADD CONSTRAINT FK_Envio_FechaProgramada FOREIGN KEY (envio_fecha_programada)
REFERENCES LOS_MIGRADORES.BI_Tiempo(tiempo_id);
GO

ALTER TABLE LOS_MIGRADORES.BI_Envio
ADD CONSTRAINT FK_Envio_FechaEntrega FOREIGN KEY (envio_fecha_entrega)
REFERENCES LOS_MIGRADORES.BI_Tiempo(tiempo_id);
GO

ALTER TABLE LOS_MIGRADORES.BI_Envio
ADD CONSTRAINT FK_Envio_Cliente FOREIGN KEY (envio_cliente)
REFERENCES LOS_MIGRADORES.BI_Cliente(cliente_dni);
GO

ALTER TABLE LOS_MIGRADORES.BI_Envio
ADD CONSTRAINT FK_Envio_Sucursal FOREIGN KEY (sucursal_id)
REFERENCES LOS_MIGRADORES.BI_Sucursal(sucursal_nombre);
GO



/***************************  PROMOCION ********************************/

CREATE TABLE LOS_MIGRADORES.BI_Promocion (
    producto_id INT,
    tiempo_id INT,
    descuento_total_aplicado_por_promocion DECIMAL(18,2),
    venta_total_tickets DECIMAL(18,2),
	cantidad_tickets INT,
	porcentaje_descuento_respecto_total_tickets DECIMAL(18,2)
    PRIMARY KEY (/*promo_codigo,*/ producto_id, tiempo_id),
    FOREIGN KEY (producto_id) REFERENCES LOS_MIGRADORES.BI_Producto(producto_id),
    FOREIGN KEY (tiempo_id) REFERENCES LOS_MIGRADORES.BI_Tiempo(tiempo_id)
);
GO

/**************** PROCEDURES *********************/

CREATE PROCEDURE MigrarTiemposSinRepetir
AS
BEGIN
    CREATE TABLE #TempTiempo (
        tiempo_anio INT,
        tiempo_mes INT,
        tiempo_cuatri INT
    );

    INSERT INTO #TempTiempo (tiempo_anio, tiempo_mes, tiempo_cuatri)
    SELECT DISTINCT YEAR(tk.ticket_fecha_hora), MONTH(tk.ticket_fecha_hora), dbo.devolverCuatri(tk.ticket_fecha_hora)
    FROM LOS_MIGRADORES.Ticket tk
    WHERE tk.ticket_fecha_hora IS NOT NULL
    UNION
    SELECT DISTINCT YEAR(pago.pago_fecha), MONTH(pago.pago_fecha), dbo.devolverCuatri(pago.pago_fecha)
    FROM LOS_MIGRADORES.Pago pago
    WHERE pago.pago_fecha IS NOT NULL
    UNION
    SELECT DISTINCT YEAR(envio.envio_fecha_programada), MONTH(envio.envio_fecha_programada), dbo.devolverCuatri(envio.envio_fecha_programada)
    FROM LOS_MIGRADORES.Envio envio
    WHERE envio.envio_fecha_programada IS NOT NULL
    UNION
    SELECT DISTINCT YEAR(en.envio_fecha_entrega), MONTH(en.envio_fecha_entrega), dbo.devolverCuatri(en.envio_fecha_entrega)
    FROM LOS_MIGRADORES.Envio en
    WHERE en.envio_fecha_entrega IS NOT NULL;

    INSERT INTO LOS_MIGRADORES.BI_Tiempo (tiempo_anio, tiempo_mes, tiempo_cuatri)
    SELECT DISTINCT tiempo_anio, tiempo_mes, tiempo_cuatri
    FROM #TempTiempo tmp
    WHERE NOT EXISTS (
        SELECT 1 
        FROM LOS_MIGRADORES.BI_Tiempo bt 
        WHERE bt.tiempo_anio = tmp.tiempo_anio 
        AND bt.tiempo_mes = tmp.tiempo_mes 
        AND bt.tiempo_cuatri = tmp.tiempo_cuatri
    );

    
    DROP TABLE #TempTiempo;
END
GO

CREATE FUNCTION devolverTiempoDeFecha (@fecha SMALLDATETIME)
RETURNS INT
AS
BEGIN
    DECLARE @anio INT;
    DECLARE @mes INT;
    DECLARE @cuatri INT;
    DECLARE @tiempo_id INT;

    SET @anio = YEAR(@fecha);
    SET @mes = MONTH(@fecha);
    SET @cuatri = dbo.devolverCuatri(@fecha); 

    
    SELECT @tiempo_id = tiempo_id
    FROM LOS_MIGRADORES.BI_Tiempo
    WHERE tiempo_anio = @anio
      AND tiempo_mes = @mes
      AND tiempo_cuatri = @cuatri;

    RETURN @tiempo_id;
END
GO



/*---------------------------MIGRACION DIMENSIONES---------------------------*/


INSERT INTO LOS_MIGRADORES.BI_Tipo_Caja (tipocaja_nombre)
SELECT distinct tc.tipocaja_nombre
FROM LOS_MIGRADORES.Tipo_Caja tc
where tc.tipocaja_nombre is not null
GO
PRINT 'Migracion completa a tabla BI_Tipo_Caja...'

INSERT INTO LOS_MIGRADORES.BI_Producto(producto_nombre, producto_descripcion, producto_precio, producto_marca, producto_subcategoria, producto_categoria)
SELECT distinct p.producto_nombre, p.producto_descripcion, p.producto_precio, p.producto_marca,
s.subcategoria_nombre, c.categoria_nombre
FROM LOS_MIGRADORES.Producto p
JOIN LOS_MIGRADORES.Subcategoria s on s.subcategoria_id = p.producto_subcategoria
JOIN LOS_MIGRADORES.Categoria c on c.categoria_nombre = s.subcategoria_categoria
where p.producto_nombre is not null
GO
PRINT 'Migracion completa a tabla BI_Producto...'

INSERT INTO LOS_MIGRADORES.BI_Sucursal(sucursal_nombre, sucursal_direccion, sucursal_localidad, sucursal_provincia, sucursal_super)
SELECT distinct s.sucursal_nombre, s.sucursal_direccion, s.sucursal_localidad, s.sucursal_provincia, s.sucursal_super
FROM LOS_MIGRADORES.Sucursal s
where s.sucursal_nombre is not null
GO
PRINT 'Migracion completa a tabla BI_Sucursal...'

INSERT INTO LOS_MIGRADORES.BI_Cliente(cliente_dni, cliente_nombre, cliente_apellido, cliente_fecha_registro, cliente_telefono, cliente_mail, cliente_fecha_nacimiento, cliente_domicilio, cliente_localidad, cliente_provincia, cliente_rango_etareo)
SELECT distinct cl.cliente_dni, cl.cliente_nombre, cl.cliente_apellido, cl.cliente_fecha_registro, cl.cliente_telefono, cl.cliente_mail, cl.cliente_fecha_nacimiento, cl.cliente_domicilio, cl.cliente_localidad, cl.cliente_provincia, dbo.devolverRangoEtareo(cliente_fecha_nacimiento)
FROM LOS_MIGRADORES.Cliente cl
where cl.cliente_dni is not null
GO

PRINT 'Migracion completa a tabla BI_Cliente...'

INSERT INTO LOS_MIGRADORES.BI_Medio_de_Pago(medio_pago_nombre, medio_pago_tipo)
SELECT distinct mp.medio_pago_nombre, mp.medio_pago_tipo
FROM LOS_MIGRADORES.Medio_de_Pago mp
where mp.medio_pago_nombre is not null and mp.medio_pago_tipo is not null
GO
PRINT 'Migracion completa a tabla BI_Medio_de_Pago...'

INSERT INTO LOS_MIGRADORES.BI_Empleado(empleado_dni, empleado_nombre, empleado_apellido, empleado_fecha_registro, empleado_telefono, empleado_mail, empleado_fecha_nacimiento, empleado_sucursal, empleado_rango_etareo)
SELECT distinct e.empleado_dni, e.empleado_nombre, e.empleado_apellido, e.empleado_fecha_registro, e.empleado_telefono, e.empleado_mail, e.empleado_fecha_nacimiento, e.empleado_sucursal, dbo.devolverRangoEtareo(e.empleado_fecha_nacimiento)
FROM LOS_MIGRADORES.Empleado e
where e.empleado_dni is not null 
GO
PRINT 'Migracion completa a tabla BI_Empleado...'



EXEC MigrarTiemposSinRepetir;
PRINT 'Migración completa a tabla BI_Tiempo...'
GO


INSERT INTO LOS_MIGRADORES.BI_Promocion_Cargada(promo_codigo, promo_descripccion,promo_fecha_inicio, promo_fecha_fin)
SELECT distinct p.promo_codigo, p.promo_descripccion, p.promo_fecha_inicio, p.promo_fecha_fin
FROM LOS_MIGRADORES.Promocion p
GO
PRINT 'Migracion completa a tabla BI_Promocion_Cargada...'


/***************************** MIGRACION HECHOS ******************************/

INSERT INTO LOS_MIGRADORES.BI_Venta (
    empleado_id, tiempo_id, producto_id, sucursal_id, turno_id, tipo_de_caja_id, 
	importe_total_ventas, cantidad_articulos, cantidad_ventas
	)
SELECT
    t.ticket_empleado AS empleado_id, dbo.devolverTiempoDeFecha(t.ticket_fecha_hora) AS tiempo_id,
	td.producto_id,
    t.ticket_sucursal AS sucursal_id, 
	dbo.devolverTurno(t.ticket_fecha_hora) AS turno_id,  
    t.ticket_tipo_caja AS tipo_de_caja_id,
	SUM(t.ticket_total_ticket),
	SUM(td.ticket_det_cantidad),
	COUNT(distinct t.ticket_id)
FROM
    LOS_MIGRADORES.Ticket t
	LEFT JOIN LOS_MIGRADORES.Ticket_Detalle td on td.ticket_id = t.ticket_id
	LEFT JOIN LOS_MIGRADORES.Promocion_Por_Ticket ppt on ppt.ticket_id = td.ticket_id and ppt.producto_id = td.producto_id
	--where t.ticket_empleado <> 4973945 --and td.producto_id = 2716
	GROUP BY 
	t.ticket_empleado, dbo.devolverTiempoDeFecha(t.ticket_fecha_hora),
	td.producto_id,
    t.ticket_sucursal , 
	dbo.devolverTurno(t.ticket_fecha_hora) ,  
    t.ticket_tipo_caja 
GO
PRINT 'Migracion completa a tabla BI_Venta...'

/***********************************************************/

INSERT INTO LOS_MIGRADORES.BI_Envio
(   envio_fecha_entrega ,
	envio_fecha_programada ,
	envio_cliente ,
	sucursal_id ,
    envio_costo ,
	cantidad_envios_cumplidos ,
	cantidad_envios
)
SELECT 
    dbo.devolverTiempoDeFecha(e.envio_fecha_entrega),
    dbo.devolverTiempoDeFecha( e.envio_fecha_programada), 
	t.ticket_cliente,
	 t.ticket_sucursal, SUM(e.envio_costo),
	 COUNT(CASE WHEN dbo.entregaATiempo(e.envio_fecha_programada, e.envio_fecha_entrega) = 1 THEN 1 END),
	 COUNT(distinct e.envio_id)
FROM
    LOS_MIGRADORES.Envio e
    INNER JOIN LOS_MIGRADORES.Ticket t ON e.ticket_id = t.ticket_id
	GROUP BY 
	dbo.devolverTiempoDeFecha(e.envio_fecha_entrega),
    dbo.devolverTiempoDeFecha( e.envio_fecha_programada), 
	t.ticket_cliente,
	t.ticket_sucursal
GO
PRINT 'Migracion completa a tabla BI_Envio...'


	/***********************************************************/

INSERT INTO LOS_MIGRADORES.BI_Promocion (
    producto_id ,
    tiempo_id ,
    descuento_total_aplicado_por_promocion,
    venta_total_tickets,
	cantidad_tickets,
	porcentaje_descuento_respecto_total_tickets
)
select 
    td.producto_id,
	dbo.devolverTiempoDeFecha(t.ticket_fecha_hora),
	SUM(td.promo_aplicada_descuento),
	SUM(td.ticket_det_total),
	COUNT(distinct t.ticket_id),
	SUM(td.promo_aplicada_descuento) * 100 / SUM(td.ticket_det_total)
    from LOS_MIGRADORES.Ticket_Detalle td
    join LOS_MIGRADORES.Ticket t on t.ticket_id = td.ticket_id
	left join LOS_MIGRADORES.Promocion_Por_Ticket ppt on ppt.producto_id = td.producto_id and ppt.ticket_id = td.ticket_id
	GROUP BY
    td.producto_id,
	dbo.devolverTiempoDeFecha(t.ticket_fecha_hora)
GO

PRINT 'Migracion completa a tabla BI_Promocion...'
/*
SELECT * FROM LOS_MIGRADORES.Pago;
SELECT * FROM LOS_MIGRADORES.Detalle_Pago;
SELECT * FROM LOS_MIGRADORES.Ticket;
SELECT * FROM LOS_MIGRADORES.Cliente;
SELECT * FROM LOS_MIGRADORES.Descuento_MP;
SELECT * FROM LOS_MIGRADORES.Medio_de_Pago;
*/

--(5874 rows affected)


INSERT INTO LOS_MIGRADORES.BI_Pago (
    medio_de_pago_id, 
	sucursal_id, tiempo_id, 
	cliente_rango_etareo, 
	importe_pago_en_cuotas, 
    importe_pago_total , 
	descuento_total
)
select 
    p.pago_medio_pago AS medio_de_pago_id,
	t.ticket_sucursal,
	dbo.devolverTiempoDeFecha(p.pago_fecha) AS pago_fecha_hora,  
    dbo.devolverRangoEtareo(c.cliente_fecha_nacimiento) AS cliente_rango_etareo,
	SUM(dbo.devolverImporteDeCuotas(p.pago_importe, pd.detallepago_id )) AS importe_pago_en_cuotas,
	SUM(p.pago_importe),
	SUM(p.pago_descuento_aplicado)
	from LOS_MIGRADORES.Pago p 
    left join LOS_MIGRADORES.Detalle_Pago pd on pd.detallepago_id = p.pago_detalle_pago
    left join LOS_MIGRADORES.Pago_Por_Descuento ppd on ppd.pago_id = p.pago_id
    JOIN LOS_MIGRADORES.Ticket t ON p.pago_ticket_id = t.ticket_id
    left JOIN LOS_MIGRADORES.BI_Cliente c ON c.cliente_dni = t.ticket_cliente
	GROUP BY
	p.pago_medio_pago,
	t.ticket_sucursal,
	dbo.devolverTiempoDeFecha(p.pago_fecha), 
	dbo.devolverRangoEtareo(c.cliente_fecha_nacimiento)
GO
PRINT 'Migrando completa a tabla BI_Pago...'

PRINT 'Migracion finalizada...'
GO

/**************************** VISTAS *******************************/
PRINT 'Iniciando creacion de vistas'
GO
/*1. Ticket Promedio mensual. Valor promedio de las ventas (en $) según la
localidad, año y mes. Se calcula en función de la sumatoria del importe de las
ventas sobre el total de las mismas.*/

CREATE VIEW LOS_MIGRADORES.Vista_TicketPromedioMensual AS
SELECT DISTINCT 
    s.sucursal_localidad as localidad, 
    t.tiempo_anio as anio, 
    t.tiempo_mes as mes, 
    SUM(v.importe_total_ventas) / SUM(v.cantidad_ventas) AS valor_promedio_de_ventas
FROM LOS_MIGRADORES.BI_Venta v
JOIN LOS_MIGRADORES.BI_Sucursal s ON s.sucursal_nombre = v.sucursal_id
JOIN LOS_MIGRADORES.BI_Tiempo t ON t.tiempo_id = v.tiempo_id
GROUP BY 
    s.sucursal_localidad, 
    t.tiempo_anio, 
    t.tiempo_mes
GO

/*2. Cantidad unidades promedio. Cantidad promedio de artículos que se venden
en función de los tickets según el turno para cada cuatrimestre de cada año. Se
obtiene sumando la cantidad de artículos de todos los tickets correspondientes
sobre la cantidad de tickets. Si un producto tiene más de una unidad en un ticket,
para el indicador se consideran todas las unidades.*/

CREATE VIEW LOS_MIGRADORES.Vista_CantidadUnidadesPromedio AS
select 
     t.tiempo_cuatri cuatrimestre, v.turno_id turno, SUM(v.cantidad_articulos)/SUM(v.cantidad_ventas) promedio_articulos_por_ticket
FROM LOS_MIGRADORES.BI_Venta v
JOIN LOS_MIGRADORES.BI_Tiempo t ON t.tiempo_id = v.tiempo_id
GROUP BY t.tiempo_cuatri, v.turno_id
GO

/*3. Porcentaje anual de ventas registradas por rango etario del empleado según el
tipo de caja para cada cuatrimestre. Se calcula tomando la cantidad de ventas
correspondientes sobre el total de ventas anual.*/

CREATE VIEW v_porcentaje_anual_ventas
AS
SELECT e.empleado_rango_etareo as rango_etareo,
tc.tipocaja_nombre as tipo_caja,
t.tiempo_cuatri as cuatrimestre,
SUM(v.cantidad_ventas)/SUM(v.importe_total_ventas) as porcentaje_anual_de_ventas
FROM LOS_MIGRADORES.BI_Venta v
JOIN LOS_MIGRADORES.BI_Empleado e ON v.empleado_id = e.empleado_dni
JOIN LOS_MIGRADORES.BI_Tipo_Caja tc ON v.tipo_de_caja_id = tc.tipocaja_nombre
JOIN LOS_MIGRADORES.BI_Tiempo t ON t.tiempo_id = v.tiempo_id
GROUP BY tc.tipocaja_nombre,
t.tiempo_cuatri, e.empleado_rango_etareo
GO

/*4. Cantidad de ventas registradas por turno para cada localidad según el mes de
cada año.*/

CREATE VIEW LOS_MIGRADORES.CantidadVentasRegistradasPorTurno AS
SELECT
     v.turno_id AS turno,
     s.sucursal_localidad AS localidad, 
     t.tiempo_mes AS mes,
     t.tiempo_anio AS anio,
     SUM(v.cantidad_ventas) AS cantidad_ventas 
FROM LOS_MIGRADORES.BI_Venta v
JOIN LOS_MIGRADORES.BI_Tiempo t ON t.tiempo_id = v.tiempo_id
JOIN LOS_MIGRADORES.BI_Sucursal s ON s.sucursal_nombre = v.sucursal_id
GROUP BY v.turno_id,
     s.sucursal_localidad , 
     t.tiempo_mes ,
     t.tiempo_anio;
GO

/*5. Porcentaje de descuento aplicados en función del total de los tickets según el
mes de cada año.*/

CREATE VIEW v_PorcentajeDescuentoAplicadoEnFuncionDelTotal
AS
SELECT t.tiempo_mes as mes,
t.tiempo_anio as anio, 
AVG(p.porcentaje_descuento_respecto_total_tickets) as porcentaje_descuento_aplicado_respecto_total_tickets
FROM LOS_MIGRADORES.BI_Promocion p
JOIN LOS_MIGRADORES.BI_Tiempo t ON p.tiempo_id = t.tiempo_id
GROUP BY t.tiempo_mes, t.tiempo_anio
GO

/*6. Las tres categorías de productos con mayor descuento aplicado a partir de
promociones para cada cuatrimestre de cada año.*/

CREATE VIEW v_tres_categorias_productos_mayor_descuentos_aplicado
AS
SELECT TOP 3 p.producto_categoria categoria, 
t.tiempo_cuatri as cuatrimestre, 
t.tiempo_anio as anio, 
SUM(pr.descuento_total_aplicado_por_promocion) as descuento_aplicado
FROM LOS_MIGRADORES.BI_Promocion pr
JOIN LOS_MIGRADORES.BI_Producto p ON pr.producto_id = p.producto_id
JOIN LOS_MIGRADORES.BI_Tiempo t ON pr.tiempo_id = t.tiempo_id
GROUP BY p.producto_categoria, t.tiempo_cuatri, t.tiempo_anio
ORDER BY SUM(pr.descuento_total_aplicado_por_promocion) DESC
GO

/*7. Porcentaje de cumplimiento de envíos en los tiempos programados por
sucursal por año/mes (desvío)*/

CREATE VIEW v_porcentaje_cumplimiento_envios
AS
SELECT s.sucursal_nombre sucursal, t.tiempo_mes mes, t.tiempo_anio anio, 
SUM(e.cantidad_envios_cumplidos) * 100 / SUM(e.cantidad_envios)cant_envios_cumplidos
FROM LOS_MIGRADORES.BI_Envio e
JOIN LOS_MIGRADORES.BI_Sucursal s ON e.sucursal_id = s.sucursal_nombre
JOIN LOS_MIGRADORES.BI_Tiempo t ON t.tiempo_id = e.envio_fecha_entrega
GROUP BY s.sucursal_nombre, t.tiempo_mes, t.tiempo_anio
GO


/*8. Cantidad de envíos por rango etario de clientes para cada cuatrimestre de
cada año.*/

CREATE VIEW v_cantidad_envios_por_rango_etario_cuatrimestre AS
SELECT 
    t.tiempo_anio AS Año,
    t.tiempo_cuatri AS Cuatrimestre,
    c.cliente_rango_etareo AS RangoEtario,
    SUM(e.cantidad_envios) AS CantidadEnvios
FROM 
    LOS_MIGRADORES.BI_Envio e
JOIN 
    LOS_MIGRADORES.BI_Cliente c ON e.envio_cliente = c.cliente_dni
JOIN 
    LOS_MIGRADORES.BI_Tiempo t ON e.envio_fecha_programada = t.tiempo_id
GROUP BY 
    t.tiempo_anio, t.tiempo_cuatri, c.cliente_rango_etareo
GO

/*9. Las 5 localidades (tomando la localidad del cliente) con mayor costo de envío.*/
CREATE VIEW v_5LocalidadesMayorCosto
AS
SELECT TOP 5 c.cliente_localidad as localidad, 
SUM(e.envio_costo) as sumatoria_costo 
from LOS_MIGRADORES.BI_Envio e
JOIN LOS_MIGRADORES.BI_Cliente c ON c.cliente_dni = e.envio_cliente
GROUP BY c.cliente_localidad
ORDER BY SUM(e.envio_costo) DESC
GO

/*10. Las 3 sucursales con el mayor importe de pagos en cuotas, según el medio de
pago, mes y año. Se calcula sumando los importes totales de todas las ventas en
cuotas.*/

CREATE VIEW v_tres_sucursales_mayor_importe_en_cuotas
AS
SELECT TOP 3 p.sucursal_id as sucursal, 
p.medio_de_pago_id as medio_de_pago,
t.tiempo_anio as anio,
t.tiempo_mes as mes ,
SUM(p.importe_pago_en_cuotas) as importe_total
FROM LOS_MIGRADORES.BI_Pago p
JOIN LOS_MIGRADORES.BI_Tiempo t ON p.tiempo_id = t.tiempo_id
GROUP BY p.sucursal_id, 
p.medio_de_pago_id ,
t.tiempo_anio,
t.tiempo_mes
ORDER BY SUM(p.importe_pago_en_cuotas) DESC
GO

/*11. Promedio de importe de la cuota en función del rango etareo del cliente.*/

CREATE VIEW v_promedio_importe_rango_etareo
AS
SELECT p.cliente_rango_etareo as RangoEtareoCliente, 
AVG(p.importe_pago_en_cuotas) as Promedio_importe_cuota
FROM LOS_MIGRADORES.BI_Pago p
WHERE cliente_rango_etareo is not null
GROUP BY p.cliente_rango_etareo
GO

/*12. Porcentaje de descuento aplicado por cada medio de pago en función del valor
de total de pagos sin el descuento, por cuatrimestre. Es decir, total de descuentos
sobre el total de pagos más el total de descuentos.*/

CREATE VIEW v_porcentaje_desc_aplicado
AS
SELECT p.medio_de_pago_id AS medio_de_pago, 
t.tiempo_cuatri AS cuatrimestre,
(SUM(p.descuento_total)/
(SUM(p.importe_pago_total + p.descuento_total))) AS porcentaje_descuento_aplicado
FROM LOS_MIGRADORES.BI_Pago p
JOIN LOS_MIGRADORES.BI_Tiempo t ON p.tiempo_id = t.tiempo_id
GROUP BY p.medio_de_pago_id, t.tiempo_cuatri
GO

PRINT 'Creacion de vistas finalizada..'
GO