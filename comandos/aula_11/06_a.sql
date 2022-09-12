\timing on

CREATE TABLE tb_ff100(campo int);

INSERT INTO tb_ff100 (campo) SELECT generate_series(1, 1000000);

SELECT pg_size_pretty(pg_relation_size('tb_ff100'));

UPDATE tb_ff100 SET campo = campo + 1;

DROP TABLE tb_ff100;

CREATE TABLE tb_ff50(campo int) WITH (fillfactor = 50);

INSERT INTO tb_ff50 (campo)
    SELECT generate_series(1, 1000000);

SELECT pg_size_pretty(pg_relation_size('tb_ff50'));

UPDATE tb_ff50 SET campo = campo + 1;

DROP TABLE tb_ff50;

CREATE INDEX idx_ff100
    ON tb_ff100 (campo)
    WITH (fillfactor = 100);
