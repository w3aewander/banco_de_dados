/*
  AULA DIA 17/11/2016
  TURMA B
*/
drop database if exists db_escola;
create database db_escola;
use db_escola;

-- criar as tabelas que serão utilizadas
create table if not exists horarios (
    codigo int not null auto_increment,
    horario time,
    primary key(codigo)
);

create table if not exists cursos (
   codigo int not null auto_increment,
   nome varchar(50) not null,
   cod_horario int not null,
   primary key(codigo),
   constraint fk_cod_horario foreign key(cod_horario)
   references horarios(codigo)
);

create table if not exists alunos(
    codigo int not null auto_increment,
    nome varchar(50) not null,
    cod_curso int not null,
    primary key (codigo),
    constraint fk_cod_curso foreign key (cod_curso) 
	references cursos(codigo)
);

-- populando as tabelas
insert into horarios (horario) 
	   values ('18:30:00'),
              ('20:30:00'),
			  ('07:00:00'),
              ('09:00:00'),
              ('11:00:00');
              
insert into cursos (nome, cod_horario) 
            values ( "Gastronomia",5),
                   ( "Ciências Contábeis",3),  
                   ( "Cabelereiro",1),
				   ( "Educação Física",4),
                   ( "Informática", 2),
                   ( "Enfermagem",5),
                   ( "Segurança do Trabalho",2);
                   
insert into alunos (nome,cod_curso) 
       values ( "Manuela",4), 
              ("Thyffany",5), 
			  ("Laudicéia",3),
              ("Gustavo", 2),
			  ("Weslon", 1);

-- inner join
select a.codigo Código, a.nome Aluno, c.nome Curso, h.horario Horário
from alunos a
inner join cursos c
on a.cod_curso = c.codigo
inner join horarios h
on c.cod_horario = h.codigo; 

-- right join
select a.codigo Código, a.nome Aluno, c.nome Curso, h.horario Horário
from alunos a
right join cursos c
on a.cod_curso = c.codigo
right join horarios h
on c.cod_horario = h.codigo; 

-- left join
select a.codigo Código, a.nome Aluno, c.nome Curso, h.horario Horário
from alunos a
left join cursos c
on a.cod_curso = c.codigo
inner join horarios h
on c.cod_horario = h.codigo; 


-- select * from horarios;
-- select * from cursos;
-- select * from alunos;
