use andrew;

-- Creacion de la tabla
create table provisional (
	id smallint(5) unsigned not null auto_increment,
    firstName varchar(45) not null,
    lastName varchar(45) null,
    lastUpdate timestamp not null default current_timestamp on update current_timestamp,
    primary key (id)
);

-- Insertar una fila indicando las columnas especificas
insert into provisional (firstName, lastName, lastUpdate)
values ('Andres1', 'Vallejo1', '2022-06-26');-- id por defecto se autoincrementa
insert into provisional (firstName, lastName)
values ('Andres2', 'Vallejo2');-- Fecha por defecto
insert into provisional (firstName)
values ('Andres3');-- LastName en null, y fecha por defecto
insert into provisional (lastName)
values ('Vallejo4');-- Error, debe incluir firstName porque no puede ser nulo y no tiene valor por defecto

-- Insertar una fila sin indicar columnas, los valores deben ser 4 (en este caso) y tener el orden adecuado
insert into provisional-- Error porque son 4 columnas y la primera columna debe ser numerica 
values ('Felipe', 'Aristizabal', '2022-06-27');
insert into provisional-- id tomara el valor por defecto, apellido y fecha tambien pueden ser default
values (default, 'Felipe', 'Aristizabal', '2022-06-27');

-- Insertar varias filas en una sola instruccion
insert into provisional (firstName, lastName, lastUpdate)
values 	('Andres11', 'Vallejo11', '2022-06-26'),
		('Andres12', 'Vallejo12', '2022-06-27'),
        ('Andres13', 'Vallejo13', '2022-06-28');

-- Insertar valores seleccionados haciendo una subconsulta (Se insertara el departamento en firstName y
-- la capital en lastName de los departamentos que empiezan por A
insert into provisional (firstName, lastName)
select Departamento, Capital from dep_col where Departamento like 'A%';

-- Actualizar una unica celda (fila, columna)
update provisional set firstName='Pipe' where id=3;

-- Actualizar varias celdas en una sola fila
update provisional set firstName='Pipe', lastName='Vallaristi' where id=4;

-- Actualizar una o varias celdas en varias filas
update provisional set firstName='PiPe', lastName='VallAristi' where id in (5,6,7);
update provisional set firstName='PiPe', lastUpdate='2022-05-10' where id in (5,7);

-- Para que funcione hay que deshabilitar safemode, por defecto el where debe 
-- hacer referencia a una columna marcada como key
update provisional set lastName='Valle' where firstName='PiPe';

-- No se puede actualizar ni borrar una tabla que esta siendo selecionada
update provisional set lastName='Valle' where id in (select id from provisional where firstName='PiPe');-- Error
update provisional set lastName='V_A' where id in (select * from (select id from provisional where firstName='PiPe') as t);

-- Borrar elementos de la tabla (para todos los casos funciona similar al update con una estructura similar al select)
delete from provisional where id=4;
delete from provisional where id in (5,6,7);
delete from provisional where firstName='PiPe';

-- Borrar todo el contenido de la tabla (hay que deshabilitar safemode)
delete from provisional;

-- Borra toda la tabla
drop table provisional;
