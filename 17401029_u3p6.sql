--Autor: Erick Octavio Nolasco Machuca 
-- Practica: 6

--1. EL ITTEPIC NECESITA UNA BD LLAMADA LLAMADA ITT2018, CON TRES
--ESQUEMAS (ESCOLARES, RECHUMANOS, VINCULACION-POSGRADO)
Create database ITT2018
On Primary (
NAME='ITT2018.MDF',
FILENAME='C:\BD\ITT2018.MDF'
)
LOG ON(
NAME='ITT2018.LDF',
FILENAME='C:\BD\ITT2018.LDF'
)
go

USE ITT2018
go
--Creaci�n de los equemas

CREATE SCHEMA ESCOLARES
GO

CREATE SCHEMA RECHUMANOS
GO

CREATE SCHEMA VINCULACION_POSGRADO
GO
--2. CREA UN TRES ROLES:
--EL PRIMERO: SOLO CONSULTAR EN LA BASE DE DATOS
--EL SEGUNDO: PERMISO DE ESCRITURA Y LECTURA SOBRE EL ESQUEMA ESCOLARES.
--EL TERCERO : CREAR , ALTERAR Y DROPEAR OBJETOS DE LA BD.


--El primero:
CREATE ROLE Primero;
EXEC sp_addrolemember db_datareader, Primero

--El segundo: 
CREATE ROLE Segundo;
   
EXEC sp_addrolemember db_datawriter, Segundo
EXEC sp_addrolemember DB_DATAREADER, Segundo

--El tercero: 
CREATE ROLE Tercero;

EXEC sp_addrolemember db_ddladmin, Tercero


--3. . CREA 6 USUARIOS: DOS PERTENECER�N AL ROL 1 , CUATRO AL ROL 2 Y EL RESTO AL ROL 3
--creacion de logins
create login Primero1 with password = '1234'
create login Segundo1 with password = '1234'
create login Tercero1 with password = '1234'
create login Cuarto with password = '1234'
create login Quinto with password = '1234'
create login Sexto with password = '1234'
--creacion de usuarios
use ITT2018;

CREATE USER Primero FOR LOGIN Primero1
CREATE USER Segundo1 FOR LOGIN Segundo1
CREATE USER Tercero1 FOR LOGIN Tercero1
CREATE USER Cuarto FOR LOGIN Cuarto
CREATE USER Quinto FOR LOGIN Quinto
CREATE USER Sexto FOR LOGIN Sexto


ALTER ROLE Primero
ADD MEMBER  Primero1
GO

ALTER ROLE Segundo
ADD MEMBER SEGUNDO1
GO

ALTER ROLE Segundo
ADD MEMBER TERCERO1
GO

ALTER ROLE Segundo
ADD MEMBER CUARTO
GO

ALTER ROLE Segundo
ADD MEMBER QUINTO
GO

ALTER ROLE Tercero
ADD MEMBER SEXTO
GO

--4. CONECTATE CON UN USUARIO Y CREA LAS TABLAS NECESARIAS PARA LA BD.
--OTRO QUERY
--5. PONGALES DIFERENTES ESQUEMAS POR DEFAULT A CADA USUARIO.

alter user PRIMERO1 
with default_schema = ESCOLARES

alter user SEGUNDO1
with default_schema = ESCOLARES

alter user TERCERO1
with default_schema = RECHUMANOS

alter user CUARTO
with default_schema = RECHUMANOS

alter user QUINTO
with default_schema = VINCULACION_POSGRADO

alter user SEXTO
with default_schema = VINCULACION_POSGRADO

--6. CONECTATE CON OTRO USUARIO QUE INSERTE, MODIQUE Y BORRE AL MENOS DOS REGISTROS EN DISTINTAS TABLAS.

insert into EMPLEADOS values
(1,'Erick Nolasco','Jefe','Es el que manda a todos asi de f�cil'),
(2,'Paulina Nova','Secretaria','Le hace los mandados al jefe (si lee esto no se crea maestra, es mi amiga)'),
(3,'Anonio Torres','Jefe de seguridad','Manda a todos los de seguridad'),
(4,'Ketto Kaponni','Profesor','Imparte la materia avanzada de rimas')

update EMPLEADOS
set Nombre = 'Erick Nolasco Machuca'
where ID = 1

update EMPLEADOS
set Nombre = 'Paulina Nova Ramirez'
where ID = 2

delete from Empleados where ID = 4
delete from Empleados where ID_Empleado = 1

insert into posgrado values 
('Facil'),
('Medio'),
('Avanzado'),
('Experto')

update Posgrado
set DESCRIPCION = 'Posgrado facilito para terminar pronto'
where ID_pos = 1

update Posgrado
set DESCRIPCION = 'Posgrado medio para que si le eches ganas pero no tantas'
where ID_pos = 2

delete from Posgrado where ID_pos = 3
delete from Posgrado where ID_pos = 4

--7. CONECTATE CON UN USUARIO DEL ROL 3 Y CONSULTA LOS REGISTROS DE CADA TABLA

ALTER SCHEMA Escolares TRANSFER dbo.Escolares;
ALTER SCHEMA RECHUMANOS TRANSFER dbo.Empleados;
ALTER SCHEMA VINCULACION_POSGRADO TRANSFER dbo.Posgrado;

select * from VINCULACION_POSGRADO.POSGRADO

select * from ESCOLARES.ESCOLARES 

select * from RECHUMANOS.EMPLEADOS


--8. CONSULTA CUANTOS USUARIOS HAY EN CADA ROL
SELECT DP1.name AS ROL,
isnull (DP2.name, 'No users') AS USUARIOS
FROM sys.database_role_members AS DRM
RIGHT OUTER JOIN sys.database_principals AS DP1
ON DRM.role_principal_id = DP1.principal_id LEFT OUTER JOIN sys.database_principals AS DP2 ON DRM.member_principal_id = DP2.principal_id WHERE DP1.type = 'R'
ORDER BY DP1.name;
GO

/*
La base de datos quedo con 3 distintos equemas, 3 tablas y seis usuarios que realizan distintas funciones, No todas las tablas tienen
inserciones y algunas fueron editadas pero si se puede apreciar como estan distribuidas, no todo el codigo se eject� desde un mismo usuario
*/


--Erick Octavio Nolasco Machuca
--Con el usuario sexto creacion de tablas
use ITT2018;

CREATE TABLE EMPLEADOS(
ID int PRIMARY KEY,
Nombre VARCHAR(100),
Puesto varchar(100),
Descripcion varchar(100)
)
GO

CREATE TABLE Posgrado(
ID_POS INT IDENTITY(1,1) PRIMARY KEY,
DESCRIPCION VARCHAR(100)
)
GO

CREATE TABLE Escolares(
ID_ESC INT IDENTITY(1,1) PRIMARY KEY,
DESCRIPCION VARCHAR(100)
)
GO
