---Autor: Erick Octavio Nolasco Machuca
---Practica: 5
---Descripcion: Creacion de la base de datos guarderia

----1.- Crear una base de datos uarderia con las tablas solicitadas
Create database Guarderia
On Primary
(
Name='Guarderia.MDF',
FileName='C:\BD\Guarderia.MDF'
)
log on
(
Name='Guarderia.LDF',
FileName='C:\BD\Guarderia.LDF'
)
Go

Use Guarderia
Go
--Creacion de las tablas ----------------------------------------------------------------------------------
Create table Padre_Tutor
(
id_Padre int identity(1,1) primary key,
Nombre varchar(50),
Apellido_P varchar(30),
Appelido_M varchar(30),
telefono varchar(10),
Domicilio varchar(100),
)
Go

create table Alumnos
(
id_Alumno int identity(1,1) primary key,
Nombre_A varchar(30),
Apellido_P varchar(30),
Apellido_M varchar(30),
Edad int,
sexo char(1),
id_Padre int references Padre_Tutor(id_Padre)
)
Go

Create table Encargado
(
id_Encargado int identity(1,1) primary key,
Nombre_E varchar(30),
Apellidos varchar(30),
Fecha_Nac date,
Horario varchar(15)
)
Go

Create table Sala
(
id_Sala int identity(1,1) primary key,
Nombre_Sala varchar(50),
id_Encargado int references Encargado(id_Encargado)
)
Go

Create table Asistencia
(
id_Asistencia int identity(1,1) primary key,
Fecha_Asistencia date,
id_Alumno int references Alumnos(id_Alumno),
id_Encargado int references Encargado(id_Encargado)
)
Go

Create table Reportes_Incidencias
(
id_Incidencia int identity(1,1) primary key,
Tipo varchar(50),
Id_Alumno int references Alumnos(id_Alumno),
id_Encargado int references Encargado(id_Encargado),
Descripcion varchar(50)
)
Go

Create table Expediente_Clinico
(
id_Expediente_C int identity(1,1) primary key,
id_Alumno int references Alumnos(id_Alumno),
Nombre_Doc varchar(50),
Ultima_Visita date
)

Create table Expediente_Pedagogico
(
id_Expediente_P int identity(1,1) primary key,
id_Alumno int references Alumnos(id_ALumno),
Observacion varchar(200),
Cita date
)
Go

Create table Nutricion
(
id int identity(1,1) primary key,
id_Alumno int references Alumnos(id_Alumno),
Peso_KG int,
Estatura_mts int,
Estado varchar(20)
)
GO

Create table Menu
(
id_Menu int identity(1,1) primary key,
Dia varchar(10),
Platillo varchar(50),
Postre varchar(50),
Bebida varchar(50),
id_Sala int references Sala(id_Sala)
)
Go

Create table Estudios_Socioeconomicos
(
id_Estudio int identity(1,1) primary key,
id_Tutor int references Padre_Tutor(id_Padre),
Empleo varchar(50),
Ingreso_Mensual money
)
Go

Create table Terapia_Psicologica
(
id_Terapia int identity(1,1) primary key,
Nombre_Terapia varchar(50),
Tipo varchar(20),
id_Encargado int references Encargado(id_Encargado),
id_Alumno int references Alumnos(id_Alumno)
)
Go

----2.- Crear los esquemas necesarios para organizar la base de datos


Create Schema Miembros
Go

Create Schema Informacion
Go

Create Schema Alimentacion
Go

Create Schema Estancias
Go

---3.- Cambiamos las tablas a su Esquema Correcto
Alter Schema Miembros
transfer dbo.Encargado
Go

Alter Schema Miembros
transfer dbo.Alumnos
Go

Alter Schema Miembros
transfer dbo.Padre_Tutor

Alter Schema Informacion
transfer dbo.Asistencia
Go

Alter Schema Informacion
transfer dbo.Reportes_Incidencias
Go

Alter Schema Informacion
transfer dbo.Estudios_Socioeconomicos
Go

Alter Schema Informacion
transfer dbo.Expediente_Clinico
Go

Alter Schema Informacion 
transfer dbo.Expediente_Pedagogico
Go

Alter Schema Informacion 
transfer dbo.Terapia_Psicologica
Go

Alter Schema Estancias
transfer dbo.Sala
Go

Alter Schema Alimentacion
transfer dbo.Menu
Go

alter Schema Alimentacion
transfer dbo.Nutricion
Go

---4.- Crea un Esquema que se llame Aportacion_Alumno
Create Schema Aportaciones_Alumno
Go

---5.- Crea dos tablas en el nuevo esquema 


Create table Aportaciones_Alumno.Conceptos
(
id_Concepto int identity(1,1) primary key,
nombre_C varchar(50),
monto money,
Fecha_limite date
)
Go


