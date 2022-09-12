CREATE INDEX idx_include ON tb_foo (numero, id_) include (texto);

EXPLAIN ANALYZE
SELECT
    numero, id_, texto
    FROM tb_foo
    WHERE numero > 25000
    ORDER BY numero, id_ LIMIT 20;

SELECT
    indexname indice,
    pg_size_pretty(pg_relation_size(indexname::text)) tamanho
    FROM pg_indexes
    WHERE tablename = 'tb_foo'
    ORDER BY pg_relation_size(indexname::text);

DROP TABLE tb_foo;

