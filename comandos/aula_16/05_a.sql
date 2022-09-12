CREATE TABLE tb_temperatura_log (
    dt timestamp without time zone,
    temperatura int);

INSERT INTO tb_temperatura_log (dt, temperatura) VALUES
    (generate_series(
        '2017-01-01'::timestamp,
        '2018-03-31'::timestamp,
        '1 second'),
        round(random() * 100)::int);

\timing on

CREATE INDEX idx_btree ON tb_temperatura_log USING btree (dt);

EXPLAIN ANALYZE
SELECT avg(temperatura)
    FROM tb_temperatura_log
    WHERE dt >='2017-01-01' AND dt < '2017-12-31';

CREATE INDEX idx_brin ON tb_temperatura_log USING brin (dt);

EXPLAIN ANALYZE
SELECT avg(temperatura)
    FROM tb_temperatura_log
    WHERE dt >='2017-01-01' AND dt < '2017-12-01';

CREATE INDEX idx_brin_op_class ON tb_temperatura_log
    USING brin (dt timestamp_minmax_ops);

EXPLAIN ANALYZE
SELECT avg(temperatura)
    FROM tb_temperatura_log
    WHERE dt >='2017-01-01' AND dt < '2017-12-01';