Create table Aportaciones_Alumno.Pagos_Realizados
(
id_Pago int identity(1,1) primary key,
id_Concepto int references Aportaciones_Alumno.Conceptos(id_Concepto),
Fecha_pago date,
id_Alumno int references Miembros.Alumnos(id_Alumno)
)
Go

----6.- Inserta datos en cada tabla
--NOTA: SE DEBE DE TENER CUIDADO DE LAS INSERCIONES PORQUE SI NO LA LLAVE FORANEA VA A EVITAR QUE SE AGREGUEN ALGUNAAS
-- NO ESTAN EN ORDEN PORQUE LAS HICE CONFORME A LAS TABALAS SORRY MAESTRA :( igual no son tan dificiles de chechar

insert into Alimentacion.Menu values('Lunes','Milanesa','Pay de manzana','Agua de Limon',1),
                                    ('Martes','Ceciche','avena','Jugo de naranja',2),
									('Miercoles','Pollo','Pastel de fresa','Agua de jamaica',1),
									('Jueves','Frijoles','Pay de queso','Jugo de fresa',1),
									('Viernes','Cabiar','Arroz con leche','Agua de tamarindo',2);

insert into Alimentacion.Nutricion values(1,56,152,'En Peso'),
										(2,80,150,'Sobre peso');

insert into Aportaciones_Alumno.Conceptos values('Inscripcion',1000,'2020-03-12'),
                                                ('Material didactico',350,'2020-03-14');

insert into Aportaciones_Alumno.Pagos_Realizados values (1,'2020-03-11',1),
                                                        (2,'2020-03-13',1);

insert into Estancias.Sala values('Area de juegos',3),
                                 ('Auditorio',4);
insert into Informacion.Asistencia values ('2020-03-18',1,3),
                                          ('2020-03-18',2,3);

insert into Informacion.Estudios_Socioeconomicos values (1,'Maestro',3600),
                                                        (2,'Doctor General',5000);

insert into Informacion.Expediente_CLinico values (1,'Rafael Miramotes','2020-02-20'),
                                                  (2,'Salvador Rodriguez','2019-12-30');

insert into Informacion.Expediente_Pedagogico values (1,'Violencia moderada','2020-12-03'),
                                                     (2,'Timides','2020-04-04');

insert into Informacion.Reportes_Incidencias values ('Pelea',1,3,'Pelea porun accidente con la comida');

insert into Informacion.Terapia_Psicologica values ('No a la violencia','Individual',3,1),
                                                   ('Como hacer amigos','Grupal',4,2);

insert into Miembros.Alumnos values ('Carlos','Lopez','Casillas',6,'M',1),
                                    ('Regina','Sanchez','Briseño',5,'F',2);

insert into Miembros.Encargado values ('Sergio','Mora Urias','1990-03-30','Matutino'),
                                      ('Selene','Perez Ramirez','1991-04-23','Matutinno');

insert into Miembros.Padre_Tutor values ('Antonio','Solorsano','Vega','3241025469','Insurgentes #1024'),
                                        ('Mariana','Juarez','Meza','3112564789','Col. Rodeo #156 pte.');


---7.- Crear consultas con inner join para visualizar datos.
---1.- Muestra el nombre del almumno, edad, peso, nombre del padre o tutor, oficio e ingreso economico mensual.

Select MA.Nombre_A,Ma.Edad,AN.Peso_KG,MP.Nombre as [Nombre Padre], IES.Empleo,IES.Ingreso_Mensual
from Miembros.Alumnos as MA
inner join Alimentacion.Nutricion  AN on (MA.id_Alumno=AN.id_alumno)
inner join Miembros.Padre_Tutor MP on (MP.id_Padre=MA.id_Padre)
inner join Informacion.Estudios_Socioeconomicos IES on (IES.id_Tutor =MP.id_Padre)
Go

---2.- Muestra los alumnos que han tenidouna incidncia y el encargado que los atendio
Select MA.Nombre_A,MA.Apellido_p,MA.Apellido_m, MA.Edad,II.Tipo as Tipo_Incidencia,II.Descripcion,ME.Nombre_E,ME.Apellidos,ME.Horario
from Miembros.Alumnos as MA
inner join Informacion.Reportes_Incidencias II on (II.Id_Alumno=MA.id_Alumno)
inner join Miembros.Encargado ME on (II.id_Encargado=ME.id_Encargado)
Go

---3.- Muestra el menu de los dias, la sala en la cual se presentara y el nombre completo junto alhorario del Encargado

Select AM.Dia,AM.Platillo,AM.Postre,AM.Bebida,AM.id_sala,ES.Nombre_Sala,ME.Nombre_E,ME.Apellidos,ME.Horario
from Alimentacion.Menu AM
inner join Estancias.Sala  ES on (ES.id_Sala=AM.id_Sala)
inner join Miembros.Encargado ME on (ME.id_Encargado = ES.id_Encargado)
Go








