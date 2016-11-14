use db_loja;

/* Quantos produtos cadastrados */
select count(*) as QTDE_PRODUTOS from produto;
/* Quantas lojas cadastradas */
select count(*) as QTDE_LOJAS from loja;
/* Quantos vendedores cadastrados */
select count(*) as QTDE_VENDEDORES from vendedor;
/* Total de produtos vendidos */
select count(*) as "Total Produtos Vendidos" from venda;

/* Valor total em produtos vendidos por vendedor*/
select v.cod_produto, p.descricao as descrição, 
	count(p.valor_unitario) as "Qtde Vendida",
       sum(p.valor_unitario) as "Valor Total",
	   vd.nome as "Vendedor"
       from produto as p
inner join venda v 
on p.codigo = v.cod_produto
inner join vendedor as vd
on v.cod_vendedor = vd.codigo
group by v.cod_produto, vd.nome;


/* Valor total em produtos vendidos por loja*/
select v.cod_produto, p.descricao as descrição, 
	count(p.valor_unitario) as "Qtde Vendida",
       sum(p.valor_unitario) as "Valor Total",
	   l.nome as "Loja"
       from produto as p
inner join venda v 
on p.codigo = v.cod_produto
inner join loja as l
on v.cod_loja = l.codigo
group by v.cod_produto, l.nome
order by l.nome;

/* 
  Qual vendedor vendeu mais produtos
  Subquery ou Subconsulta
*/

select  m.vendedor as Vendedor, max(m.`Qtde Vendida`) as "Qtde Vendida" 
from   ( select  vd.nome as vendedor, 
				 count(*) as "Qtde Vendida"
         from produto as p
               inner join venda v 
               on p.codigo = v.cod_produto
               inner join vendedor as vd
               on v.cod_vendedor = vd.codigo
               group by vd.nome ) as m;

/*
   Valor total em produtos vendidos por vendedor; 
*/
select produto.descricao as produto,
       venda.cod_vendedor as codigo_vendedor,
       vendedor.nome as nome_vendedor,
       sum(produto.valor_unitario) as valor_vendido
       from produto, venda, vendedor
       where produto.codigo = venda.cod_produto
       and venda.cod_vendedor = vendedor.codigo
       group by  nome_vendedor;

/*
   Calcular comissão para cada vendedor; 
*/
select produto.descricao as produto,
       venda.cod_vendedor as codigo_vendedor,
       vendedor.nome as nome_vendedor,
       sum(produto.valor_unitario)  as valor_vendido,
       ( sum(produto.valor_unitario) * 0.1 )  as comissao
       from produto, venda, vendedor
       where produto.codigo = venda.cod_produto
       and venda.cod_vendedor = vendedor.codigo
       group by  nome_vendedor;

/*
   Mostrar vendas em um determinado intervalo de tempo.
*/
    select date_format( data_hora,'%Y-%m-%d') as data_hora 
    from venda;
    
    select date_format( data_hora,'%d/%m/%Y') as data 
    from venda;
    
    select date_format( data_hora,'%H:%i:%S') as hora 
    from venda;
    
    select  cod_produto as produto,
            date_format( data_hora,'%d/%m/%Y') as data,
		    date_format( data_hora,'%H:%i:%S') as hora 
    from venda;
    
    select * from venda where data_hora = '2016-10-18 16:13:00';
    select * from venda 
             where date_format(data_hora,'%Y-%m-%d') = '2016-10-18';


    select cod_vendedor, date_format(data_hora, "%d-%m-%Y") as data,
                         date_format(data_hora, "%H-%i-%S") as hora
    from venda where data_hora between "2016-06-10" and now(); 
    

/* Valor total em produtos vendidos por loja*/
select v.cod_produto, p.descricao as descrição, 
	count(p.valor_unitario) as "Qtde Vendida",
       sum(p.valor_unitario) as "Valor Total",
	   l.nome as "Loja"
       from produto as p
inner join venda v 
on p.codigo = v.cod_produto
inner join loja as l
on v.cod_loja = l.codigo
group by v.cod_produto, l.nome
order by l.nome;

/*
   Criar visões - "CREATE VIEW" 
*/
create view  view_produtos_vendidos_por_loja as 
select v.cod_produto, p.descricao as descrição, 
	count(p.valor_unitario) as "Qtde Vendida",
       sum(p.valor_unitario) as "Valor Total",
	   l.nome as "Loja"
       from produto as p
inner join venda v 
on p.codigo = v.cod_produto
inner join loja as l
on v.cod_loja = l.codigo
group by v.cod_produto, l.nome
order by l.nome;


/*
   Consultando uma view 
*/

select * from view_produtos_vendidos_por_loja;

/*
  Criar uma view com os códigos e nomes de vendedores por loja.
*/
   create or replace view view_vendedores_por_loja as 
   select vendedor.codigo as codigo_vendedor,
          vendedor.nome as nome_vendedor,
          loja.nome as nome_loja
   from vendedor, loja
   where vendedor.cod_loja = loja.codigo ;
   
 select * from view_vendedores_por_loja 
          where nome_vendedor = "vendedor 1";

  create or replace view view_venda_produto as
 select venda.codigo as codigo_venda, 
        produto.descricao as produto,
        produto.valor_unitario as valor_unitario
 from venda, produto 
 where venda.cod_produto = produto.codigo 
 group by produto;
		
 

