/*
	Nombre: Erick Octavio Nolasco Machuca
	Practica: 25
	Fecha: 3 de abril 2020

*/

/*En la base de datos northwind*/
use Northwind
go

/*PASO 1. Crearemos la tabla con el índice clustereado de
la llave primaria.*/

CREATE TABLE EmployeeReports
(
ReportID int IDENTITY (1,1) NOT
NULL,
ReportName varchar (100),
ReportNumber varchar (20),
ReportDescription varchar (max)
CONSTRAINT PK_EReport PRIMARY KEY
CLUSTERED (ReportID)
)

/*PASO 2. Le pondremos 1000 registros*/
DECLARE @i int
SET @i = 1

BEGIN TRAN
WHILE @i<100000
BEGIN
INSERT INTO EmployeeReports
(
ReportName,
ReportNumber,
ReportDescription
)
VALUES
(
'ReportName' + CONVERT (varchar (20), @i) ,
CONVERT (varchar (20), @i),
REPLICATE ('Report', 1000)
)
SET @i=@i+1
END
COMMIT TRAN
GO

/*solo para que al final comprobar la mejora de
rendimiento con particiones consultaremos la tabla*/
SET STATISTICS IO ON
SET STATISTICS TIME ON
SELECT er.ReportID, er.ReportName,
er.ReportNumber
FROM dbo.EmployeeReports er
WHERE er.ReportNumber LIKE '%33%'
SET STATISTICS IO OFF
SET STATISTICS TIME OFF

/*PASO 3. Particionaremos verticalmente la tabla
EmployeesReport*/
CREATE TABLE ReportsDesc
( ReportID int REFERENCES EmployeeReports(ReportID),
ReportDescription varchar(max)
CONSTRAINT PK_ReportDesc PRIMARY KEY CLUSTERED(ReportID)
);
CREATE TABLE ReportsData
(
ReportID int NOT NULL,
ReportName varchar (100),
ReportNumber varchar (20),
CONSTRAINT DReport_PK PRIMARY KEY CLUSTERED (ReportID)
)
INSERT INTO dbo.ReportsData
(
ReportID,
ReportName,
ReportNumber
)
SELECT er.ReportID,
er.ReportName,
er.ReportNumber
FROM dbo.EmployeeReports er

/*NOTA: Corremos la misma consulta de búsqueda*/
SET STATISTICS IO ON
SET STATISTICS TIME ON
SELECT er.ReportID, er.ReportName,
er.ReportNumber
FROM ReportsData er
WHERE er.ReportNumber LIKE '%33%'
SET STATISTICS IO OFF
SET STATISTICS TIME OFF