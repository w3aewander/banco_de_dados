select * from produto;
select * from loja;
select * from vendedor;
select * from venda;
alter table venda add qtde double;

DELIMITER //

DELIMITER;
use db_loja;
select * from venda v;
update venda set qtde = '2.0';


create view view_vendas as 
select v.cod_vendedor, p.descricao , v.qtde, p.valor_unitario,
       v.qtde * p.valor_unitario as total
from venda as v,produto as p
where v.cod_produto=p.codigo;

select * from view_vendas;
select  format(sum(qtde*valor_unitario),2) from view_vendas
where cod_vendedor = 1;

delimiter //
create procedure calcularComissaoVendedor(IN cod_vendor int, OUT comissao double)
begin

  DECLARE C CURSOR FOR
      SELECT SUM(v.qtde * p.valor_unitario ) * 0.04 
      FROM venda as v,produto as p
	  WHERE v.cod_produto=p.codigo AND v.cod_vendor = cod_vendor;
      
  open C;
     FETCH C INTO comissao ;
  close C;
      
end //
delimiter ;

SET RESULT AS DOUBLE DEFAULT '0.0';

CALL calcularComissaoVendedor(1, RESULT);
