--Autor: Erick Octavio Nolasco Machuca
--Fecha: 10 de marzo 2020
USE master;

Create database SIITEC
On primary
(
	Name='SIITEC.MDF',
	Filename='C:\BD\SIITEC.MDF'
)
log on
(
	Name='SIITEC.LDF',
	Filename='C:\BD\SIITEC.LDF'
)
GO

use SIITEC;
GO
Create Schema ALUMNOS
GO
Create Schema RECHUM
GO
Create Schema ESCOLARES
GO
Create Schema MAESTROS
GO
Create Schema UVP
GO

Select * from sys.schemas;


--Tarea: Crear 3 tablas con 4 campos en cada esquema Create table NOmEsqu.Tabala ()
---------Crear tablas de esquema ALUMNOS---------------------
create table ALUMNOS.Alumno 
(
	NoControl varchar(8) primary key,
	Nombre varchar(50),
	Apellidos varchar(50),
	Carrera varchar(30),
	Semestre smallint
)
go
Create table ALUMNOS.Materia
(
	IdMateria varchar(10) primary key,
	Nombre varchar(30),
	Creditos smallint,
	Carrera varchar(30)
)
go
Create table ALUMNOS.Horario
(
	NoControl Varchar(8) primary key,
	IdMateria varchar(10),
	Hora time,
	Profesor varchar(60),
	Aula varchar(10)
)
Go
-------------------Crear tablas de esquema ESCOLARES--------------------------------------
Create table ESCOLARES.Alumno
(
	NoControl varchar(8) primary key,
	Nombre varchar(20),
	Apellidos varchar(50),
	Carrera varchar (30),
	Semestre smallint
)
go
Create table ESCOLARES.Materia
(
	IdMateria varchar(8) primary key,
	Nombre varchar(30),
	Creditos smallint,
	IdCarrera varchar(10)
)
go
Create table ESCOLARES.Carrera
(
	IdCarrera varchar(10) primary key,
	Nombre varchar(10),
	CreditosTotal smallint,
	Departamento varchar(10)
)
go
-----------------Crear tablas de esquema Maestros------------------------------------------------------------
Create Table MAESTROS.Profesor
(
	IdProfesor varchar(10) primary key,
	Nombre varchar(30),
	Apellidos varchar(50),
	Departamento varchar(30),
)
go
Create table MAESTROS.Materias
(
	IdMateria varchar(10) primary key,
	Nombre varchar(30),
	Creditos int,
	Carrera varchar(30)
)
go
Create table MAESTROS.Horario
(
	IdProfesor varchar(10),
	IdMateria varchar(10),
	Hora time,
	Grupo varchar(5)
)
go
--------------------------Tablas de el esquema RECHUM----------------------------------------------------
Create table RECHUM.Trabajadores
(
	IdTrabajador varchar(10) primary key,
	Nombre varchar(30),
	Apellidos varchar(50),
	Cargo varchar(20),
)
Go
Create table RECHUM.Capacitaciones
(
	IdCapacitacion varchar(10) primary key,
	Horas smallint,
	FechaInicio date,
	FechaFin date,
)
go
Create table RECHUM.Pagos
(
	IdMaestros money,
	Total money,
	Impuestos money,
	Concepto varchar(30)
)
go
--------------------------Tablas de el esquema UVP-------------------------------------------------------
Create table UVP.Salones
(
	IdSalon varchar(10) primary key,
	Capacidad smallint,
	Uso varchar(200),
	Ubicacion varchar (30)
)
go
Create table UVP.Eventos
(
	IdEvento varchar(10) primary key,
	Nombre varchar(30),
	IdSalon varchar(10),
	Descripcion varchar(255),
	Fecha date,
	hora time
)
go
Create table UVP.CursoIngles
(
	IdCurso varchar(30) primary key,
	Nombre varchar(30),
	IdSalon varchar(10),
	Descripcion varchar(255),
	Hora Time
)
go
--Investigar y escribir en el cuaderno los roles predefinidos de los usuarios en base de datos y servidor
