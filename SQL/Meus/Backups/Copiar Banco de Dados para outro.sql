USE master;
GO

-- Cria o banco de dados de destino com a mesma estrutura do banco de origem
CREATE DATABASE nome_do_destino
    ON (FILENAME = 'C:\caminho\para\o\arquivo.mdf'), -- Precisa pegar o caminho do arquivo origem
    (FILENAME = 'C:\caminho\para\o\arquivo.ldf')    ---- Precisa pegar o caminho do arquivo destino
    FOR ATTACH;
GO

-- Copia todos os dados do banco de origem para o banco de destino
INSERT INTO nome_do_destino..nome_da_tabela
SELECT *
FROM nome_do_origem..nome_da_tabela;
GO
