use Desarrollo_Personal;

insert into Capacitacion.Cursos values(1,'Mejorar Enseñanza','2020/03/01','2020/03/10',22);
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