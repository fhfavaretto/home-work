-- Habilita a configuração avançada para alterar as opções
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

-- Define a memória mínima para 4 GB
EXEC sp_configure 'min server memory', 4096;
RECONFIGURE;

-- Define a memória máxima para 12 GB
EXEC sp_configure 'max server memory', 12288;
RECONFIGURE;

-- Desabilita a configuração avançada novamente
EXEC sp_configure 'show advanced options', 0;
RECONFIGURE;


