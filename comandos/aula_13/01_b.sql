CREATE TABLE tb_intervalo_2019_10
PARTITION OF tb_intervalo
FOR VALUES FROM ('2019-10-01') TO ('2019-11-01');

CREATE TABLE tb_intervalo_2019_11
PARTITION OF tb_intervalo
FOR VALUES FROM ('2019-11-01') TO ('2019-12-01');

CREATE TABLE tb_intervalo_2019_12
PARTITION OF tb_intervalo
FOR VALUES FROM ('2019-12-01') TO ('2020-01-01');

INSERT INTO tb_intervalo (dt) VALUES ('2020-01-01');

CREATE TABLE tb_intervalo_default
    PARTITION OF tb_intervalo DEFAULT;

INSERT INTO tb_intervalo (dt) VALUES ('2020-01-01');

TRUNCATE tb_intervalo RESTART IDENTITY;

WITH t (id_, random_date) AS (
    SELECT
        generate_series(1, 1000000),
        '2019-01-01'::date +
        (round(random() * ('2020-03-31'::date -
        '2019-01-01'::date)))::int2
    )
    INSERT INTO tb_intervalo (dt)
        SELECT random_date FROM t;

ANALYZE VERBOSE tb_intervalo;

SELECT
    relname AS tabela,
    pg_size_pretty(pg_relation_size(relname::regclass)) AS tamanho,
    reltuples::int8 AS registros
    FROM pg_class
    WHERE relname ~ 'tb_intervalo'
        AND relkind = 'r'
    ORDER BY relname;

ALTER TABLE tb_intervalo DETACH PARTITION tb_intervalo_2019_01;

ALTER TABLE tb_intervalo
    ATTACH PARTITION tb_intervalo_2019_01
    FOR VALUES FROM ('2019-01-01') TO ('2019-02-01');

DROP TABLE tb_intervalo_2019_02;

DROP TABLE tb_intervalo;
