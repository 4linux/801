CREATE TABLE tb_foo(campo1 int);

INSERT INTO tb_foo SELECT generate_series(1, 1000000);

EXPLAIN ANALYZE
    SELECT * FROM tb_foo WHERE campo1 % 19 = 0;

CREATE INDEX idx_total ON tb_foo (campo1);

EXPLAIN ANALYZE
    SELECT * FROM tb_foo WHERE campo1 % 19 = 0;

CREATE INDEX idx_19 ON tb_foo (campo1) WHERE campo1 % 19 = 0;

EXPLAIN ANALYZE
    SELECT * FROM tb_foo WHERE campo1 % 19 = 0;

EXPLAIN ANALYZE
    SELECT * FROM tb_foo
        WHERE campo1 BETWEEN 241 AND 875;

SELECT
    indexname indice,
    pg_size_pretty(pg_relation_size(indexname::text)) tamanho
    FROM pg_indexes
    WHERE tablename = 'tb_foo'
    ORDER BY pg_relation_size(indexname::text);

DROP TABLE tb_foo;

