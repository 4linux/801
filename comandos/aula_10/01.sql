CREATE TABLE tb_vacuum AS
  SELECT
    generate_series(1, 1000000) AS campo1,
    generate_series(1, 1000000) AS campo2;

SELECT oid, relfilenode FROM pg_class WHERE relname = 'tb_vacuum';

CREATE INDEX idx_campo1 ON tb_vacuum (campo1);
CREATE INDEX idx_campo2 ON tb_vacuum (campo2);

DELETE FROM tb_vacuum
  WHERE campo1 > 700000
    AND campo2 > 700000;

SELECT pg_size_pretty(pg_relation_size('tb_vacuum'));

VACUUM (TRUNCATE, PARALLEL 2, VERBOSE) tb_vacuum;

SELECT oid, relfilenode FROM pg_class WHERE relname = 'tb_vacuum';

SELECT pg_size_pretty(pg_relation_size('tb_vacuum'));

UPDATE tb_vacuum SET campo1 = campo1 + 1 WHERE campo1 < 700000;
UPDATE tb_vacuum SET campo2 = campo2 + 1 WHERE campo2 < 700000;

SELECT pg_size_pretty(pg_relation_size('tb_vacuum'));

VACUUM (FULL, ANALYZE, VERBOSE) tb_vacuum;

SELECT pg_size_pretty(pg_relation_size('tb_vacuum'));


