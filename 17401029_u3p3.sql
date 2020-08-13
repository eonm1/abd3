--Erick Octavio Nolasco Machuca
-- Practica #3

--1.---------------------------------------------------------------
Create database Desarrollo_Personal
On primary
(
	Name='Desarrollo_Personal.MDF',
	Filename='C:\BD\Desarrollo_Personal.MDF'
)
log on
(
	Name='Desarrollo_Personal.LDF',
	Filename='C:\BD\Desarrollo_Personal.LDF'
)
GO

create login Usuario1
with password='1234'
go


create user Usuario1
for login Usuario1
go

--2.-----------------------------------------------------------------
use Desarrollo_Personal
go

create role Primero;
create role Segundo;
Create role Tercero;

exec sp_addrolemember db_securityadmin,Primero
go
exec sp_addrolemember db_accessadmin,Primero
go
exec sp_addrolemember db_ddladmin,Primero
go
exec sp_addrolemember db_datareader,Primero
go


use master;
exec sp_addsrvrolemember Usuario1,securityadmin
go

use Desarrollo_Personal
go

exec sp_addrolemember db_datawriter,Segundo
go
exec sp_addrolemember db_datareader,Segundo
go


exec sp_addrolemember db_datareader,Tercero
go

exec sp_addrolemember Primero,Usuario1
go

--6.-----Generar Diagrama
--7.------ La base de datos qued� con 2 tablas por schema y con 3 schemas, Las tablas 
-- del tercer esquema no contienen registros porque fueron eliminados pero las deas tienen registros (1-2) y la operaciones
-- Fueron echas de distintos usuarios de base de datos

---------Otros usuarios-----------------
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

-----Mas usuarios--------------------
use Desarrollo_Personal;

insert into Capacitacion.Cursos values(1,'Mejorar Ense�anza','2020/03/01','2020/03/10',22);
insert into Capacitacion.Cursos values(2,'Ser tolerante','2020/05/06','2020/05/07',33);
insert into Capacitacion.Cursos values(3,'El don del saber','2020/03/01','2020/03/10',22);

update Capacitacion.Cursos set Capacidad=8 where idCurso=1;
update Capacitacion.Cursos set FechaFin='2020/05/22' where FechaInicio='2020/05/06';

delete from Capacitacion.Cursos where idCurso=3;

insert into Capacitacion.Diplomados values(1,'La mejor forma de aprender','2020/03/01','Este diplomado te abrira los ojos del conocimiento','2020/03/10',22)

insert into Apoyo.Manuales VALUES (1,'Manual de SqlServer','Este manual contiene todo lo necesario para iniciar con el aprendizaje de
sql server 2019 en lo basico','SQLSERVER')

insert into Apoyo.Talleres values(1,'Taller1',GETDATE(),'Todo lo necesario para Taller1','2020/04/18',25,'Nada')
insert into Apoyo.Talleres values(2,'Taller2',GETDATE(),'Todo lo necesario para Taller2','2020/04/20',15,'Muchas ganas')

