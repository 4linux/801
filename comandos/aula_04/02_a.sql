\c template1

CREATE TABLE tb_foo();

CREATE DATABASE db_foo;

\c db_foo

\dt

\c template1

DROP TABLE tb_foo;

DROP DATABASE db_foo;

CREATE DATABASE db_foo;

\c db_foo

\dt

CREATE TABLE tb_1();

\dt

CREATE DATABASE db_bar TEMPLATE db_foo;

\c db_bar

\dt

DROP DATABASE postgres;

CREATE DATABASE postgres TEMPLATE template0;

CREATE ROLE user_test1 LOGIN CREATEDB PASSWORD '123456';
CREATE ROLE user_test2 LOGIN CREATEDB PASSWORD '123456';

\c postgres user_test1

CREATE DATABASE db1;

\c db1 user_test1

SELECT
  u.usename AS proprietario,
  d.datistemplate AS base_de_dados_e_template
  FROM pg_database AS d
  INNER JOIN pg_user AS u
    ON (d.datdba = u.usesysid)
  WHERE datname = 'db1';

CREATE TABLE tb1();
