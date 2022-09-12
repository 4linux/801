SHOW search_path;

CREATE DATABASE db_schema;

\c db_schema

CREATE SCHEMA sc_teste;

SET search_path = sc_teste, "$user", public;

CREATE TABLE tb_teste();

\dt

RESET search_path;

\dt sc_teste.*


CREATE TABLE sc_teste.tb_teste2();

SELECT schemaname, relname FROM pg_stat_user_tables;

DROP SCHEMA sc_teste;

DROP SCHEMA sc_teste CASCADE;
