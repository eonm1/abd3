---4.-------------------------------------------------------------------------------
create login Usuario2
with password='1234'
go
create login Usuario3
with password='1234'
go

use Desarrollo_Personal;

Create user Usuario2
for login Usuario2;

exec sp_addrolemember Segundo,Usuario2
go

create user Usuario3
for login Usuario3;
go
exec sp_addrolemember Tercero,Usuario3;

go
---5.----------------------------------------------------
create schema Capacitacion
go
create schema Apoyo
go
create schema Externo
go

Alter user Usuario1
with Default_Schema=Capacitacion;
go
Alter user Usuario2
with Default_Schema=Apoyo
go
Alter user Usuario3
with Default_Schema=Externo
go

create table Capacitacion.Cursos
(
	idCurso int primary key,
	Nombre varchar(30),
	FechaInicio date,
	FechaFin date,
	Capacidad smallint
)
go

create table Capacitacion.Diplomados
(
	idDiplomado int primary key,
	Nombre varchar(30),
	FechaInicio date,
	descripcion varchar(255),
	FechaFin date,
	Capacidad smallint
)
go

create table Apoyo.Talleres
(
	idTaller int primary key,
	Nombre varchar(30),
	FechaInicio date,
	descripcion varchar(255),
	FechaFin date,
	Capacidad smallint,
	Materiales varchar(200)
)
go
create table Apoyo.Manuales
(
	idManual int primary key,
	Nombre varchar(30),
	descripcion varchar(255),
	Curso varchar(10)
)
go
Create table Externo.Instructores
(
	idInstructor int primary key,
	Nombre varchar(30),
	Curso varchar(10)
)
go
Create table Externo.Participantes
(
	idCurso int,
	idInstructor int,
)
go



