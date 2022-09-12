CREATE UNLOGGED TABLE tb_teste_unlogged (campo int);

CREATE TABLE tb_teste_logged (campo int);

\timing on

INSERT INTO tb_teste_unlogged (campo) SELECT generate_series(1, 3000000);

INSERT INTO tb_teste_logged (campo) SELECT generate_series(1, 3000000);

TABLE tb_teste_unlogged LIMIT 5;

SELECT
    oid, relfilenode, relname, relpersistence, relkind
    FROM pg_class
    WHERE relname ~ '^tb_.*logged';

ALTER TABLE tb_teste_unlogged SET LOGGED;

ALTER TABLE tb_teste_logged SET UNLOGGED;
