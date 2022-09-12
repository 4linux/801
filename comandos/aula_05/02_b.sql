SET ROLE dba;

REVOKE SELECT, UPDATE ON tb_sre FROM masters;

REVOKE ALL ON tb_dev, tb_sysadm FROM masters;

SELECT
  relname,
  relacl AS privilegios
  FROM pg_class
  WHERE relname IN ('tb_dev', 'tb_sysadm', 'tb_sre')
  ORDER BY relname;

ALTER TABLE tb_dev ADD COLUMN campo2 int;

GRANT ALL (campo2) ON tb_dev TO masters;

\z tb_dev

RESET role;

INSERT INTO tb_dev (campo2) VALUES (1);

SELECT campo2 FROM tb_dev;

SELECT campo1 FROM tb_dev;

SELECT has_column_privilege(current_user, 'tb_dev', 'campo1', 'SELECT');

SELECT has_column_privilege(current_user, 'tb_dev', 'campo2', 'SELECT');
