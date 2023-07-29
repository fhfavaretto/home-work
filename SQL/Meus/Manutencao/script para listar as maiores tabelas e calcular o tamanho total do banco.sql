SELECT 
    t.NAME AS TableName,
    SUM(p.rows) AS RowsCount,
    SUM(a.total_pages) * 8 AS TotalSpaceKB, 
    SUM(a.used_pages) * 8 AS UsedSpaceKB, 
    (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB
FROM 
    sys.tables t
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id
WHERE 
    t.NAME NOT LIKE 'dt%' AND
    i.OBJECT_ID > 255 AND   
    t.is_ms_shipped = 0
GROUP BY 
    t.NAME, i.object_id
ORDER BY 
    SUM(a.total_pages) DESC;
    
SELECT 
    SUM(reserved_page_count) * 8.0 / 1024 / 1024 AS DatabaseSizeGB
FROM 
    sys.dm_db_partition_stats;
