--CRIAR BANCO DE DADOS PARA FLUIG
CREATE DATABASE nome_do_banco COLLATE Latin1_General_CI_AS;


--Propriet�rio do Banco
--O usu�rio utilizado pela plataforma para conex�o com o banco de dados deve ser propriet�rio (db_owner) do banco utilizado pela plataforma. Para verificar qual usu�rio � o propriet�rio do banco execute o seguinte comando SQL:
 SELECT suser_sname(owner_sid) FROM sys.databases WHERE name = 'FLUIG_180';
  --VERIFICA QUAL O USUARIO E O DONO DO BANCO DE DADOS -- GERALMENTE SA