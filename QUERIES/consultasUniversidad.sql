SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno'  ORDER BY apellido1, apellido2, nombre;
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND telefono IS NULL; 
SELECT nombre, apellido1, apellido2 FROM persona where tipo = 'alumno' AND YEAR (fecha_nacimiento) = 1999;
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND RIGHT (nif,1) = 'K'; 
SELECT nombre FROM asignatura WHERE curso = 3 AND cuatrimestre = 1 AND id_grado = 7;
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN departamento ON profesor.id_departamento = departamento.id WHERE persona.tipo = 'profesor' ORDER BY persona.apellido1, persona.apellido2, persona.nombre;
SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin FROM alumno_se_matricula_asignatura LEFT JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id LEFT JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id LEFT JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id WHERE persona.nif = '26902806M';
select distinct departamento.nombre	from departamento inner join profesor on departamento.id = profesor.id_departamento inner join asignatura on profesor.id_profesor = asignatura.id_profesor inner join grado on asignatura.id_grado = grado.id where grado.id = 4;
select distinct persona.nombre, persona.apellido1, persona.apellido2 from persona inner join alumno_se_matricula_asignatura on persona.id = alumno_se_matricula_asignatura.id_alumno inner join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id where curso_escolar.anyo_inicio = 2018 and curso_escolar.anyo_fin = 2019 and persona.tipo = 'alumno';
#REENTREGA: LAS DOS CONSULTAS ANTERIORES (8 Y 9)

#-------------------------------------------------------------------------------------------------------

# Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN:

#Consulta 1 (REENTREGA: solo metemos a las personas de tipo profesor) :
SELECT departamento.nombre AS departamento, persona.apellido1, persona.apellido2, persona.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento RIGHT JOIN persona ON profesor.id_profesor = persona.id where persona.tipo = 'profesor'  order by departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre;

#Consulta 2:
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor WHERE profesor.id_departamento IS NULL AND persona.tipo = 'profesor';

#Consulta 3:
SELECT departamento.nombre AS nombreDepartamento FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento WHERE profesor.id_profesor IS NULL;

#Consulta 4:
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL AND persona.tipo = 'profesor';

#Consulta 5:
SELECT asignatura.nombre AS asignatura FROM asignatura LEFT JOIN profesor ON asignatura.id_profesor = profesor.id_profesor WHERE profesor.id_profesor IS NULL;

#Consulta 6(REENTREGA):
select distinct departamento.nombre from departamento left join profesor on departamento.id = profesor.id_departamento left join asignatura on profesor.id_profesor = asignatura.id_profesor where asignatura.id is null;


#---------------------------------------------------------------------------------------------------------------------------------------------
#Consultes resum:

#Consulta 1:
SELECT COUNT(nombre) FROM persona WHERE tipo = 'alumno';  

#Consulta 2:
SELECT COUNT(nombre) FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;     

#Consulta 3 pendiente.

#Consulta 4:
SELECT departamento.nombre AS Departamento, COUNT(persona.id) AS NumProfesores FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN persona ON profesor.id_profesor = persona.id GROUP BY departamento.nombre;

#Consulta 5:
SELECT grado.nombre AS grado, COUNT(asignatura.id) AS NumAsignaturas FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre ORDER BY NumAsignaturas DESC;

#Consulta 6 (aquí HAVING filtra los resultados que nos da la instrucción GROUP BY):
SELECT grado.nombre AS grado, COUNT(asignatura.id) AS numAsignaturas FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre HAVING numAsignaturas > 40 ;

#Consulta 7:
SELECT grado.nombre AS grado, asignatura.tipo AS tipoAsignatura, SUM(asignatura.creditos) AS totalCreditos FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre, asignatura.tipo;

#Consulta 8:
SELECT curso_escolar.anyo_inicio AS inicio, COUNT(alumno_se_matricula_asignatura.id_alumno) AS numAlumnos FROM curso_escolar LEFT JOIN alumno_se_matricula_asignatura ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar GROUP BY curso_escolar.anyo_inicio;

#Consulta 9 pendiente.

#Consulta 10:
SELECT * FROM persona WHERE tipo = 'alumno'  AND fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona);

#Consulta 11 (REENTREGA)
select persona.nombre, persona.apellido1, persona.apellido2
from persona
join profesor on persona.id = profesor.id_profesor
left join asignatura on profesor.id_profesor = asignatura.id_profesor
where persona.tipo = 'profesor' and asignatura.id is null;