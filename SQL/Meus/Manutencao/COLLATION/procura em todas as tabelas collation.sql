DECLARE @TableName NVARCHAR(128)
DECLARE @ColumnName NVARCHAR(128)
DECLARE @Collation NVARCHAR(128)

DECLARE @SQL NVARCHAR(MAX)

-- Tabela temporária para armazenar os resultados
CREATE TABLE #CollationResults (
    TableName NVARCHAR(128),
    ColumnName NVARCHAR(128),
    CollationName NVARCHAR(128)
)

-- Cursor para iterar pelas tabelas e colunas
DECLARE collation_cursor CURSOR FOR
SELECT
    TABLE_NAME,
    COLUMN_NAME
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    COLLATION_NAME = 'Latin1_General_CI_AS'

OPEN collation_cursor

FETCH NEXT FROM collation_cursor INTO @TableName, @ColumnName

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Construir a consulta para obter a ordenação da coluna
    SET @SQL = 'SELECT ''' + @TableName + ''' AS TableName, ''' + @ColumnName + ''' AS ColumnName, ' +
               'COLLATION_NAME FROM sys.columns WHERE object_id = OBJECT_ID(''' + @TableName + ''') ' +
               'AND name = ''' + @ColumnName + ''''

    -- Executar a consulta dinâmica
    INSERT INTO #CollationResults (TableName, ColumnName, CollationName)
    EXEC sp_executesql @SQL

    FETCH NEXT FROM collation_cursor INTO @TableName, @ColumnName
END

CLOSE collation_cursor
DEALLOCATE collation_cursor

-- Selecionar os resultados
SELECT TableName, ColumnName, CollationName
FROM #CollationResults

-- Limpar tabela temporária
DROP TABLE #CollationResults
