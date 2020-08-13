/*
 Nombre: Erick Octavio Nolasco Machuca
 Fecha : 4 de abril 2020
 Practica 16
*/

CREATE DATABASE BDParticiones
ON PRIMARY
(
 NAME = 'BDarticiones.mdf',
 FILENAME = 'C:\BD\BDParticiones.mdf'
)
LOG ON
(
 NAME = 'BDParticiones.ldf',
 FILENAME = 'C:\BD\BDParticiones.ldf'
)
go

-- CREAR UNA TABLA Reports
use BDParticiones
go

CREATE TABLE Reports
 (IdReport  int identity(1,1) PRIMARY KEY,
  ReportDate date  not null default getdate(),
  ReportName varchar (100),
  ReportNumber varchar (20),
  ReportDescription varchar (max)
)
GO

use BDParticiones
--- LLENAREMOS DE DATOS LA TABLA
DECLARE @i int
DECLARE @fecha date
SET @i = 1

BEGIN TRAN
WHILE @i<=100000
BEGIN 
 
 IF @i between 1 and 1000
    SET @fecha = '2017/01/15'
 IF @i between 10001 and 25000
    SET @fecha = '2017/03/15'
 IF @i between 25001 and 28000
    SET @fecha = '2017/04/15'
 IF @i between 28001 and 29500
    SET @fecha = '2017/03/15'
 IF @i between 29501 and 31000
    SET @fecha = '2018/02/15'
 IF @i between 31001 and 32000
    SET @fecha = '2018/03/15'
 IF @i between 32001 and 35000
    SET @fecha = '2018/04/15'
 IF @i between 35001 and 42500
    SET @fecha = '2018/05/15'
 IF @i between 42501 and 45000
    SET @fecha = '2018/06/15'
 IF @i between 45001 and 47500
    SET @fecha = '2018/07/15'
 IF @i between 47501 and 52500
    SET @fecha = '2018/08/15'
 IF @i between 52501 and 55000
    SET @fecha = '2018/09/15'
 IF @i between 55001 and 60000
    SET @fecha = '2018/10/15'
 IF @i between 60001 and 62475
    SET @fecha = '2018/11/15'
 IF @i between 62476 and 65345
    SET @fecha = '2018/12/15'
 IF @i between 65346 and 66000
    SET @fecha = '2019/01/15'
 IF @i between 66001 and 67000
    SET @fecha = '2019/02/15'
 IF @i between 67001 and 68000
    SET @fecha = '2019/03/15' 
 IF @i between 68001 and 69000
    SET @fecha = '2019/04/15'  
 IF @i between 69001 and 70000
    SET @fecha = '2019/05/15' 
IF @i between 70001 and 70500
    SET @fecha = '2019/06/15'
 IF @i between 70500 and 72000
    SET @fecha = '2019/07/15' 
 IF @i between 72001 and 73000
    SET @fecha = '2019/08/15'  
 IF @i between 73001 and 73800
    SET @fecha = '2019/09/15' 
 IF @i between 73801 and 73950
    SET @fecha = '2019/10/15' 
 IF @i between 73951 and 75700
    SET @fecha = '2019/11/15' 
 IF @i between 75701 and 75802
    SET @fecha = '2019/12/15' 
 IF @i between 75803 and 80000
    SET @fecha = '2020/01/15' 
 IF @i between 80001 and 90000
    SET @fecha = '2020/02/15' 
	IF @i between 90001 and 100000
    SET @fecha = '2020/03/15' 
INSERT INTO Reports
(
 ReportDate,
 ReportName,
 ReportNumber,
 ReportDescription
)
VALUES
(
@fecha,
'ReportName' + CONVERT (varchar (20), @i) ,
CONVERT (varchar (20), @i),
REPLICATE ('Report', 1000)
)
SET @i=@i+1
END
COMMIT TRAN
GO
--- verificando
select count(*) from Reports


-- Creando los filegroups
use BDParticiones

ALTER DATABASE BDParticiones
ADD FILEGROUP Histo2017
GO
ALTER DATABASE BDParticiones
ADD FILEGROUP Histo2018
GO
ALTER DATABASE BDParticiones
ADD FILEGROUP Histo2019
GO
ALTER DATABASE BDParticiones
ADD FILEGROUP Histo2020
GO

-- CREAR DATAFILES

