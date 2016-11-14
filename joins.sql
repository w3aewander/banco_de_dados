/*
   JOIN , INNER JOIN, RIGHT JOIN, LEFT JOIN, FULL OUTER JOIN
   Professor: Wanderlei Silva do Carmo
*/

-- DROPAR O BANCO SE EXISTIR
drop database if exists db_pratica_join;

-- CRIAR O BANCO DE DADOS
create database db_pratica_join;

-- selecionar o banco de dados
use db_pratica_join;

-- CRIAR A TABELA CURSOS
create table cursos (
   codigo int not null auto_increment,
   nome varchar(50) not null,
   primary key (codigo)
   
);

-- CRIAR A TABELA ALUNOS
create table alunos (

    codigo int not null auto_increment,
    nome varchar(50) not null,
	cod_curso int not null,
    primary key(codigo),
    constraint fk_aluno_curso foreign key (cod_curso) references cursos(codigo) 
);

-- POPULANDO AS TABELAS
-- cursos
insert into cursos values ( 1, "CURSO A"),( 2, "CURSO B"), ( 3, "CURSO C"), ( 4, "CURSO D");

-- alunos
insert into alunos (nome,cod_curso) values ("VIVIANE", 3),("ALEXSANDER", 2),("JEFFERSON", 1);

-- EXIBINDO OS DADOS
select * from alunos;

-- EXIBINDO CURSOS
select * from cursos;

-- EXEMPLO DE INNER JOIN  (A CLAUSULA "AS" PODE SER SUPRIMIDA)
-- primeira forma
select alunos.codigo as Codigo, alunos.nome as Nome, cursos.nome Curso
from alunos, cursos
where alunos.cod_curso = cursos.codigo;

 -- segunda forma
 select a.codigo as Codigo, a.nome as Nome, c.nome as Curso from alunos a, cursos c 
 where a.cod_curso = c.codigo;
 
 -- terceira forma (que recomendo)
 select a.codigo codigo, a.nome Nome, c.nome as Curso 
 from alunos a
 inner join cursos c
 on a.cod_curso = c.codigo;
 
 
 -- RIGHT JOIN
 select a.codigo codigo, a.nome Nome, c.nome as Curso 
 from alunos a
 right join cursos c
 on a.cod_curso = c.codigo;
 
 -- LEFT JOIN
  select a.codigo codigo, a.nome Nome, c.nome as Curso 
 from alunos a
 left  join cursos c
 on a.cod_curso = c.codigo;

 -- OUTER JOIN (A CLAUSULA OUTER PODE SER SUPRIMIDA TANTO PARA RIGHT JOIN QUANTO PARA LEFT JOIN )
 select a.codigo codigo, a.nome Nome, c.nome as Curso 
 from alunos a
 RIGHT OUTER join  cursos c
 on a.cod_curso = c.codigo;

-- simular um full join
 -- simular um full outer join
 -- union all
 select a.codigo,a.nome,c.nome  from alunos a 
 left join cursos c
 on a.cod_curso = c.codigo
 union all
 select a.codigo,a.nome, c.nome from alunos a
 right  join cursos c
 on a.cod_curso = c.codigo;
 
 -- union distinct
 select a.codigo,a.nome,c.nome  from alunos a 
 left join cursos c
 on a.cod_curso = c.codigo
 union distinct
 select a.codigo,a.nome, c.nome from alunos a
 right  join cursos c
 on a.cod_curso = c.codigo;
 
 
 -- AO FINAL DO EXERCICIO DROP O BANCO
-- drop database db_pratica_join
