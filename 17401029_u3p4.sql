--Autor: Erick Octavio Nolasco Machuca
--Practica: 4

--1.Crear una base de datos llamada BDAHORCADO--------------------------------------------

Create database BDAHORCADO
on primary
(
	Name = 'BDAHORCADO.MDF',
	FileName= 'C:\BD\BDAHORCADO.MDF'
)
Log on
(
	Name = 'AHORCADO.LDF',
	FileName= 'C:\BD\AHORCADO.LDF'
)
Go

--2. Crear un inicio de sesi�n sqluser
create login sqluser
with password='1234'
go

--3. Crear schema schemasqluser
use BDAHORCADO
go

create schema schemasqluser
go

--4.---4.Crear un usuario con el mismo nombre y as�gnale el login
-- poni�ndole un esquema por default llamado �schemasqluser�

create user sqluser
for login sqluser;

Alter user sqluser
with Default_Schema=schemasqluser;

--5.Darle los privilegios al usuario con roles de bases de datos:
--db_ddladmin
--db_datawriter
--db_datareader

exec sp_addrolemember db_ddladmin,sqluser;
exec sp_addrolemember db_datawriter,sqluser;
exec sp_addrolemember db_datareader,sqluser;


--------------------------Otro usuario--------------------------------
--6. Inicio de sesi�n con el usuario creado

--7. 7. Crea las tablas con llave primaria autoincremental, pero con
/*una proyecci�n de relacionarlas (como si fuera un juego de
ahorcado el que se almacenar� en la bd) y pon al menos dos
esquemas y las tablas estar distribuidas entre los esquemas y
aplica los constraints de fk que necesites.*/
use BDAHORCADO;

create schema Usuario;

create table Palabras (
	idPalabra int Primary key identity (1,1),
	Palabra varchar(30),
	Dificultad varchar(20),
)

create table usuario.Jugadores (
	idJugador int primary key identity(1,1),
	Nickname varchar(20)
)

Create table Juego (
	idJuego int primary key identity(1,1),
	idPalabra int,
	idJugador int,
	Puntaje smallint
)

alter table Juego
add constraint FK_Juego_Palabras
foreign key (idPalabra) references Palabras(idPalabra)
go

alter table Juego
add constraint FK_Juego_Jugadores
foreign key (idJugador) references usuario.Jugadores(idJugador)
go

--8.-----
select * from INFORMATION_SCHEMA.TABLES

--9.Insertar datos en las tablas
insert into Palabras values ('Camion','Facil'),
('Television','Facil'),
('Espina Dorsal','Experto'),
('Pararingutirimicuaro','Experto'),
('Jamaica','Medio'),
('Fotografia','Medio');

insert into usuario.Jugadores values
('UranousCougar'),
('Macarrone'),
('DearDevil'),
('Paulimotrix'),
('RompoponPon'),
('BadBunny');

insert into Juego values
(1,1,10),
(1,2,6),
(2,4,8),
(5,3,9),
(3,6,10),
(4,5,7);

select J.Nickname, P.Palabra , JU.Puntaje, P.Dificultad from Palabras as P
inner join Juego JU on (JU.idPalabra = P.idPalabra) inner join Usuario.Jugadores J on (J.idJugador = JU.idJugador)