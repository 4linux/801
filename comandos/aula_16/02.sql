CREATE OR REPLACE FUNCTION fc_gera_int4range(n int4)
RETURNS int4range AS $$
DECLARE
    limite_superior int4 := round(random() * n);
    limite_inferior int4 := round(random() * limite_superior);
BEGIN
    RETURN ('['||limite_inferior||', '||limite_superior||']')::int4range;
END; $$ LANGUAGE PLPGSQL;

DROP TABLE IF EXISTS tb_foo;

CREATE TABLE tb_foo(
    id int,
    faixa int4range);

INSERT INTO tb_foo (id, faixa)
    SELECT
        generate_series(1, 1000000),
        fc_gera_int4range(1000000);

CREATE INDEX idx_gist ON tb_foo USING gist (faixa);
CREATE INDEX idx_gist_op_class ON tb_foo USING gist (faixa range_ops);

EXPLAIN ANALYZE
SELECT id, faixa
    FROM tb_foo WHERE faixa @> 777;
