/*
 Nombre: Erick Octavio Nolasco Machuca
 Fecha : 4 de abril 2020
 Practica 17
*/
use ALMACEN
go

/*Insertar los datos*/
Declare @i int
Declare @fecha date
set @i=1

begin tran 
while @i<=130000
begin

if @i between 1 and 10000
	set @fecha = '2019/01/5'
if @i between 10001 and 20000
	set @fecha = '2019/02/5'
if @i between 20001 and 30000
	set @fecha = '2019/03/5'
if @i between 30001 and 40000
	set @fecha = '2019/04/5'
if @i between 40001 and 50000
	set @fecha = '2019/05/5'
if @i between 50001 and 60000
	set @fecha = '2019/06/5'
if @i between 60001 and 70000
	set @fecha = '2019/07/5'
if @i between 70001 and 80000
	set @fecha = '2019/08/5'
if @i between 80001 and 90000
	set @fecha = '2019/09/5'
if @i between 90001 and 100000
	set @fecha = '2019/10/5'
if @i between 100001 and 110000
	set @fecha = '2019/11/5'
if @i between 110001 and 120000
	set @fecha = '2019/12/5'
if @i between 120001 and 130000
	set @fecha = '2020/01/10'

insert into VENTAS VALUES (@i,@fecha,1,1000,2,1,160)

set @i = @i+1
end
commit tran
go


/*Crear los filegroups*/
ALTER DATABASE ALMACEN
ADD FILEGROUP AventasEnero2019
GO
ALTER DATABASE ALMACEN
ADD FILEGROUP AventasFebrero2019
GO
ALTER DATABASE ALMACEN
ADD FILEGROUP AventasMarzo2019
GO
ALTER DATABASE ALMACEN
ADD FILEGROUP AventasAbril2019
GO
ALTER DATABASE ALMACEN
ADD FILEGROUP AventasMayo2019
GO
ALTER DATABASE ALMACEN
ADD FILEGROUP AventasJunio2019
GO
ALTER DATABASE ALMACEN
ADD FILEGROUP AventasJulio2019
GO
ALTER DATABASE ALMACEN
ADD FILEGROUP AventasAgosto2019
GO
ALTER DATABASE ALMACEN
ADD FILEGROUP AventasSeptiembre2019
GO
ALTER DATABASE ALMACEN
ADD FILEGROUP AventasOctubre2019
GO
ALTER DATABASE ALMACEN
ADD FILEGROUP AventasNoviembre2019
GO
ALTER DATABASE ALMACEN
ADD FILEGROUP AventasDiciembre2019
GO
ALTER DATABASE ALMACEN
ADD FILEGROUP Aventas2020
GO

/*Añadirlas al disco*/
ALTER DATABASE ALMACEN
ADD FILE 
(
 NAME = 'ParticionAVEnero2019.NDF',
 FILENAME = 'C:\BD\DISCO1\ParticionAVEnero2019.NDF'
 ) TO FILEGROUP AventasEnero2019;

 ALTER DATABASE ALMACEN
ADD FILE 
(
 NAME = 'ParticionAVFebrero2019.NDF',
 FILENAME = 'C:\BD\DISCO1\ParticionAVFebrero2019.NDF'
 ) TO FILEGROUP AventasFebrero2019;

 ALTER DATABASE ALMACEN
ADD FILE 
(
 NAME = 'ParticionAVMarzo2019.NDF',
 FILENAME = 'C:\BD\DISCO1\ParticionAVMarzo2019.NDF'
 ) TO FILEGROUP AventasMarzo2019;

 ALTER DATABASE ALMACEN
ADD FILE 
(
 NAME = 'ParticionAVAbril2019.NDF',
 FILENAME = 'C:\BD\DISCO1\ParticionAVAbril2019.NDF'
 ) TO FILEGROUP AventasAbril2019;

 ALTER DATABASE ALMACEN
ADD FILE 
(
 NAME = 'ParticionAVMayo2019.NDF',
 FILENAME = 'C:\BD\DISCO2\ParticionAVMayo2019.NDF'
 ) TO FILEGROUP AventasMayo2019;

 ALTER DATABASE ALMACEN
ADD FILE 
(
 NAME = 'ParticionAVJunio2019.NDF',
 FILENAME = 'C:\BD\DISCO2\ParticionAVJunio2019.NDF'
 ) TO FILEGROUP AventasJunio2019;

 ALTER DATABASE ALMACEN
