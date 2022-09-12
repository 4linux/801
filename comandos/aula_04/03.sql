SELECT oid, spcname FROM pg_tablespace WHERE spcname ~ '^ts_';

CREATE DATABASE db_ts;

\c db_ts

CREATE TABLE tb_teste (
    id serial PRIMARY KEY
        USING INDEX TABLESPACE ts_alpha, -- tablespace do índice
    campo_2 text,
    campo_3 int)
    TABLESPACE ts_beta; -- tablespace da tabela

\d tb_teste

INSERT INTO tb_teste (campo_2, campo_3)
    SELECT
        md5(random()::text),  -- campo_2
        generate_series(1, 5000000);  -- campo_3

\dit+

\! du -hs /var/db_storage/*

ALTER TABLE tb_teste SET TABLESPACE ts_gamma;

