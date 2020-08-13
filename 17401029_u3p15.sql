/*
	AUTOR: Erick Octavio Nolasco Machuca
	Practica: 15
	No.Control: 17401029

*/

/*EN NORTHWIN:
Hacer al menos tres consultas forzando la utilización de un índice.*/
use Northwind
go

/*Antes de forzar indice*/
select * from Ventas.Orders
where EmployeeID between 1 and 7
go
/*Despues de forzar*/
select * from VENTAS.Orders
WITH (INDEX(EmployeeID))
where Employeeid between 1 and 7

/*Para este caso parece ser mas rápido forzar el índice que no hacerlo, me sorprendió mucho porque crei que optaba por la mejor
alternativa de ejecución siempre pero parace ser que no*/
exec sp_helpindex 'Ventas.Products'

/*Antes de forzar indice*/
SELECT * from Ventas.Products where ProductName like 'C%'

/*Despues de forzar indice*/
Select * from Ventas.Products with(index(PK_Products)) where ProductName like 'C%'

/*En esta consulta no parece haber diferencias en cuestiones de tiempo pero a lo mejor porque son pocos valores,
sin embargo si se ejecutan con diferente indice por defecto y forzado*/

exec sp_helpindex 'Personas.Customers'
/*Antes de ejectuar indice*/
select * from Personas.Customers where ContactTitle = 'Owner'
/*Despues de ejecutar indice*/
SELECT * from Personas.Customers with (index(Region)) where ContactTitle = 'Owner'

/*Aunque por diferencia de tiempo no se ve una gran diferencia, parece que la consulta con indice obligatorio
consume mas recursos ya que necesita de recuperar los datos de distinta forma, esto puede tenre sentido debido a que 
el indice utilizado forzosamente para la consulta no es el adecuado para la misma pero lo quize hacer asi para evaluar la practica*/