ADD FILE 
(
 NAME = 'ParticionAVJulio2019.NDF',
 FILENAME = 'C:\BD\DISCO2\ParticionAVJulio2019.NDF'
 ) TO FILEGROUP AventasJulio2019;

 ALTER DATABASE ALMACEN
ADD FILE 
(
 NAME = 'ParticionAVAgosto2019.NDF',
 FILENAME = 'C:\BD\DISCO2\ParticionAVAgosto2019.NDF'
 ) TO FILEGROUP AventasAgosto2019;

 ALTER DATABASE ALMACEN
ADD FILE 
(
 NAME = 'ParticionAVSeptiembre2019.NDF',
 FILENAME = 'C:\BD\DISCO3\ParticionAVSeptiembre2019.NDF'
 ) TO FILEGROUP AventasSeptiembre2019;

 ALTER DATABASE ALMACEN
ADD FILE 
(
 NAME = 'ParticionAVOctubre2019.NDF',
 FILENAME = 'C:\BD\DISCO3\ParticionAVOctubre2019.NDF'
 ) TO FILEGROUP AventasOctubre2019;

 ALTER DATABASE ALMACEN
ADD FILE 
(
 NAME = 'ParticionAVNoviembre2019.NDF',
 FILENAME = 'C:\BD\DISCO3\ParticionAVNoviembre2019.NDF'
 ) TO FILEGROUP AventasNoviembre2019;

 ALTER DATABASE ALMACEN
ADD FILE 
(
 NAME = 'ParticionAVDiciembre2019.NDF',
 FILENAME = 'C:\BD\DISCO4\ParticionAVDiciembre2019.NDF'
 ) TO FILEGROUP AventasDiciembre2019;

 ALTER DATABASE ALMACEN
ADD FILE 
(
 NAME = 'ParticionAV2020.NDF',
 FILENAME = 'C:\BD\DISCO4\ParticionAV2020.NDF'
 ) TO FILEGROUP Aventas2020;

-- CREAR FUNCION DE PARTICION
drop partition function F_ParicionarAño;
CREATE PARTITION FUNCTION F_ParicionarAño(date)
AS RANGE Right FOR VALUES ('20190105','20190205','20190305','20190405','20190505','20190605','20190705','20190805'
,'20190905','20191005','20191105','20191205')
go
-- CREAR ESQUEMA DE PARTICION
CREATE PARTITION SCHEME EsquemaPorAnio
AS PARTITION F_ParicionarAño
TO (AventasEnero2019,AventasFebrero2019,AventasMarzo2019,AventasAbril2019,AventasMayo2019,AventasJunio2019
,AventasJulio2019,AventasAgosto2019,AventasSeptiembre2019,AventasOctubre2019,AventasNoviembre2019,
AventasDiciembre2019,Aventas2020);


/*Crear la tabala a particionar*/
drop table VENTASPart;
create table VENTASPart
(
	ID_VTAS INT primary key nonclustered,
	fecha_vta date,
	id_cajero int,
	importe_vta money,
	TOT_PROD INT,
	IMP_DESCUENTOS MONEY,
	IMP_IVA money
)
go

-- CREANDO EL INDICE CLUSTEREADO POR EL CAMPO 
-- DE LA PARTICIÓN Y ASIGNAMOS EL ESQUEMA DE PARTICION
CREATE CLUSTERED INDEX IDX_VentFe
ON VENTASPart (fecha_vta)
ON EsquemaPorAnio(fecha_vta);
-- CON ESTO YA PARTICIONAMOS LA TABLA

-- COPIAR LOS DATOS CON INSERT-SELECT
INSERT INTO VENTASPart  
SELECT * FROM VENTAS
GO

--Comprobar
select count(*) from VENTASPart;

/*Eliminar tabla y renombrar*/
DROP TABLE VENTAS;

EXEC sp_rename 'VENTASPart', 'VENTAS';

/*Volver a colocar llaves foraneas y primarias*/

ALTER TABLE CAJEROS ADD CONSTRAINT FK_VENTAS_CAJERO 
FOREIGN KEY (ID_CAJERO) REFERENCES CAJEROS(ID_CAJERO)

ALTER TABLE DETALLE_VENTA ADD CONSTRAINT FK_det_VENt
FOREIGN KEY (id_venta) REFERENCES VENTAS(ID_VTAS)
