/*
	Nombre: Erick Octavio Nolasco Machuca
	Practica: 21
	Fecha: 3 de abril 2020

*/

/*Base de datos*/
use AdventureWorks_Part
go

/*Crear los grupos*/
ALTER DATABASE AdventureWorks_Part
	ADD FILEGROUP Adventure1
GO
ALTER DATABASE AdventureWorks_Part
	ADD FILEGROUP Adventure2
GO
ALTER DATABASE AdventureWorks_Part
	ADD FILEGROUP Adventure3
GO
ALTER DATABASE AdventureWorks_Part
	ADD FILEGROUP Adventure4
GO


/*Relacionar los archivos*/
ALTER DATABASE AdventureWorks_Part
ADD FILE
(
	NAME ='Adventure1.NDF',
	FILENAME ='C:\BD\DISCO1\Adventure1.NDF'
)
TO FILEGROUP Adventure1;

ALTER DATABASE AdventureWorks_Part
ADD FILE
(
	NAME ='Adventure2.NDF',
	FILENAME ='C:\BD\DISCO2\Adventure2.NDF'
)
TO FILEGROUP Adventure2;

ALTER DATABASE AdventureWorks_Part
ADD FILE
(
	NAME ='Adventure3.NDF',
	FILENAME ='C:\BD\DISCO3\Adventure3.NDF'
)
TO FILEGROUP Adventure3;
ALTER DATABASE AdventureWorks_Part
ADD FILE
(
	NAME ='Adventure4.NDF',
	FILENAME ='C:\BD\DISCO4\Adventure4.NDF'
)
TO FILEGROUP Adventure4;

/*Crear la funcion*/
drop partition function BusinessEntityID
CREATE PARTITION FUNCTION PBusinessEntityID(int)
AS RANGE right FOR VALUES (210,220,230);

/*Esquema de particion*/
CREATE PARTITION SCHEME SchemaByBusiness
AS PARTITION PBusinessEntityID
TO (Adventure1, Adventure2, Adventure3,Adventure4);

/*Crear la tabla para particionar*/

Create table Sales.SalesPersonPart
(
	BusinessEntityID int primary key nonclustered REFERENCES AdventureWorks_Part.HumanResources.Employee (BusinessEntityID),
	TerritoryID int REFERENCES AdventureWorks_Part.Sales.SalesTerritory (TerritoryID) not null,
	SalesQuota money,
	Bonus money,
	CommissionPct smallmoney,
	SalesYTD money,
	SalesLastYear money,
	rowguid uniqueidentifier,
	ModifiedDate datetime

)
go

exec sp_helpconstraint [Sales.SalesPerson]

/*Clusterar el indice*/
/*Clusterear el indice*/
CREATE CLUSTERED INDEX IDX_P_SalesPerson
ON Sales.SalesPersonPart (BusinessEntityID)
ON SchemaByBusiness(BusinessEntityID);

/*Pasar los datos a la nueva tabla*/
insert into Sales.SalesPersonPart select * from Sales.SalesPerson
go

/*Borrar la tabla antigua*/
ALTER TABLE Sales.SalesOrderHeader 
DROP CONSTRAINT FK_SalesOrderHeader_SalesPerson_SalesPersonID

ALTER TABLE Sales.SalesPersonQuotaHistory
DROP CONSTRAINT FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID

Alter table Sales.SalesTerritoryHistory
drop constraint  FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID

Alter table Sales.Store
drop constraint FK_Store_SalesPerson_SalesPersonID


Drop table Sales.SalesPerson
GO


use AdventureWorks_Part

EXEC sp_rename 'Sales.SalesPersonPart', 'Sales.SalesPerson';

ALTER TABLE Sales.SalesOrderHeader
ADD CONSTRAINT FK_SalesOrderHeader_SalesPerson_SalesPersonID
FOREIGN KEY (SalesPersonID) REFERENCES [Sales.SalesPerson](SalesPersonID)

ALTER TABLE Sales.SalesPersonQuotaHistory
ADD CONSTRAINT FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityID
FOREIGN KEY (BusinessEntityID) REFERENCES [Sales.SalesPerson](BusinessEntityID)

alter table Sales.SalesTerritoryHistory
add constraint FK_SalesTerritoryHistory_SalesPerson_BusinessEntityID
foreign key(BusinessEntityID ) references Sales.SalesPerson(BusinessEntityID)

Alter table Sales.Store
add constraint FK_Store_SalesPerson_SalesPersonID
foreign key (SalesPersonID) references Sales.SalesPerson(SalesPersonID)

