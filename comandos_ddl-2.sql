# comentário, versões antigas... evitar!
/* 
  comentário em várias linhas..alter
  outra linha de comentário.
*/
-- Comentário em uma linha...

-- COMANDOS DDL
-- -------------
-- criar um banco de dados.. 
CREATE DATABASE HTC_DDS_03;
-- excluir o banco de dados.
DROP DATABASE HTC_DDS_03;
-- criar um banco se ele não existir.
CREATE DATABASE IF NOT EXISTS HTC_DDS_03;
-- excluir o banco de dados caso ele exista
DROP DATABASE IF EXISTS HTC_DDS_03;

-- criando uma relação/tabela no banco
-- tbTurma(id inteiro, nome caracteres)
-- use HTC_DDS_03;
-- cria a table TURMA no banco de dados
-- TURMA caso não exista.
create table if not exists `HTC_DDS_03`.`TURMA`(
  id int not null primary key auto_increment,
  nome varchar(20) not null
);
/*
tbAlunos(id inteiro nao nulo, 
         nome caracteres(50) nao nulo,
		 turma_id referencia TURMA(id) );
*/
create table if not exists ALUNOS(
   id int not null primary key auto_increment,
   nome varchar(50) not null,
   turma_id int not null,
   foreign key ( turma_id ) references TURMA(id)
);

create table if not exists HTC_DDS_03.DISCIPLINA(
   id int not null primary key auto_increment,
   nome varchar(25) not null
);

alter table HTC_DDS_03.DISCIPLINA
add column data_cadastro timestamp;
alter table HTC_DDS_03.DISCIPLINA
D

create table if not exists HTC_DDS_03.TURMA_DISCIPLINA(
   turma_id int not null,
   disciplina_id int not null
);

alter table HTC_DDS_03.TURMA_DISCIPLINA
add constraint fk_turma_id 
    foreign key(turma_id) 
    references HTC_DDS_03.TURMA(ID),
add constraint fk_disciplina_id 
    foreign key(disciplina_id) 
    references HTC_DDS_03.DISCIPLINA(id);

 CREATE TABLE IF NOT EXISTS PROFESSOR(id int not null primary key auto_increment, nome varchar(40) not null );
CREATE TABLE IF NOT EXISTS PROFESSOR_DISCIPLINA( professor_id int not null, disciplina_id int not null, foreign key(professor_id) references PROFESSOR(id), foreign key(disciplina_id) references DISCIPLINA(id) );


