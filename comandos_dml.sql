use HTC_DDS_03;

/* COMANDOS DML */
select * from ALUNOS;
insert into TURMA(nome) values('HTC_DDS_03');
select * from TURMA;
insert into ALUNOS(nome,turma_id) values('Wanderlei',1);
insert into ALUNOS(nome,turma_id) 
       values('Victor Henrique',1),
             ('Klayton',1),
             ('Igor Maurilio',1),
             ('Igor Pinheiro',1),
             ('Victor Corassa',1),
             ('Pablo',1);
select nome from ALUNOS order by nome asc;
select nome from ALUNOS order by nome desc;

select nome from ALUNOS where nome = 'Wanderlei';
select nome from ALUNOS where nome like 'v%';
select nome from ALUNOS where nome like '%corassa';
select nome from ALUNOS where nome like '%gor%';
select nome from ALUNOS 
			where nome 
            in ('Wanderlei','Igor Pinheiro');
select id,nome from ALUNOS 
			   where id = 2;
select id,nome from ALUNOS 
			   where id in (2,5);
select id,nome from ALUNOS 
       where id between 1 and 4;

/* JUNÇÃO ENTRE TABELAS */       
select a.nome as aluno, t.nome as turma 
from ALUNOS a 
inner join TURMA t 
on a.turma_id = t.id; 

/* Junção sem uso da palavra JOIN */
select a.nome `nome do aluno`, t.nome `nome da turma`
from ALUNOS a, TURMA t 
where a.turma_id = t.id;

/* inserção com timestamp */
insert into DISCIPLINA(nome)
       values('BANCO DE DADOS'),
			 ('MODELAGEM DE SISTEMAS');
select * from DISCIPLINA;

 



      