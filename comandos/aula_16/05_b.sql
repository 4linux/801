CREATE INDEX idx_brin_op_class_64 ON tb_temperatura_log
    USING brin (dt timestamp_minmax_ops)
    WITH (pages_per_range = 64);

CREATE INDEX idx_brin_op_class_256 ON tb_temperatura_log
    USING brin (dt timestamp_minmax_ops)
    WITH (pages_per_range = 256);    

CREATE INDEX idx_brin_op_class_512 ON tb_temperatura_log
    USING brin (dt timestamp_minmax_ops)
    WITH (pages_per_range = 512);

EXPLAIN ANALYZE
SELECT avg(temperatura)
    FROM tb_temperatura_log
    WHERE dt >='2017-01-01' AND dt < '2017-12-01';

EXPLAIN ANALYZE
SELECT avg(temperatura)
    FROM tb_temperatura_log
    WHERE dt = '2017-03-01';

SELECT
    indexname indice,
    pg_size_pretty(pg_relation_size(indexname::text)) tamanho
    FROM pg_indexes
    WHERE tablename = 'tb_temperatura_log'
    ORDER BY pg_relation_size(indexname::text);

DROP TABLE tb_temperatura_log;

