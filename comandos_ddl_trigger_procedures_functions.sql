DELIMITER //
create procedure ProcShowAlunos(in aluno_id int)
begin
  select * from ALUNOS where id = aluno_id;
end //
DELIMITER ;

DELIMITER ((
create procedure ProcShowAlunos()
begin
  select * from ALUNOS;
end ((
DELIMITER ;

DELIMITER ((
create procedure ProcShowAlunoByName(in vnome varchar(50))
begin
  select * from ALUNOS where nome like concat(vnome,'%');
end ((
DELIMITER ;

select * from ALUNOS  where nome like 'wander%';

drop procedure ProcShowAlunos;
call ProcShowAlunos();
call ProcShowAlunoByName('V');

/* Criar uma tabela para registrar os acessos */
create table ACESSOS(id int not null primary key auto_increment, aluno_id int, data_hora_acesso timestamp);

/* criar uma trigger que automaticamente insira o acesso do usuário na tabela acesso */
DELIMITER %%
create trigger TRG_REG_ACESSO AFTER INSERT ON HTC_DDS_03.ALUNOS
FOR EACH ROW
BEGIN
   INSERT INTO HTC_DDS_03.ACESSOS ( aluno_id ) 
   values ( new.id );
END %%
DELIMITER ;

/* Testar se trigger funciona */
INSERT INTO ALUNOS(nome,turma_id) VALUES ('JOVENTINA DA SILVA',1);
INSERT INTO ALUNOS(nome,turma_id) VALUES ('LEITÃO DA SILVA',1);
INSERT INTO ALUNOS(nome,turma_id) VALUES ('JOSÉ RATO',1);

/* verificar se a trigger adicionou a entrada na tabela ACESSOS */
SELECT * FROM HTC_DDS_03.ACESSOS;
SELECT ACESSOS.ID, ALUNOS.NOME, ACESSOS.data_hora_acesso FROM
HTC_DDS_03.ALUNOS, HTC_DDS_03.ACESSOS
WHERE ALUNOS.id = ACESSOS.aluno_id ;


/* criar table para registro de logs */
CREATE TABLE LOGS (
 id int not null primary key auto_increment, 
 aluno_id int not null, 
 operacao varchar(25), 
 data_hora TIMESTAMP );
 
/* exemplo ON UPDATE */
/* criar uma trigger que registra log de alterações de uma determinada tabela */
DELIMITER %%
create trigger TRG_LOG_DELETE AFTER DELETE  ON HTC_DDS_03.ALUNOS
FOR EACH ROW
BEGIN
   INSERT INTO HTC_DDS_03.LOGS ( aluno_id,  operacao)
   VALUES(old.id, 'exclusão' );
END %%
DELIMITER ;

/* Testar trigger para deleção */
DELETE FROM HTC_DDS_03.ALUNOS WHERE id=18;
/* testar para ver se deletou */
SELECT * FROM HTC_DDS_03.ALUNOS;
SELECT * FROM HTC_DDS_03.LOGS;


/* Criar trigger para registro de ATUALIZAÇÕES */
DELIMITER %%
create trigger TRG_LOG_UPDATE AFTER UPDATE ON HTC_DDS_03.ALUNOS
FOR EACH ROW
BEGIN
   INSERT INTO HTC_DDS_03.LOGS ( aluno_id,  operacao)
   VALUES(old.id, 'alteração' );
END %%
DELIMITER ;

/* testar trigger */
UPDATE ALUNOS SET nome = 'JUAREZ MACHADO DA SILVA' where id = 19;
SELECT * FROM HTC_DDS_03.LOGS;

ALTER TABLE HTC_DDS_03.LOGS modify operacao varchar(255);
/* Criar trigger para registro de ATUALIZAÇÕES */

DELIMITER %%
create trigger TRG_LOG_UPDATE2 AFTER UPDATE ON HTC_DDS_03.ALUNOS
FOR EACH ROW
BEGIN
   INSERT INTO HTC_DDS_03.LOGS ( aluno_id,  operacao)
   VALUES(old.id, concat('alteração: de ', old.nome , ' para ', new.nome ) );
END %%
DELIMITER ;

UPDATE ALUNOS SET nome = 'JUAREZ SOUZA' where id = 19;
SELECT * FROM HTC_DDS_03.LOGS;

/* CRIAR FUNÇÃO */
DELIMITER $$
CREATE FUNCTION TO_UPPER(TEXTO VARCHAR(255))
RETURNS VARCHAR(255) 
BEGIN
   RETURN ucase(TEXTO);
END $$
DELIMITER ;

/* CRIAR FUNÇÃO */
DELIMITER $$
CREATE FUNCTION TO_DATA_BRASIL(DATA DATETIME)
RETURNS VARCHAR(255) 
BEGIN
   RETURN date_format(DATA,'%d-%m-%Y');
END $$
DELIMITER ;
/*Testar a função */
select TO_UPPER('wanderlei');

select TO_DATA_BRASIL('2019-09-02 00:00:00');

/*select date_format('2019-11-01 00:00:00','%d-%m-%Y');*/

/*EXIBIR OS PROCEDIMENTOS ARMAZENADOS */
/* SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES;*/


select COUNT(*) from ALUNOS;