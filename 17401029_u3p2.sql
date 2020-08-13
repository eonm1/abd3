--Erick Octavio Nolasco Machuca
-- Fecha: 10 de marzo de 2020
-- Practica: 2 Unidad: 3


--Crear un usuario con permisos de alterar, dropear, Crear

Create login Erick 
with password = 'werick'
go

USE SIITEC
go
Create user Erick
for login Erick
go

exec sp_addrolemember db_ddladmin, Erick
go

--Investigar Como asignar un esquema por default a un usuario y ponerle a este usuario el esquema
Alter user Erick
with Default_Schema=ALUMNOS;

--Transferir almenos dos tablas a diferentes esquemas

Alter schema ESCOLARES
Transfer ALUMNOS.Horario
go

Alter schema ALUMNOS
transfer RECHUM.Capacitaciones
go



Alter schema MAESTROS
Transfer ESCOLARES.Carrera
go

Alter Schema RECHUM
transfer UVP.Eventos
GO

Alter schema UVP
transfer RECHUM.Trabajadores
go