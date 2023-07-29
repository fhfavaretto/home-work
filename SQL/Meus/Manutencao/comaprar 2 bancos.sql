-- Banco de dados 1
USE PROTHEUSDB_MIGRACAO;
GO

-- Criar uma tabela temporária para armazenar as tabelas do banco de dados 1
CREATE TABLE #TabelasBanco1 (
    NomeDaTabela NVARCHAR(128)
);

-- Inserir as tabelas do banco de dados 1 na tabela temporária
INSERT INTO #TabelasBanco1 (NomeDaTabela)
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

-- Banco de dados 2
USE PROTEHUSDB_MIGRACAO1;
GO

-- Criar uma tabela temporária para armazenar as tabelas do banco de dados 2
CREATE TABLE #TabelasBanco2 (
    NomeDaTabela NVARCHAR(128)
);

-- Inserir as tabelas do banco de dados 2 na tabela temporária
INSERT INTO #TabelasBanco2 (NomeDaTabela)
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

-- Listar as tabelas presentes no banco de dados 1 e ausentes no banco de dados 2
SELECT NomeDaTabela
FROM #TabelasBanco1
WHERE NomeDaTabela NOT IN (SELECT NomeDaTabela FROM #TabelasBanco2);

-- Limpar tabelas temporárias
DROP TABLE #TabelasBanco1;
DROP TABLE #TabelasBanco2;
