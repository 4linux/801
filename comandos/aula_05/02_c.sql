SET ROLE dba;

REVOKE CONNECT ON DATABASE db_zero FROM PUBLIC;

GRANT CONNECT, CREATE ON DATABASE db_zero TO dev;

\l db_zero

SELECT has_database_privilege('beethoven', 'db_zero', 'CONNECT');

RESET role;

\c db_zero vivaldi

\du vivaldi

\c db_zero beethoven

\c db_zero aluno

REVOKE CONNECT ON DATABASE db_zero FROM dev;

GRANT CONNECT ON DATABASE db_zero TO PUBLIC;

SELECT
  unnest(datacl) AS permissoes
  FROM pg_database
  WHERE datname = 'db_zero';
