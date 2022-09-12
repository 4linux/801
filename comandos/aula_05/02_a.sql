\c db_zero beethoven

\z tb_dev

\dp tb_dev

SET ROLE dba;

GRANT SELECT ON TABLE tb_dev TO masters;

RESET role;

SELECT has_table_privilege(current_user, 'tb_dev', 'SELECT');

SELECT has_table_privilege(current_user, 'tb_dev', 'INSERT');

SELECT
  unnest(relacl) AS privilegios
  FROM pg_class
  WHERE relname = 'tb_dev';

SELECT * FROM tb_dev;

SET ROLE dba; 

GRANT SELECT, DELETE, INSERT ON TABLE tb_sysadm TO masters;

GRANT UPDATE ON TABLE tb_sre TO masters;

reset  role;

SELECT
  relname,
  relacl AS privilegios
  FROM pg_class
  WHERE relname IN ('tb_dev', 'tb_sysadm', 'tb_sre')
  ORDER BY relname;

INSERT INTO tb_sysadm (campo1) VALUES (9885);

UPDATE tb_sysadm SET campo1 = 0 WHERE campo1 = 9885;

UPDATE tb_sre SET campo1 = 0 WHERE campo1 > 100;

SET ROLE dba; 

GRANT SELECT ON TABLE tb_sre TO masters;

reset role; 

SELECT
  relacl AS privilegios
  FROM pg_class
  WHERE relname = 'tb_sre';
