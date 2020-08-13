/*
	Nombre: Erick Octavio Nolasco Machuca
	Practica: 18
	Fecha: 3 de abril 2020
*/

/*1. Crear una BD llama BDParticion_Principio*/
CREATE DATABASE BDParticion_Principio
ON PRIMARY
(
	NAME = 'BDParticiones_Principio.MDF',
	FILENAME = 'C:\BD\Particiones\BDParticion_Principio.MDF'
)
LOG ON
(
	NAME = 'BDParticiones_Principio.LDF',
	FILENAME = 'C:\BD\Particiones\BDParticion_Principio.LDF'
)
GO

/*2. Crear los filegroups (4)*/
USE BDParticion_Principio
GO

ALTER DATABASE BDParticion_Principio
	ADD FILEGROUP Histo2017R
GO

ALTER DATABASE BDParticion_Principio
	ADD FILEGROUP Histo2018R
GO

ALTER DATABASE BDParticion_Principio
	ADD FILEGROUP Histo2019R
GO

ALTER DATABASE BDParticion_Principio
	ADD FILEGROUP Histo2020R
GO

/*3. Crear los datafiles y ligarlos con los filegroups*/
ALTER DATABASE BDParticion_Principio
ADD FILE
(
	NAME ='PartiPrin2017.NDF',
	FILENAME ='C:\BD\DISCO1\PartiPrin2017.NDF'
)
TO FILEGROUP Histo2017R;

ALTER DATABASE BDParticion_Principio
ADD FILE
(
	NAME ='PartiPrin2018.NDF',
	FILENAME ='C:\BD\DISCO2\PartiPrin2018.NDF'
)TO FILEGROUP Histo2018R;

ALTER DATABASE BDParticion_Principio
ADD FILE
(
	NAME ='PartiPrin2019.NDF',
	FILENAME ='C:\BD\DISCO3\PartiPrin2019.NDF'
)TO FILEGROUP Histo2019R;

ALTER DATABASE BDParticion_Principio
ADD FILE
(
	NAME ='PartiPrin2020.NDF',
	FILENAME ='C:\BD\DISCO4\PartiPrin2020.NDF'
)TO FILEGROUP Histo2020R;

/*4. Crear la función de partición (pero*/
CREATE PARTITION FUNCTION F_PrimaryK(INT)
AS RANGE LEFT FOR VALUES (1,3000,6000);

/*5. Crear el esquema de partición*/
CREATE PARTITION SCHEME Pimaryk
AS PARTITION F_PrimaryK
TO (Histo2017R, Histo2018R, Histo2019R, Histo2020R);

/*Crear la tabla(s) para nuestro caso la tabla Reports con la siguiente
sintaxis*/

CREATE TABLE Reports
(IdReport int identity(1,1) PRIMARY KEY,
ReportDate date not null default getdate(),
ReportName varchar (100),
ReportNumber varchar (20),
ReportDescription varchar (max)
) ON Pimaryk (IdReport)
GO

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