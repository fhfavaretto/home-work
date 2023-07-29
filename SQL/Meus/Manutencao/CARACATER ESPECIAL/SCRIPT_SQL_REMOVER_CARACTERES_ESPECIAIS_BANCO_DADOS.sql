CREATE FUNCTION [dbo].[fncRemove_Caracteres_Especiais](
    @String VARCHAR(MAX)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
 
    
    DECLARE 
        @Result VARCHAR(MAX), 
        @StartingIndex INT = 0
    
    
    WHILE (1 = 1)
    BEGIN 
        
        SET @StartingIndex = PATINDEX('%[^a-Z|0-9|^ ]%',@String) 
        
        IF (@StartingIndex <> 0)
            SET @String = REPLACE(@String,SUBSTRING(@String, @StartingIndex,1),'') 
        ELSE 
            BREAK
 
    END    
    
    SET @Result = REPLACE(@String,'|','')
    
    RETURN @Result
 
END
GO