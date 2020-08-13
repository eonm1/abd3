/*
--Autor: Erick Octavio Nolasco Machuca
Practica: 9
No. Control: 17401029
*/

use Northwind
go

/*VERIFIQUE CUANTOS INDICE CUANTOS TIENE CADA, INDICANDO EL NOMBRE Y PORQUE CAMPOS ESTAN
HECHOS CADA INDICE.*/

exec sp_helpindex 'Personas.CustomerCustomerDemo'
exec sp_helpindex 'Personas.Customers'
exec sp_helpindex 'Personas.Employees'
exec sp_helpindex 'Personas.Shippers'
exec sp_helpindex 'Tienda.Categories'
exec sp_helpindex 'Tienda.CustomerDemographics'
exec sp_helpindex 'Tienda.EmployeeTerritories'
exec sp_helpindex 'Tienda.Region'
exec sp_helpindex 'Tienda.Territories'
exec sp_helpindex 'Ventas.Order Details'
exec sp_helpindex 'Ventas.Orders'
exec sp_helpindex 'Ventas.Products'
exec sp_helpindex 'Ventas.Suppliers'

/*2. SUGIERA SI LES FALTA ALGUN INDICE A LA TABLA, DE
QUE TIPO Y PORQUE CAMPOS.*/

/*
	TABLA: Personas.Customers
	Sugerencia: nonclustered en Contact Title y otro nonclustered en Country

	TABLA:Personas.Customers
	Sugerencia: nonclustered en Title
	nonclustered en TitleOfCortesy
	nonclustered Combinado FirstName y LastName
	clustered en ReportsTo

	TABLA: Tienda.Territories
	Sugerencia: clustered combinado TerritoryID y RegionID

	Tabla: Ventas.Order Details
	Sugerencia: Clustered en UnitPrice

	Tabla: Ventas.Orders
	Sugerencia: nonclustered en ShipRegion
	nonclustered en ShipCountry

	Tabla: Ventas.Products
	Sugerencia:
	1 clustered combinado de ProductID y UnitInStock

*/