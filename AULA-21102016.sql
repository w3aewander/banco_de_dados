/*
--  Exercícios acompanhados data:  21/10/2016
--  Trabalhando com junções, agregações e subconsultas
*/

-- dropando o banco caso exista
drop database if exists db_loja;

-- criando o banco de dados. 
create database db_loja;

-- selecionando o banco de dados
use db_loja;

-- criando as tabelas 
create table loja ( 
      codigo int not null primary key auto_increment, 
      nome varchar(50) 
);

create table vendedor ( 
     codigo int not null primary key auto_increment, 
     nome varchar(50), 
     cod_loja int not null, 
     constraint fk_vendedor_loja foreign key(cod_loja) references loja(codigo)
);

create table produto (
     codigo int not null primary key auto_increment, 
     descricao varchar(50) , 
     unidade varchar(50),
	 valor_unitario decimal(8,2)
);

create table venda (
     codigo int not null primary key auto_increment,
     data_hora datetime,
     cod_produto int not null,
     cod_loja int not null,
     cod_vendedor int not null,
     constraint fk_produto_codigo foreign key ( cod_produto ) references produto(codigo),
     constraint fk_loja_codigo foreign key (cod_loja) references loja(codigo),
     constraint fk_vendedor_codigo foreign key (cod_vendedor) references vendedor(codigo)
     
);

/* populando as tabelas */
insert into loja values  (1,"Loja 1"),(2,"Loja 2") ;

insert into vendedor values ( 1,"Vendedor 1",1), 
                            ( 2,"Vendedor 2",1),
                            ( 3,"Vendedor 1",2),
							( 4,"Vendedor 2",2);
                            
insert into produto values (10,"produto 1","Kg","150.00"),(20,"produto 2","Kg","50.00"),(30,"produto 3","Kg","10.80"),(40,"produto 4","Kg","90.00"),(50,"produto 5","Kg","32.00");
insert into venda values ( 1,'2016-10-02 10:20:30',10,1,1),
                         ( 2,'2016-10-12 08:10:30',10,2,1),
                         ( 3,'2016-10-20 18:00:10',20,2,2),
                         ( 4,'2016-10-18 17:20:00',30,2,1),
                         ( 5,'2016-10-18 16:13:00',10,2,1),
                         ( 6,'2016-10-14 15:10:00',10,1,1),
                         ( 7,'2016-10-11 12:08:10',30,1,2),
                         ( 8,'2016-10-01 11:15:20',20,2,2),
                         ( 9,'2016-10-01 11:15:20',10,1,1),
                         ( 10,'2016-10-06 10:25:10',10,2,1);
