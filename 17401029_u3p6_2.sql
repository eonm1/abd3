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

