-- Nombre y apellido de los odontologos que tienen turnos con sus respectivos turnos
SELECT o.Nombre, o.Apellido, T.Paciente_DNI from odontotogo o INNER JOIN turnos T ON o.Matricula=T.Odontotogo_Matricula;

-- Nombre y apellido de TODOS los odontologos con sus respectivos turnos (Puede haber null a la derecha)
SELECT o.Nombre, o.Apellido, T.Paciente_DNI from odontotogo o LEFT OUTER JOIN turnos T ON o.Matricula=T.Odontotogo_Matricula;

-- Nombre y apellido de los odontologos de TODOS los turnos (Puede haber null a la izquierda)
SELECT o.Nombre, o.Apellido, T.Paciente_DNI from odontotogo o RIGHT OUTER JOIN turnos T ON o.Matricula=T.Odontotogo_Matricula;

-- Tambien existe el FULL OUTER JOIN que en MySQL se simula con la union de la Left y Right
-- Y la SELF JOIN que es una JOIN normal pero sobre la misma tabla, util por ejemplo si en la misma tabla hay personas relacionadas entre si