--Autor: Erick Octavio Nolasco Machuca
--Practica: 4_2


--6. Inicio de sesión con el usuario creado

--7. 7. Crea las tablas con llave primaria autoincremental, pero con
/*una proyección de relacionarlas (como si fuera un juego de
ahorcado el que se almacenará en la bd) y pon al menos dos
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