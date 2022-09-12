SELECT
    generate_series(1, 2000000)::int AS campo1, -- 2 milhões de registros
    round((random()*10000))::int2 AS campo2,
    round((random()*10000))::int2 AS campo3 INTO tb_foo;

EXPLAIN ANALYZE
SELECT campo1
    FROM tb_foo
    WHERE campo2 BETWEEN 235 AND 587;

CREATE INDEX idx_tb_foo_campo2 ON tb_foo (campo2);

EXPLAIN ANALYZE
SELECT campo1
    FROM tb_foo
    WHERE campo2 BETWEEN 235 AND 587;

DROP TABLE IF EXISTS tb_foo;

\timing on

CREATE INDEX idx_hash ON tb_foo USING hash (numero);
CREATE INDEX idx_btree ON tb_foo USING btree (numero);

SELECT
    pg_size_pretty(pg_relation_size('idx_hash')) AS indice_hash,
    pg_size_pretty(pg_relation_size('idx_btree')) AS indice_btree;

EXPLAIN ANALYZE
SELECT numero
    FROM tb_foo
    WHERE numero = 195773;

