/*
	Nombre: Erick Octavio Nolasco Machuca
	Practica: 22
	Fecha: 3 de abril 2020
*/

/*1. USA EL QUERY DE LA BD DE DATOS NORTHWIND, DENUEVO Y
CREE LA BD PERO CON OTRO NOMBRE AUNQUE TENGA EL
MISMO CONTENIDO.*/
--Est� creada con el mismo nombre porque sinceramente cambiarcelo me dio demasiados problemas a la hora de crearla

/*ACTUALICE LAS FECHAS DE LAS ORDENES, QUE SEAN DE LOS
A�OS MAS RECIENTES.*/

select * from Orders;

Update Orders set OrderDate = DATEADD(YY,21,OrderDate)

/*3. PARTICIONE LA TABLA ORDES POR RANGOS DE ORDENES LAS ID*/

/*1. Crear una BD llama BDParticion_Principio
2. Crear los filegroups (4)
3. Crear los datafiles y ligarlos con los filegroups
4. Crear la funci�n de partici�n (pero
5. Crear el esquema de partici�n
6. Crear la tabla(s) para nuestro caso la tabla Reports con la siguiente
sintaxis*/

--Crear los filegroup
ALTER DATABASE Northwind
	ADD FILEGROUP Primera
GO
ALTER DATABASE Northwind
	ADD FILEGROUP Segunda
GO
ALTER DATABASE Northwind
	ADD FILEGROUP Tercera
GO
ALTER DATABASE Northwind
	ADD FILEGROUP Cuarta
GO
ALTER DATABASE Northwind
	ADD FILEGROUP Quinta
GO
ALTER DATABASE Northwind
	ADD FILEGROUP Sexta
GO
ALTER DATABASE Northwind
	ADD FILEGROUP Extra
GO


--Ligar los archivos con los filegroups
ALTER DATABASE Northwind
ADD FILE
(
	NAME ='Extra.NDF',
	FILENAME ='C:\BD\DISCO4\Extra.NDF'
)
TO FILEGROUP Extra;
--
ALTER DATABASE Northwind
ADD FILE
(
	NAME ='Primera.NDF',
	FILENAME ='C:\BD\DISCO1\Primera.NDF'
)
TO FILEGROUP Primera;
--
ALTER DATABASE Northwind
ADD FILE
(
	NAME ='Segunda.NDF',
	FILENAME ='C:\BD\DISCO2\Segunda.NDF'
)
TO FILEGROUP Segunda;
--
ALTER DATABASE Northwind
ADD FILE
(
	NAME ='Tercera.NDF',
	FILENAME ='C:\BD\DISCO3\Tercera.NDF'
)
TO FILEGROUP Tercera;
--
ALTER DATABASE Northwind
ADD FILE
(
	NAME ='Cuarta.NDF',
	FILENAME ='C:\BD\DISCO4\Cuarta.NDF'
)
TO FILEGROUP Cuarta;
--
ALTER DATABASE Northwind
ADD FILE
(
	NAME ='Quinta.NDF',
	FILENAME ='C:\BD\DISCO4\Quinta.NDF'
)
TO FILEGROUP Quinta;
--
ALTER DATABASE Northwind
ADD FILE
(
	NAME ='Sexta.NDF',
	FILENAME ='C:\BD\DISCO4\Sexta.NDF'
)
TO FILEGROUP Sexta;

/*Crear la funci�n de partici�n*/


CREATE PARTITION FUNCTION PorOrden(int)
AS RANGE right FOR VALUES (10301,10501,10701,10901,11101);

--Esquema de particion
CREATE PARTITION SCHEME SchemaPorOrden
AS PARTITION PorOrden
TO (Extra, Primera, Segunda,Tercera,Cuarta,Quinta);

--Creaci�n de la tabla

Create table OrdersPart
(
	OrderID int primary key,
	CustomerID nchar(5),
	EmployeeID int,
	OrderDate datetime,
	RequiredDate datetime,
	ShippedDate datetime,
	ShipVia int,
	Freight money,
	ShipName nvarchar(40),
	ShipAddress nvarchar(60),
	ShipCity nvarchar(15),
	ShipRegion nvarchar(15),
	ShipPostalCode nvarchar(10),
	ShipCountry nvarchar(15)
)
go

/*Acomodar la nueva tabla para ser la buena*/
CREATE CLUSTERED INDEX IDX_OrderP
ON OrderPart (OrderID)
ON SchemaPorOrden(OrderId);

insert into OrdersPart select * from Orders
go

ALTER TABLE OrdersPart
ADD CONSTRAINT FK_Orders_Customers1
FOREIGN KEY (CustomerID)  REFERENCES Northwind.dbo.Customers (CustomerID)

ALTER TABLE OrdersPart
ADD CONSTRAINT FK_Orders_Employees1
FOREIGN KEY (EmployeeID)  REFERENCES Northwind.dbo.Employees (EmployeeID)

ALTER TABLE OrdersPart
ADD CONSTRAINT FK_Orders_Shippers1
FOREIGN KEY (ShipVia)  REFERENCES Northwind.dbo.Shippers (ShipperID)

Alter table [Order Details]
add constraint FK_Order_Details_Orders1
foreign key (OrderID) references OrdersPart(OrderID)



exec sp_helpconstraint Orders
/*Eliminar la vieja tabla y renombrar*/
alter table [Order_Details]
DROP constraint FK_Order_Details_Orders

drop table Orders
go



EXEC sp_rename 'OrdersPart', 'Orders';

