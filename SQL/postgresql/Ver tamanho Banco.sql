SELECT
    pg_size_pretty(pg_database_size(current_database())) AS "Tamanho do Banco de Dados";