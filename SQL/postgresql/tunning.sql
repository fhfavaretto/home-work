-- Ajuste das configurações do PostgreSQL
-- --------------------------------------

-- Aumentar o tamanho máximo de memória compartilhada disponível
shared_buffers = 4GB

-- Aumentar o número máximo de conexões simultâneas
max_connections = 200

-- Aumentar o tamanho máximo de trabalho para operações complexas
work_mem = 64MB

-- Aumentar o tamanho máximo de memória para operações de classificação
maintenance_work_mem = 1GB

-- Aumentar o número máximo de buffers de escrita em disco
effective_cache_size = 8GB

-- Otimização de consultas
-- -----------------------

-- Ativar a auto-exploração de parâmetros em consultas
default_statistics_target = 100

-- Aumentar o número de estatísticas geradas para colunas
autovacuum_analyze_scale_factor = 0.05
autovacuum_analyze_threshold = 50

-- Ativar o monitoramento de consultas lentas
log_min_duration_statement = 1000
log_duration = on

-- Gerenciamento de índices
-- ------------------------

-- Monitorar o tamanho dos índices
track_io_timing = on

-- Verificar índices em busca de fragmentação
vacuuming_index_scale_factor = 0.1
autovacuum_vacuum_scale_factor = 0.1

-- Atualizar estatísticas de índices automaticamente
autovacuum_analyze_scale_factor = 0.05
autovacuum_analyze_threshold = 50

-- Recarregar a configuração do PostgreSQL
-- --------------------------------------

-- Recarregar a configuração do PostgreSQL para que as alterações tenham efeito
SELECT pg_reload_conf();
