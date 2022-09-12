CREATE DATABASE db_teste2;

\c db_teste2

CREATE TABLE tb_teste(
    id SERIAL PRIMARY KEY,
    campo_a INT,
    campo_b VARCHAR(10));

CREATE DATABASE db_teste1;

\c db_teste1

CREATE EXTENSION postgres_fdw;

CREATE SERVER srv_srv2
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host '192.168.56.71', dbname 'db_teste2', port '5432');

CREATE USER MAPPING FOR postgres
    SERVER srv_srv2
    OPTIONS (user 'postgres', password '123');

CREATE FOREIGN TABLE ft_teste(
  id INT,
  campo_a INT,
  campo_b VARCHAR(10))
  SERVER srv_srv2
  OPTIONS (table_name 'tb_teste', updatable 'true');

INSERT INTO ft_teste (id, campo_a, campo_b) VALUES (1, 700, 'foo');

SELECT * FROM ft_teste;

SELECT * FROM tb_teste;

DROP FOREIGN TABLE ft_teste;

DROP USER MAPPING FOR postgres SERVER srv_srv2;

DROP SERVER srv_srv2;

DROP EXTENSION postgres_fdw;

\c postgres

DROP DATABASE db_teste1;
