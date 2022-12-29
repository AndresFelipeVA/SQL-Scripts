-- Nombre y apellido de los odontologos que tienen turnos con sus respectivos turnos
SELECT o.Nombre, o.Apellido, T.Paciente_DNI from odontotogo o INNER JOIN turnos T ON o.Matricula=T.Odontotogo_Matricula;

-- Nombre y apellido de TODOS los odontologos con sus respectivos turnos (Puede haber null a la derecha)
SELECT o.Nombre, o.Apellido, T.Paciente_DNI from odontotogo o LEFT OUTER JOIN turnos T ON o.Matricula=T.Odontotogo_Matricula;

-- Nombre y apellido de los odontologos de TODOS los turnos (Puede haber null a la izquierda)
SELECT o.Nombre, o.Apellido, T.Paciente_DNI from odontotogo o RIGHT OUTER JOIN turnos T ON o.Matricula=T.Odontotogo_Matricula;

-- Tambien existe el FULL OUTER JOIN que en MySQL se simula con la union de la Left y Right
-- Y la SELF JOIN que es una JOIN normal pero sobre la misma tabla, util por ejemplo si en la misma tabla hay personas relacionadas entre si

-- Nombre de los odontologos con el nombre de sus respectivos pacientes (Osea nos interesa ver todos los turnos)
SELECT o.Nombre, p.Nombre
FROM turnos t
LEFT JOIN odontotogo o ON t.Odontotogo_Matricula = o.Matricula
LEFT JOIN paciente p ON t.Paciente_DNI = p.DNI;

-- Nombre de los odontologos que no tienen ningun turno (Osea nos interesa Odontologos sin relacion)
SELECT o.Nombre, p.Nombre
FROM odontotogo o
LEFT JOIN turnos t ON t.Odontotogo_Matricula = o.Matricula
LEFT JOIN paciente p ON t.Paciente_DNI = p.DNI
WHERE p.Nombre is null;

-- El anterior lo podemos simplificar ya que no necesitamos de la tabla paciente
SELECT o.Nombre
FROM odontotogo o
LEFT JOIN turnos t ON t.Odontotogo_Matricula = o.Matricula
WHERE t.Paciente_DNI is null;

-- Todos los turnos del odontologo de matricula 1
SELECT o.Nombre, p.Nombre
FROM turnos t
LEFT JOIN odontotogo o ON t.Odontotogo_Matricula = o.Matricula
LEFT JOIN paciente p ON t.Paciente_DNI = p.DNI
WHERE o.Matricula = 1;

-- EJEMPLOS SELF JOIN
create table Employee(
	EmployeeID int primary key,
	Name nvarchar(50),
	ManagerID int
);
insert into Employee (EmployeeID, Name, ManagerID)
values (1, 'Mike', 3),
 	   (2, 'David', 3),
	   (3, 'Roger', null),
	   (4, 'Marry', 2),
	   (5, 'Joseph', 2),
	   (7, 'Ben', 2);
-- Self inner join (Empleado con su respectivo jefe)
select e1.Name as EmployeeName, e2.Name as ManagerName
from Employee e1
inner join Employee e2
on e1.ManagerID = e2.EmployeeID;
-- Self outer join (Para que tambien aparezca Roger que no tiene jefe)
select e1.Name as EmployeeName, ifnull(e2.Name, 'Top Manager') as ManagerName
from Employee e1
left join Employee e2
on e1.ManagerID = e2.EmployeeID;

-- "Natural join" reemplaza el uso de "on t1.id = t2.id" por la palabra "natural"
-- y hara una union de las columnas con identico nombre
select t1.id as t1Id, t1.value1 as t1Value,
	   t2.id as t2ID, t2.value2 as t2Value
from table1 t1
natural join table2 t2; /*Natural Inner Join*/
select t1.id as t1Id, t1.value1 as t1Value,
	   t2.id as t2ID, t2.value2 as t2Value
from table1 t1
natural left join table2 t2; /*Natural left outer Join*/

-- Usando la palabra clave "using" es similar a una "Natural Join" pero mientras "natural"
-- tomara en cuenta todas las iguales "using" nos permite especificar las columnas con
-- identico nombre que queremos usar
select t1.id as t1Id, t1.value1 as t1Value,
	   t2.id as t2ID, t2.value2 as t2Value
from table1 t1
inner join table2 t2 using (id); /*Inner Join usando una columna de comparacion*/
select t1.id as t1Id, t1.value1 as t1Value,
	   t2.id as t2ID, t2.value2 as t2Value
from table1 t1
left join table2 t2 using (id, value); /*Left outer Join usando dos columnas de comparacion*/

-- "Union" y "Union all" nos permite unir el resultado de dos consultas, el primero sin resultados repetidos y el segundo con todo 
-- incluyendo repetidos, en ambos casos debe ser igual el numero de columnas
SELECT o.Nombre, o.Apellido, T.Paciente_DNI from odontotogo o LEFT OUTER JOIN turnos T ON o.Matricula=T.Odontotogo_Matricula
union /*Simullando full outer join*/
SELECT o.Nombre, o.Apellido, T.Paciente_DNI from odontotogo o RIGHT OUTER JOIN turnos T ON o.Matricula=T.Odontotogo_Matricula;

-- Mediante las subquery podemos usar el resultado de una consulta en otra
-- Ejem: subquery para obtener los pacientes del odontologo de nombre "Andres"
select p.Nombre, p.Apellido 
from paciente p 
where p.DNI 
in (
	select t.Paciente_DNI 
	from turnos t 
	where t.Odontotogo_Matricula
	in (
		select o.Matricula 
		from odontotogo o 
		where o.Nombre="Andres"
));

-- Esto tambien lo podriamos hacer con "join", para mi resulta mas claro con subquery, una ventaja con "join" es que
-- se puede mostrar columnas de cualquier tabla, con subquery solo de la tabla base (primer from)
select p.Nombre, p.Apellido 
from paciente p 
inner join turnos t on p.DNI = t.Paciente_DNI
inner join odontotogo o on t.Odontotogo_Matricula = o.Matricula /* Hasta aqui serian todos los pacientes con turno */
where o.Nombre="Andres"; /* y aca se filtran los que son con el odontologo "Andres"