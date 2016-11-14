/*
  -- PROCEDIMENTOS ARMAZENADOS OU ROUTINES (INGLES)
  -- SÃO EXECUTADOS NO SERVIDOR E PODE CONTER INSTRUÇÕES SQLS LONGAS QUE PODEM SER CHAMADAS
  -- COM O COMANDO "CALL"
*/
drop procedure if exists db_loja.sp_detalhe_produto;
-- define um novo delimitador para não confundir com o delimitador padrão do mysql
DELIMITER $$   
create procedure db_loja.sp_detalhe_produto( cod long ) 
BEGIN
       select p.*
       from db_loja.produto as p 
       where codigo = cod ;
END$$
-- REDEFINE PARA O DELIMITADOR PADRÃO.
DELIMITER ;

call db_loja.sp_detalhe_produto(10);

/*
  -- FUNÇÃO 
  
*/
drop function if exists calcular_total;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` 
FUNCTION `calcular_total`(qtde double, valor double) RETURNS double
BEGIN

RETURN qtde * valor;

END$$

DELIMITER ;

select calcular_total(5,  20.00) as valor;


/*
  TRIGGERS (GATILHOS)
*/
drop table if exists venda;
create table venda (
   codigo int not null auto_increment,
   descricao varchar(50) not null,
   qtde double default 1.0,
   valor_unitario double default 0.00,
   valor_total double default 0.00,
   primary key (codigo) );

drop trigger if exists tr_calc_valor_ao_inserir;   
CREATE TRIGGER tr_calc_valor_ao_inserir BEFORE INSERT 
ON venda
for each ROW
set NEW.valor_total = NEW.valor_unitario * NEW.qtde;

insert into venda (descricao, valor_unitario, qtde) 
                        values ("coca cola 2 litros", 7.20, 3.0),
                               ("cerveja skol 300ml", 4.20,5),
							   ("Self service", 42.90, 0.560 );
                               
select * from venda;                               
