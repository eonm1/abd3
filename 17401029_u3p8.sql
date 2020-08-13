--Alumno: Erick Octavio Nolasco Machuca
--Practica: 8
--No. Control: 17401029

/*Crea la base de datos ABD2020*/
Create database ABD2020
On Primary
(
Name='ABD2020.MDF',
FileName='C:\BD\ABD2020.MDF'
)
log on
(
Name='ABD2020.LDF',
FileName='C:\BD\ABD2020.LDF'
)
Go

use ABD2020 
go
/*Crear una tabla llamada ALUMNOS_ABD SIN LLAVE PRIMARIA*/
create table ALUMNOS_ABD
(
	ALU_ID INT,
	ALU_NOMBRE VARCHAR(20),
	ALU_APEPAT VARCHAR(20),
	ALU_APEMAT VARCHAR(20),
	ALU_EDAD SMALLINT
)
go

/* A) CREA UN ÍNDICE CLUSTEREADO CON EL ID*/
Create clustered index OBJ_ID on ALUMNOS_ABD (ALU_ID)
go

/*B) CREA UN INDICE NOCLUSTEREADO CON EL SEGUNDO CAMPO*/
create nonclustered index OBJ_Sgundo on ALUMNOS_ABD (ALU_NOMBRE)
go

/*C) CREA UN INDICE NOCLUSTEREADO CON LA COMBINACION DE LOS
CAMPOS QUE FORMAN EL NOMBRE COMPLETO.*/

create nonclustered index OBJ_NombreC on ALUMNOS_ABD (ALU_NOMBRE,ALU_APEPAT,ALU_APEMAT)
go

/*Inserción de algunos datos para probar los indices*/
insert into ALUMNOS_ABD values (1,'Erick','Nolasco','Machuca',20),
(2,'Paulina','Nova','Ramirez',20),
(3,'Ramon','Estrada','Torres',21),
(4,'Aldair','Rangel','Cantabrana',21),
(5,'Juan','Saguan','Calle',25),
(6,'Cristiano','Ronaldo','Ramirez',29),
(7,'Messi','Nolasco','Perez',27),
(8,'Victoria','Machuca','Robles',65)
go

/*HAGA CONSULTAS CON WHERE Y ORDER BY . Y MUESTRE EL PLAN DE EJECUCIÓN*/

Select * from ALUMNOS_ABD where ALU_EDAD = 20 order by ALU_NOMBRE
GO
SELECT * from ALUMNOS_ABD where ALU_EDAD>22 order by ALU_APEPAT
GO
select * from ALUMNOS_ABD where ALU_APEMAT LIKE 'R%'
go