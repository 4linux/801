ANALYZE VERBOSE tb_hash;

SELECT
    relname AS tabela,
    pg_size_pretty(pg_relation_size(relname::regclass)) AS tamanho,
    reltuples::int8 AS registros
    FROM pg_class
    WHERE relname ~ 'tb_hash'
        AND relkind = 'r'
    ORDER BY relname;

WITH t AS (
    SELECT
        relname AS tabela,
        pg_size_pretty(pg_relation_size(relname::regclass)) AS tamanho,
        reltuples::int8 AS registros
        FROM pg_class
        WHERE relname ~ 'tb_hash_'
            AND relkind = 'r'
        ORDER BY relname)
    SELECT round(avg(registros)) AS media FROM t;

DROP TABLE tb_hash;
