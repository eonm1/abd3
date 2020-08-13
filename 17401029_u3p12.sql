/*
	Autor: Erick Octavio Nolasco Machuca
	Practica: 12
	No.Control:17401029

*/

USE ALUMNOS2020
go

/*CHECA QUE PORCENTAJE DE FRAGMENTACIÓN TIENE CADA INDICE E INDICA
SI ES NECESARIO RECONTRUIRLO O REORGANIZARLO.*/

SELECT OBJECT_NAME(IDX.OBJECT_ID) AS Table_Name,
IDX.name AS Index_Name,
IDXPS.index_type_desc AS Index_Type,
IDXPS.avg_fragmentation_in_percent AS
Fragmentation_Percentage
FROM sys.dm_db_index_physical_stats(DB_ID(),
NULL, NULL, NULL, NULL) IDXPS
INNER JOIN sys.indexes IDX
ON IDX.object_id = IDXPS.object_id
AND IDX.index_id = IDXPS.index_id
ORDER BY Fragmentation_Percentage DESC

/*Por el momento no es necesario ni reconstruirlo ni reorganizarlo*/

/*Inserta 1000 carrearas*/
INSERT INTO CARRERA VALUES ('P1','Prueba1')
go 1000

Delete from CARRERA where CAR_ID>=60 AND CAR_ID<=80

/*Inserta otras 1000 carreras*/
insert into CARRERA VALUES ('P2','Prueba2')
go 1000

/*Borra de la carrera 100 a la 200*/
DELETE FROM CARRERA where CAR_ID>=100 and CAR_ID<=200

/*Repetir 10 veces y checar el porcentaje de fragmentacion*/

/*Darle mantenimiento*/
exec sp_helpindex 'CARRERA'
go

alter index PK__CARRERA__7D16AF24D8F1671B on CARRERA reorganize
go

ALTER INDEX ALL ON CARRERA
REBUILD WITH
(FILLFACTOR = 80,
SORT_IN_TEMPDB =ON,
STATISTICS_NORECOMPUTE = ON);
GO