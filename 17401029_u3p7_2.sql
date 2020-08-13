--Autor: Erick Octavio Nolasco Machuca
--Practica 7

--2. POR MEDIO DE SA ORGANIZALA EN ESQUEMAS, CREA AL MENOS 3
--ESQUEMAS Y REPARTE LAS TABLAS EN CADA UNA

Create schema Personas
go
Create schema Ventas
go
create schema Tienda
go

ALTER SCHEMA Personas TRANSFER dbo.CustomerCustomerDemo;  
GO
ALTER SCHEMA Personas TRANSFER dbo.Customers;  
GO
ALTER SCHEMA Personas TRANSFER dbo.Employees;  
GO
ALTER SCHEMA Personas TRANSFER dbo.Shippers;  
GO

ALTER SCHEMA Ventas TRANSFER dbo.[Order Details];  
GO
ALTER SCHEMA Ventas TRANSFER dbo.Orders;  
GO
ALTER SCHEMA Ventas TRANSFER dbo.Products;  
GO
ALTER SCHEMA Ventas TRANSFER dbo.Suppliers;  
GO

ALTER SCHEMA Tienda TRANSFER dbo.CustomerDemographics;  
GO
ALTER SCHEMA Tienda TRANSFER dbo.EmployeeTerritories;  
GO
ALTER SCHEMA Tienda TRANSFER dbo.Region;  
GO
ALTER SCHEMA Tienda TRANSFER dbo.Territories;  
GO
ALTER SCHEMA Tienda TRANSFER dbo.Categories;  
GO

--3. CREA UN USUARIO QUE SOLO PUEDA CONSULTAR , INSERTAR Y MODIFICAR
--EN UN SOLO ESQUEMA Y REALIZA LAS PRUEBAS NECESARIAS

Create login NortConsu1
with Password='1234'
go
create user NortConsu1
for login NortConsu1
go

GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA :: Personas TO NortConsu1;

--4. CREA OTRO USUARIO QUE SOLO PUEDA CONSULTAR EN TODOS LOS
--ESQUEMAS

create login NortConsu2
with password='1234'
go
create user NortConsu2
for login NortConsu2
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA :: Personas TO NortConsu2;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA :: Tienda TO NortConsu2;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA :: Ventas TO NortConsu2;

--CREA UN TERCER USUARIO QUE SOLO PUEDA USAR LA TABLA PRODUCTS
--PARA CONSULTAR INSERTAR, MODIFICAR, BORRAR REGISTROS

create login NortConsu3
with password='1234'
go
create user NortConsu3
for login NortConsu3
GO

GRANT SELECT, INSERT, UPDATE, DELETE ON Ventas.Products TO NortConsu3;