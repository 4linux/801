CREATE SCHEMA sc_dev AUTHORIZATION dev;

SELECT
  r.rolname role_proprietario
  FROM pg_namespace AS n 
  INNER JOIN pg_roles AS r
  ON (r.oid = n.nspowner)
  WHERE n.nspname = 'sc_dev';

\dn sc_dev

\du vivaldi

\c db_zero vivaldi








CREATE TABLE sc_dev.tb_teste (campo1 int);

\dt sc_dev.*

ALTER TABLE sc_dev.tb_teste OWNER TO dev;








GRANT ALL ON TABLE sc_dev.tb_teste TO masters;

\c db_zero beethoven

INSERT INTO sc_dev.tb_teste (campo1) VALUES (1);

\c db_zero vivaldi

GRANT USAGE ON SCHEMA sc_dev TO masters;

\dn+ sc_dev

INSERT INTO sc_dev.tb_teste (campo1) VALUES (1);

SELECT * FROM sc_dev.tb_teste;
