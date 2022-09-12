\c db_zero postgres

ALTER DEFAULT PRIVILEGES IN SCHEMA sc_dev GRANT SELECT ON TABLES TO masters;

CREATE TABLE sc_dev.tb_teste2 (campo1 int);
CREATE TABLE sc_dev.tb_teste3 (campo1 int);

ALTER TABLE sc_dev.tb_teste2 OWNER TO dev;
ALTER TABLE sc_dev.tb_teste3 OWNER TO dev;

SELECT
  n.nspname||'.'||c.relname AS tabela,
  relacl AS privilegios
  FROM pg_class AS c
  INNER JOIN pg_namespace AS n
    ON (n.oid = c.relnamespace)
  WHERE n.nspname = 'sc_dev'
  ORDER BY relname;

ALTER DEFAULT PRIVILEGES FOR ROLE dev GRANT SELECT ON TABLES TO masters;

ALTER DEFAULT PRIVILEGES FOR ROLE dev GRANT USAGE ON SCHEMAS TO masters;

CREATE SCHEMA sc_dev2 AUTHORIZATION dev;

\dn sc_dev*

SET role dev;

SELECT session_user, current_user;

CREATE TABLE sc_dev2.tb_dev2(campo int);
CREATE TABLE tb_dev2(campo int);

\dt sc_dev2.*

\dt

\c db_zero beethoven

SELECT * FROM sc_dev2.tb_dev2;
SELECT * FROM tb_dev2;
