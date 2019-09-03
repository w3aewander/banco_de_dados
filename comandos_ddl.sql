
/* 
Resumo 
  Comandos DDL - Comandos que são executados
  para se alterar a estrutura de banco, tabelas,
  views, trigers, procedure, functions, etc.

 CREATE, ALTER, DROP
 Ex.: create table <nome_tabela> (  
    campo1 tipo,
    campo2 tipo,
    ...
    campon tipo
 );
 */
 
 use HTC_DDS_03;
 create table tab_teste(
  id int not null,
  nome varchar(30) not null
 );
 alter table tab_teste
 add constraint pk_teste_id
 primary key(id,nome);
 
 /* excluir a chave primaria */
 use HTC_DDS_O3;
 alter table tab_teste
 drop PRIMARY KEY;
 
 /* adicionar a chave primara */
 alter table tab_teste
 add constraint primary key(id);
 
 /* modificar o tipo de dados do campo informado */
 alter table tab_teste 
 modify id int not null 
 primary key auto_increment;
 
 /* tornar o campo para o tipo unique */
 alter table tab_teste
 modify nome varchar(30) not null unique;

/* alterar o nome */ 
 alter table tab_teste
 change nome_pessoa  
 nome varchar(30);
 
 /* acrescentar nova coluna na tabela 
   aceitando apenas os valores 
   pré-definidos 
 */
 alter table tab_teste
 add column genero enum('masculino','feminino','prefiro não informar')
 not null default 'prefiro não informar';
 
 /* remover coluna da tabela */
 alter table tab_teste
 drop column genero;
 
 /* criar chave estrangeira */
 alter table tab_teste
 add constraint fk_teste_id
 foreign key(aluno_id) references ALUNOS(id)
 on delete cascade 
 on update cascade;
 
 /* excluir a tabela */
 drop table tab_teste;
 
 /* Exercícios */
 /*
  * Construa o modelo físico conforme o modelo relacional 
  * abaixo:
  */
  /*
   tbLoja(id inteiro nn ai pk, nome loja varchar(20) )
   
   tbVendedor(
                id int nn ai pk, 
                nome varchar(30) not null,
				loja_id references tbLoja(id) );
                
   tbCliente (
  
             id int nn ai pk,
             cnpj_cpf varchar(14) not null,
             nome varchar(30) not null
  );
                
  tbFornecedor ( 
               id int nn ai pk,
			   razao_social varchar(30) not null,
               cnpj varchar(14) not null               
  );
  
  
  tbProduto (
                id int nn ai pk ,
                descricao varchar(30) not null,
                unidade_id int references unidade(id),
                fornecedor_id int references fornecedor(id)
   );
  
  tbPedido(
                id inteiro nn ai pk, 
                produto_id int not null,
				vendedor_id int references tbVendedor(id) 
				produto_id int references tbProduto(id)
                qtde int 
  );
            
  tbClientePedido ( *cliente_id, *pedido_id fk);
 
*/
