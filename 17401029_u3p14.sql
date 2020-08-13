/*
	AUTOR: Erick Octavio Nolasco Machuca
	Practica: 14
	No.Control: 17401029

*/

use Northwind
go

/*Checa los indices de la tabla ORDERS y ORDERDETAILS*/
exec sp_helpindex 'Ventas.Orders'
EXEC sp_helpindex 'Ventas.Order Details'

/*Checa el porcentaje de fragmentacion de uno de los indices de ORDERS y reorganizalo
	Luego checa uno de ORDER DETAILS y recontruyelo
*/
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

ALTER index PK_Orders on Ventas.Orders
reorganize
go

/*Order Details*/

ALTER INDEX ProductsOrder_Details ON Ventas.[Order Details]
REBUILD WITH
(FILLFACTOR = 80,
SORT_IN_TEMPDB =ON,
STATISTICS_NORECOMPUTE = ON );
GO

/*QUERIA PROBAR OTRO INDICE ASI QUE LO HICE CON OTRO DE ORDES para entender mejor, es que aun no estoy muy seguro como funcionan*/
ALTER INDEX ShipPostalCode ON Ventas.Orders
REBUILD WITH
(FILLFACTOR = 80,
SORT_IN_TEMPDB =ON,
STATISTICS_NORECOMPUTE = ON );
GO