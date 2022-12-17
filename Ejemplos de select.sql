select 'miPrimerVAlor';
select 'miPrimerVAlor' as algunValor;
select 1+1;
select now();
select curdate();
select current_time();
select pi();
select mod(47,7);

-- Seleccionando de una tabla
select * from andrew.ciudades;
use andrew;
select * from ciudades;
use conference_demo;

-- Organizando lo seleccionado
select * from ciudades order by Ciudad;
select * from ciudades order by Habitantes;
select * from ciudades order by Habitantes desc;
select * from ciudades order by 4;

-- Obtener solo columnas selecionadas 
select Ciudad from ciudades order by Habitantes;
select Ciudad, Habitantes from ciudades order by Habitantes;
select Ciudad, Departamento from ciudades order by Habitantes;

-- Seleccionar aplicando filtros
select Ciudad, Departamento from ciudades where Habitantes>2000 order by Habitantes;
select * from ciudades where Habitantes>=2000 order by Habitantes;
select Ciudad from ciudades where Ciudad='Medellin';
select * from ciudades where (Habitantes>500 && Habitantes<3000) order by Departamento;
select * from ciudades where (Habitantes>500 && Habitantes<3000) order by Departamento, Ciudad;
select * from ciudades where ciudad<'Medellin' and Habitantes<1000;
select * from ciudades where Departamento in ('Antioquia','Caldas');
select * from ciudades where idCiudades between 2 and 5;

-- Secionar todos los registros cuyo departamento es el mismo de Medellin
select * from ciudades where Departamento in (select Departamento from ciudades where Ciudad='Medellin');

-- Selecionar todos los registros con menos habitantes que Medellin
select * from ciudades where Habitantes < (select Habitantes from ciudades where Ciudad in ('Medellin'));

-- Usar un filtro con una condicion falsa para devolver un set vacio (sirve para ver columnas!? en shell no)
select * from ciudades where 1=2;

-- Usando LIKE y patrones para filtrar resultados
select * from ciudades where ciudad like 'M%';
select * from ciudades where ciudad like 'M__e';-- Empieza por M dos letras cualquiera y una e, solo 4 letras
select * from ciudades where ciudad like 'M__e%';-- Empieza por M dos letras cualquiera y una e y mas letras
select * from ciudades where ciudad like 'M%e%';-- Empieza por M y tiene una e en cualquier parte

-- Trabajando con NULL
select * from ciudades where Habitantes IS NULL;
select * from ciudades where Habitantes IS NOT NULL;

-- Usando alias para cambiar nombre a columnas y aplicando operaciones aritmeticas
select Ciudad as Capital, Habitantes/1000 as MillonHab from ciudades order by Habitantes;
select Ciudad, Habitantes/1000 as MillonHab, (Habitantes-2000)*2 as Prueba from ciudades order by Habitantes;
select Ciudad, Habitantes/1000 M_Hab, round(Habitantes/1000) Round, round(Habitantes/1000,1) Round2, ceiling(Habitantes/1000) Ceiling, floor(Habitantes/1000) Floor from ciudades;

-- Usando alias y operaciones con cadenas de caracteres
select concat(Ciudad,', ',Departamento) Ciudad_y_Departamento, concat(left(Ciudad,3),', ',left(Departamento,2)) Iniciales from ciudades;

-- Operando sobre el formato de las fechas
select date_format(curdate(), '%m/%d/%y') as fecha1, date_format(curdate(), '%d-%m-%Y') as fecha2;
select date_format(curtime(), '%b %Y') as fecha1, date_format(curtime(), '%d %b %Y, hora %T') as fecha2;
select date_format(curdate(), get_format(date,'eur')) as fecha1, date_format(curdate(),  get_format(date,'iso')) as fecha2;
select dayofweek(curdate()) DiaSemana, monthname(curdate()) Mes, dayofyear(curdate()) NoDia;

-- Evitar valores repetidos
select distinct Departamento from ciudades;

-- Limitar la cantidad de resultados (aconsejable usar junto con ORDER BY)
select * from dep_col limit 10;
select * from dep_col limit 9, 5;
