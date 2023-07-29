SELECT 
    SERVERPROPERTY('ProductVersion') AS 'Versão',
    SERVERPROPERTY('ProductLevel') AS 'Nível do Produto',
    SERVERPROPERTY('Edition') AS 'Edição',
    SERVERPROPERTY('EngineEdition') AS 'Edição do Motor'
