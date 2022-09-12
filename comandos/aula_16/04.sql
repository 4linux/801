CREATE TABLE tb_foo (
    id int,
    vetor int[]);

INSERT INTO tb_foo (id, vetor)
    SELECT
        generate_series(1, 1000000),
        ARRAY[
            round(random() * 10000000),
            round(random() * 10000000),
            round(random() * 10000000)];

CREATE INDEX idx_gin ON tb_foo USING gin (vetor);
CREATE INDEX idx_gin_op_class ON tb_foo USING gin (vetor array_ops);

EXPLAIN ANALYZE
SELECT vetor FROM tb_foo WHERE vetor @> ARRAY[754532];

DROP TABLE tb_foo;

