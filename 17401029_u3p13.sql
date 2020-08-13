/*
	Autor: Erick Octavio Nolasco Machuca
	Practica: 13
	No.Control: 17401029
*/

/*1. CHECA LOS INDICES QUE TIENE CADA TABLA*/
exec sp_helpindex 'alianza'
exec sp_helpindex 'detEnemigoHeroe'
exec sp_helpindex 'detPoderHeroe'
exec sp_helpindex 'detPoderVillano'
exec sp_helpindex 'heroes'
exec sp_helpindex 'lugaresDefensa'
exec sp_helpindex 'poder'
exec sp_helpindex 'villano'

/*2. CHECA EL PORCENTAJE DE FRAMENTACION DE UNO DE LOS INDICES DE LA
TABLA DE HEROES*/
SELECT  OBJECT_NAME(IDX.OBJECT_ID) AS Table_Name, 
IDX.name AS Index_Name, 
IDXPS.index_type_desc AS Index_Type, 
IDXPS.avg_fragmentation_in_percent  Fragmentation_Percentage
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) IDXPS 
INNER JOIN sys.indexes IDX  ON IDX.object_id = IDXPS.object_id 
AND IDX.index_id = IDXPS.index_id 
ORDER BY Fragmentation_Percentage DESC

/*Reorganizalo*/
ALTER INDEX OBJ_Nombre
ON heroes
REORGANIZE;
GO

/*4. CHECA EL PORCENTAJE DE FRAGMENTACIÓN DE UNO DE LOS INDICES DE LA
TABLA DE ENEMIGOS
5. RECONSTRUYELO.*/

ALTER INDEX obj_VillanoAlianza ON villano
REBUILD;
GO
ALTER INDEX OBJ_VillanoAlianza ON villano
REBUILD WITH
(FILLFACTOR = 80,
SORT_IN_TEMPDB =ON,
STATISTICS_NORECOMPUTE = ON);
GO