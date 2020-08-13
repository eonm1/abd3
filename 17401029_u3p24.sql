/*
	Nombre: Erick Octavio Nolasco Machuca
	Practica: 22
	Fecha: 3 de abril

*/

/*1. DISEÑE UNA BASE DE DATOS PARA ALMACENAR LAS RECETAS
DE TODO EL MUNDO Y TODAS LAS ESPECIALEDADES (AL MENOS
DEBE TENER 5 TABLAS)*/

Create database Recetas_Mundo
On primary
(
Name= 'Recetas_Mundo.MDF',
FileName='C:\BD\Particiones\Recetas_Mundo.MDF'
)
log on
(
Name= 'Recetas_Mundo.LDF',
FileName='C:\BD\Particiones\Recetas_Mundo.LDF'
)
GO

use Recetas_Mundo
go
Create table Chef
(
Chef_Id int identity(1,1) primary key,
Chef_Nombre varchar(100),
Chef_Restaurant varchar(100),
Chef_Edad int
)
GO

Create table Ingrediente
(
Ing_Id int identity(1,1) primary key,
Ing_Descripcion varchar(50)
)
GO

Create table Categorias
(
Clave_Cat varchar(5) primary key not null,
Categoria_N varchar(60)
)
GO
Create table Receta
(
RecetaID int identity(1,1) Primary key nonclustered,
Receta_NOmbre varchar(50),
Chef_Id int references Chef(Chef_Id),
Clave_Cat varchar(5) references Categorias(Clave_Cat),
Pais varchar(30),
Modo_Preparacion varchar(max)
)
GO

Create table Determinar_Ing
(
Det_Id int identity(1,1) primary key,
Rec_Id int references Receta(RecetaID),
Ing_ID int references Ingrediente(Ing_id),
Det_Cantidad int,
Det_Unidad varchar(15)
)
GO

/*Inserción de valores para hacer los grupos*/
Insert into Categorias values ('DES01','Desayuno'),
							  ('ETD02','Entrada'),
							  ('PTF03','Plato fuerte'),
							  ('PST04','Postre'),
							  ('FSEA5','Mariscos')
go

/*Crear los grupos*/
Alter database Recetas_Mundo
Add Filegroup CDesayuno
GO

Alter database Recetas_Mundo
Add Filegroup CEntrada
Go

Alter database Recetas_Mundo
Add Filegroup CPlatoFuerte
GO

Alter database Recetas_Mundo
Add Filegroup CPostre
GO

Alter database Recetas_Mundo
Add Filegroup CMariscos
GO

/*Asociar archivos*/
Alter database Recetas_Mundo
add file
(
Name='CDesayuno.NDF',
FileName='C:\BD\DISCO1\CDesalluno.NDF'
)
TO Filegroup CDesayuno;

Alter database Recetas_Mundo
add file
(
Name='CEntrada.NDF',
FileName='C:\BD\DISCO2\CEntrada.NDF'
)
TO Filegroup CEntrada;

Alter database Recetas_Mundo
add file
(
Name='CPlatoFuerte.NDF',
FileName='C:\BD\DISCO3\CPlatoFuerte.NDF'
)
TO Filegroup CPlatoFuerte;

Alter database Recetas_Mundo
add file
(
Name='CPostre.NDF',
FileName='C:\BD\DISCO4\CPostre.NDF'
)
TO Filegroup CPostre;

Alter database Recetas_Mundo
add file
(
Name='CMariscos.NDF',
FileName='C:\BD\DISCO1\CMariscos.NDF'
)
TO Filegroup CMariscos;

/*Funcion de particion*/
Create partition Function F_Particion_Categorias (varchar(5))
as range Left for
values ('EDT02','PTF03','PST04','FSEA5')
GO

/*Esquema de particion*/
Create Partition Scheme EsquemaCategoria
As Partition F_Particion_Categorias
TO (CDesayuno,CEntrada,CPlatoFuerte,CPostre,CMariscos)
GO

/*Clusterar el indice en el esquma*/
Create Nonclustered Index INDX_Categoria
On Receta(Clave_Cat)
On EsquemaCategoria(Clave_Cat)
GO


/*Comprobar los datos*/
SELECT * FROM [Receta]
WHERE $partition.F_Particion_Categorias (Clave_Cat)=1
GO 

SELECT * FROM [Receta]
WHERE $partition.F_Particion_Categorias (Clave_Cat)=2
GO 

SELECT * FROM [Receta]
WHERE $partition.F_Particion_Categorias (Clave_Cat)=3
GO 

SELECT * FROM [Receta]
WHERE $partition.F_Particion_Categorias (Clave_Cat)=4
GO 