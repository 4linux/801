SHOW autovacuum_naptime;

ALTER SYSTEM SET autovacuum_naptime = 3;

SELECT pg_reload_conf();

SHOW autovacuum_naptime;

CREATE TABLE tb_teste_threshold AS
    SELECT generate_series(1, 1000000) AS campo;

SELECT
    (s1.setting::REAL + s2.setting::REAL * c.reltuples::REAL)
        AS "vacuum threshold"
    FROM pg_settings AS s1, pg_settings AS s2, pg_class AS c
    WHERE s1.name = 'autovacuum_vacuum_threshold'
        AND s2.name = 'autovacuum_vacuum_scale_factor'
        AND c.relname = 'tb_teste_threshold';

SELECT
    autovacuum_count
    FROM pg_stat_user_tables
    WHERE relname = 'tb_teste_threshold';

DELETE FROM tb_teste_threshold WHERE campo <= 200051;

SELECT
    n_dead_tup,
    autovacuum_count
    FROM pg_stat_user_tables
    WHERE relname = 'tb_teste_threshold';

ALTER SYSTEM RESET autovacuum_naptime;		

SELECT pg_reload_conf();

SHOW autovacuum_naptime;
