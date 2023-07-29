--CRIAR BANCO DE DADOS PARA FLUIG
CREATE DATABASE nome_do_banco COLLATE Latin1_General_CI_AS;


--Proprietário do Banco
--O usuário utilizado pela plataforma para conexão com o banco de dados deve ser proprietário (db_owner) do banco utilizado pela plataforma. Para verificar qual usuário é o proprietário do banco execute o seguinte comando SQL:
 SELECT suser_sname(owner_sid) FROM sys.databases WHERE name = 'FLUIG_180';
  --VERIFICA QUAL O USUARIO E O DONO DO BANCO DE DADOS -- GERALMENTE SA