\d tb_ff100

INSERT INTO tb_ff100 (campo) SELECT generate_series(1, 1000000);

SELECT pg_size_pretty(pg_relation_size('idx_ff100'));

UPDATE tb_ff100 SET campo = campo + 1;

DROP TABLE tb_ff100;

CREATE TABLE tb_ff50(campo int);

CREATE INDEX idx_ff50 ON tb_ff50 (campo)
    WITH (fillfactor = 50);

\d tb_ff50

INSERT INTO tb_ff50 (campo)
    SELECT generate_series(1, 1000000);

SELECT pg_size_pretty(pg_relation_size('idx_ff50'));

UPDATE tb_ff50 SET campo = campo + 1;

DROP TABLE tb_ff50;
