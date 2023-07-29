SELECT
    relname AS "Nome da Tabela",
    pg_size_pretty(pg_total_relation_size(relid) / (1024 * 1024)) AS "Tamanho Total (MB)"
FROM
    pg_catalog.pg_statio_user_tables
ORDER BY
    pg_total_relation_size(relid) DESC;
