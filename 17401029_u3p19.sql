/*
	Nombre: Erick Octavio Nolasco Machuca
	Practica: 19
	Fecha: 3 de abril 2020
*/

/*LA BD AdventureWorks es una bd de ejemplo que nos
proporciona Microsoft para sqlserver hay diferentes
versiones pero en esta ocasión utilizaremos la 2008R2*/

use AdventureWorks2008R2
go

/*LA BD AdventureWorks es una bd de ejemplo que nos
proporciona Microsoft para sqlserver hay diferentes
versiones pero en esta ocasión utilizaremos la 2008R2*/

--Crear los grupos 
ALTER DATABASE AdventureWorks2008R2
	ADD FILEGROUP Particion1
GO
ALTER DATABASE AdventureWorks2008R2
	ADD FILEGROUP Particion2
GO
ALTER DATABASE AdventureWorks2008R2
	ADD FILEGROUP Particion3
GO

--Relacionar los archivos


ALTER DATABASE AdventureWorks2008R2
ADD FILE
(
	NAME ='Particion1.NDF',
	FILENAME ='C:\BD\DISCO1\Particion1.NDF'
)
TO FILEGROUP Particion1;

ALTER DATABASE AdventureWorks2008R2
ADD FILE
(
	NAME ='P2.NDF',
	FILENAME ='C:\BD\DISCO2\P2.NDF'
)
TO FILEGROUP Particion2;

ALTER DATABASE AdventureWorks2008R2
ADD FILE
(
	NAME ='P3.NDF',
	FILENAME ='C:\BD\DISCO3\P3.NDF'
)
TO FILEGROUP Particion3;

/*Creacion de la funcion de particion*/
--FUNCIÓN DE PARTICIÓN
CREATE PARTITION FUNCTION F_CITY(nvarchar(30))
AS RANGE right FOR VALUES ('J','Q');

/*Esquema de particion*/

CREATE PARTITION SCHEME EsquemaByCity
AS PARTITION F_CITY
TO (Particion1, Particion2, Particion3);

/*Crear la nueva tabla para particionar*/
CREATE TABLE Person.Address_P
(
	AddressID INT IDENTITY(1,1) NOT NULL PRIMARY KEY NONCLUSTERED,
	AddressLine1 nvarchar(60) NOT NULL,
	AddressLine2 nvarchar(60) NULL,
	City nvarchar(30) NOT NULL,
	StateProvinceID int not null REFERENCES Person.StateProvince(StateProvinceID),
	PostalCode nvarchar(15),
	SpatialLocation geography null,
	rowguid uniqueidentifier not null,
	ModifiedDate datetime not null
);
/*Clusterear el indice*/
CREATE CLUSTERED INDEX IDX_P_City
ON Person.Address_P (City)
ON EsquemaByCity(City);

/*Pasar los datos*/
INSERT INTO Person.Address_P
SELECT AddressLine1,AddressLine2,City,StateProvinceID,PostalCode,
		SpatialLocation,rowguid,ModifiedDate
FROM Person.Address

/*Borrar todo lo de la tabla */
--ver los constraint
exec sp_helpconstraint [Person.Address]

/*Borrar las llaves foraneas*/

ALTER TABLE Person.BusinessEntityAddress 
DROP CONSTRAINT FK_BusinessEntityAddress_Address_AddressID

ALTER TABLE Sales.SalesOrderHeader
DROP CONSTRAINT FK_SalesOrderHeader_Address_BillToAddressID 

ALTER TABLE Sales.SalesOrderHeader
DROP CONSTRAINT FK_SalesOrderHeader_Address_ShipToAddressID 

ALTER TABLE Person.Address
DROP CONSTRAINT FK_Address_StateProvince_StateProvinceID 


--ELIMINAR TABLA
DROP TABLE Person.Address;

--RENOMBRAR
EXEC sp_rename 'Person.Address_P', 'Address';

/*Volver a colocar todas las relaciones*/
ALTER TABLE Person.Address
ADD CONSTRAINT FK_Address_StateProvince_StateProvinceID
FOREIGN KEY (StateProvinceID) REFERENCES Person.StateProvince(StateProvinceID)

ALTER TABLE Person.BusinessEntityAddress with nocheck
ADD CONSTRAINT FK_BusinessEntityAddress_Address_AddressID 
FOREIGN KEY (AddressID) REFERENCES [Person].[Address](AddressID)

ALTER TABLE Sales.SalesOrderHeader with nocheck
ADD CONSTRAINT FK_SalesOrderHeader_Address_BillToAddressID
FOREIGN KEY (BillToAddressID) REFERENCES Person.Address(AddressID)

ALTER TABLE Sales.SalesOrderHeader with nocheck
ADD CONSTRAINT FK_SalesOrderHeader_Address_ShipToAddressID
FOREIGN KEY (ShipToAddressID) REFERENCES Person.Address(AddressID)

-- MOSTRAR LOS REGISTROS DE CADA PARTICIÓN
SELECT * FROM Person.Address
WHERE $partition.F_City(City)=1
GO

SELECT * FROM Person.Address
WHERE $partition.F_City(City)=2
GO

SELECT * FROM Person.Address
WHERE $partition.F_City(City)=3
GO