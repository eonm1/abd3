/*
	Autor: Erick Octavio Nolasco Machuca
	Practica: 10
	No. Cotrol: 17401029
*/

use SUPERHEROES
go

/*1. CREA LOS SIGUIENTES INDICES PARA LA TABLA HEROES
 UN INDICE CLUSTEREADO POR EL APODO
 UN INDICE NO CLUSTEREADO PARA EL CAMPO DEL ID
 UN INIDCE NO CLUSTEREADO PARA EL CAMPO DE NOMBRE DEL
HEROE*/

Create clustered index OBJ_APODO on heroes (APODO_HER)
go

create nonclustered index OBJ_ID on heroes(ID_HEROE)
GO

create nonclustered index OBJ_Nombre on heroes(NOMBRE_HER)
go

/*1. CREA INDICES PARA LA TABLA ENEMIGOS*/

CREATE NONCLUSTERED index OBJ_NOMBREC on Villano(NOMBRE_VIL, APODO_VIL)
go

/*Este indice lo cree porque muchas de las ocaciones queremos ver como se llama el enemigo y su apodo,
algo asi como lo que sucede con los nombre completo sucede con este campo entonces cree un indice con esto para que 
fuese mas rapido recuperar el dato*/

CREATE Clustered index OBJ_Edad on Villano(EDAD_VIL)
go

/*Esto lo cree para las busquedas por edad porque tambien son muy recurrentes sobre todo para probar cosas*/

Create nonclustered index OBJ_VillanoAlianza on Villano(ID_Villanos,Id_alianza)
go
/*Para hacer mas rapidas las consultas que requieran de una relacion con el villano esto agiliza mucho ya que es recurrente solicitar
que villano pertenece a una cierta alianza*/

/*2. CREA INDICES PARA LA TABLA LUGARES DE DEFENSA.*/

create clustered index OBJ_Lugar on lugaresDefensa(Id_Lugar)
go
/*Este indice se crea por defecto cuando se añade una llave primaria pero en caso de que no es importante añadirlo ya que muchas
de las busquedas se realizan por medio de el id*/

create nonclustered index OBJ_NOMBRE ON lugaresDefensa(NOMBRE)
go
/*AL igual que en la tabla anterior buscar por nombre es muy recurrente, y mas si se trata de un lugar donde no se tiene que combinar
con algun otro campo entonces considero que es muy útil añadir este tipo de indices, ademas de que tiene pocos campos esta tabla 
y los otros no son muy solicitados que digamos*/