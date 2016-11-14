/*
    SCRIPT PARA CRIAÇÃO DE UM BANCO DE DADOS PARA PRATICA DE EXERCICIOS COM 
    JOINS, ORDER BY, COUNT, SUM, AVG, GROUP BY, HAVING 
    Professor: Wanderlei Silva do Carmo
    Disciplina: Banco de Dados
*/

drop database if exists db_turma;
create database db_turma;
use db_turma;

-- tabela alunos
create table alunos (

    codigo int not null auto_increment,
    nome varchar(50) not  null,
    data_nasc date not null,
    time varchar(30),
    primary key(codigo)
);


-- tabela detalhe_alunos

create table detalhe_alunos (

     codigo_aluno int not null,
     celular varchar(15),
     email varchar(50),
     facebook varchar(50),
     constraint fk_det_aluno_codigo foreign key (codigo_aluno) references alunos(codigo)
     
);

-- popular a tabela alunos
insert into alunos (nome, data_nasc, time ) 
       values ("ABRAAO","1997-12-23","FLAMENGO"),("ALEXANDER","1998-01-11","VASCO"),("ELISA","1997-11-06","FLAMENGO"),("FRANK","1998-05-29","FLAMENGO"),
              ("GABRIELY","1999-03-10","FLUMINENSE"),("ITAMAR","1998-03-12","FLUMINENSE"),("JOAO MARCOS","1999-03-01","FLAMENGO"),
              ("JOAO P. TEIXEIRA","1999-01-11","VASCO"),("JOAO P. MUNIZ","1997-06-16","FLAMENGO"),("JOAO VICTOR","1997-04-07","PALMEIRAS"),
              ("MAURICIO","1997-09-09","PALMEIRAS"),("YOURI","1999-04-10","FLAMENGO");

-- exibir dados dos detalhes de alunos
select alunos.nome as Nome, 
       detalhe_alunos.celular as Celular,
       detalhe_alunos.email as Email, 
       detalhe_alunos.facebook as Facebook,
       alunos.time Time
from alunos,detalhe_alunos where alunos.codigo=detalhe_alunos.codigo_aluno;

-- exibir dados dos detalhes dos alunos usando inner join (o "as" pode ser suprimido)
select a.nome Nome, d.celular Celular, d.email Email, d.facebook Facebook, a.time Time
from alunos a inner join detalhe_alunos d
on a.codigo = d.codigo_aluno;

-- Mostrar a idade dos alunos
select nome,  year(now() ) - year(data_nasc) as idade from alunos;

--   Média de idades dos alunos  
select avg( year(now()) - year(data_nasc) ) as media_idades from alunos;

-- View para mostrar apenas os times dos alunos
create or replace view view_time_alunos as select nome,time from alunos;

-- Exibir os dados da view
select * from view_time_alunos;

-- Agrupar alunos pelo time 
select nome, time  from alunos group by nome, time order by time ; 

-- Agrupar alunos pelo ano de nascimento
select  nome as aluno, year(data_nascimento) as ano from alunos group by  ano;

-- Agrupar alunos pelo mes de nascimento
select  nome as aluno, mounth(data_nascimento) as mes from alunos group by  mes;

-- Agrupar apenas alunos que torcem para um time especifico
select count(*) as qtde, time from alunos group by time having time = "fluminense";

-- Exibir alunos agrupando pelos que torcem para um time especifico
select nome, time from alunos group by nome,time having time = "fluminense";
select nome, time from alunos group by nome,time having time in ("flamengo","fluminense");

