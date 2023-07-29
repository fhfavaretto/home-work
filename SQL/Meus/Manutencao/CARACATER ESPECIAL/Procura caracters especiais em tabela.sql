DECLARE @SpecialChars NVARCHAR(50) = N'.,:;!?-—–‘’“”()[]{}\/|@#%&*^~`';
DECLARE @TableName NVARCHAR(255) = N'SA1010';

DECLARE @Sql NVARCHAR(MAX) = N'';

SELECT @Sql = @Sql + 'SELECT * FROM ' + @TableName + ' WHERE ' + QUOTENAME(COLUMN_NAME) + ' LIKE ''%[' + @SpecialChars + ']%'';' + CHAR(13)
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @TableName
    AND DATA_TYPE IN ('char', 'varchar', 'nvarchar', 'text', 'ntext');

EXEC sp_executesql @Sql;
