SELECT
    generate_series(1, 2000000) AS campo
    INTO tb_foo;

CREATE INDEX idx_teste_comum
    ON tb_foo (campo);

CREATE INDEX idx_teste_div19
    ON tb_foo (campo)
    WHERE campo % 19 = 0;

EXPLAIN
SELECT campo FROM tb_foo
    WHERE campo = 975421;

EXPLAIN ANALYZE
SELECT campo FROM tb_foo
    WHERE campo = 975421;

EXPLAIN
SELECT count(*) FROM tb_foo
    WHERE campo % 19 = 0;

EXPLAIN ANALYZE
SELECT count(*) FROM tb_foo
    WHERE campo % 19 = 0;

EXPLAIN (ANALYZE, FORMAT JSON, VERBOSE, BUFFERS)
SELECT count(*) FROM tb_foo
    WHERE campo % 19 = 0;

DROP TABLE tb_foo;