ALTER DATABASE BDParticiones
ADD FILE 
(
 NAME = 'Particion2017.NDF',
 FILENAME = 'C:\BD\DISCO1\Particion2017.NDF'
 ) TO FILEGROUP Histo2017;

ALTER DATABASE BDParticiones
ADD FILE 
(
 NAME = 'Particion2018.NDF',
 FILENAME = 'C:\BD\DISCO2\Particion2018.NDF'
 ) TO FILEGROUP Histo2018;


ALTER DATABASE BDParticiones
ADD FILE 
(
 NAME = 'Particion2019.NDF',
 FILENAME = 'C:\BD\DISCO3\Particion2019.NDF'
 ) TO FILEGROUP Histo2019;

ALTER DATABASE BDParticiones
ADD FILE 
(
 NAME = 'Particion2020.NDF',
 FILENAME = 'C:\BD\DISCO4\Particion2020.NDF'
 ) TO FILEGROUP Histo2020;

-- CREAR FUNCION DE PARTICION
CREATE PARTITION FUNCTION F_PartitionByAnio(date)
AS RANGE LEFT FOR VALUES ( '20171231','20181231','20191231')


-- CREAR ESQUEMA DE PARTICION
CREATE PARTITION SCHEME EsquemaByAnio
AS PARTITION F_PartitionByAnio
TO (Histo2017, Histo2018, Histo2019, Histo2020);


-- CREANDO TABLA NUEVA
CREATE TABLE Reports_Particionada
 (IdReport  int PRIMARY KEY NONCLUSTERED,
  ReportDate date  not null default getdate(),
  ReportName varchar (100),
  ReportNumber varchar (20),
  ReportDescription varchar (max)
)
GO

-- CREANDO EL INDICE CLUSTEREADO POR EL CAMPO 
-- DE LA PARTICIÓN Y ASIGNAMOS EL ESQUEMA DE PARTICION
CREATE CLUSTERED INDEX IDX_RepPart
ON Reports_Particionada (ReportDate)
ON EsquemaByAnio(ReportDate);
-- CON ESTO YA PARTICIONAMOS LA TABLA

-- COPIAR LOS DATOS CON INSERT-SELECT
INSERT INTO Reports_Particionada  
SELECT * FROM Reports
-- COMPROBAR QUE SI SE PASARON
SELECT count(*) FROM Reports_Particionada

-- ELIMINAR LA TABLA ORIGINAL Y RENOMBRAR
-- LA PARTICIONADA, EN CASO DE TENER FK, O
-- TABLAS HIJAS RESTRABLECER LAS RELACIONES
-- Y TODOS LOS CONSTRAINT PARA QUEDE COMO
-- LA ORIGINAL

DROP TABLE Reports;

EXEC sp_rename 'Reports_Particionada', 'Reports';


--VERIFICANDO QUE REALMENTE SE PARTICIONO

-- CONSULTAR TODA LA TABLA
SELECT * FROM  Reports

-- MOSTRAR LOS REGISTROS DE CADA PARTICION
-- SE USA EL NOMBRE DE LA FUNCION DE PARTICION
-- Y EL NOMBRE DEL CAMPO QUE USAMOS PARA 
-- PARTICIONAR
SELECT * FROM Reports
WHERE $partition.F_PartitionByAnio(ReportDate)=1
GO
SELECT * FROM Reports
WHERE $partition.F_PartitionByAnio(ReportDate)=2
GO
SELECT * FROM Reports
WHERE $partition.F_PartitionByAnio(ReportDate)=3
GO
SELECT * FROM Reports
WHERE $partition.F_PartitionByAnio(ReportDate)=4
GO
-- otra forma de hacerlo
SELECT * FROM Reports
WHERE Year(ReportDate) = '2018' 

-- EJECUTE CADA CONSULTA PARA QUE VEA LA DIFERENCIA
-- ENTRE CONSULTAR TODA LA TABLA O UNA PARTICION 
-- EN ESPECIFICO O SI USTED  HACE UNA CONSULTA
-- DE UN AÑO EN ESPECIFICO

-- MUESTRE CUANTOS REGISTRO TIENE CADA PARTICION
SELECT p.partition_number AS Num_Particion, f.name AS Nombre, p.rows AS Columnas
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(OBJECT_ID) = 'Reports'
AND p.index_id =1;