CREATE ROLE dev;  -- Grupo de desenvolvedores
CREATE ROLE sysadm;  -- Grupo de administradores de sistema  
CREATE ROLE sre;  -- Grupo de SRE (Site Reliability Engineering)
CREATE ROLE masters;  -- Grupo geral masters
CREATE ROLE dba SUPERUSER; --Grupo com atributo SUPERUSER para DBAs

CREATE ROLE beethoven PASSWORD '123456' LOGIN;

CREATE ROLE bach LOGIN PASSWORD '123456' IN ROLE sre;
CREATE ROLE vivaldi LOGIN PASSWORD '123456' IN ROLE dev;

CREATE ROLE mozart LOGIN PASSWORD '123456' IN  ROLE dev, sysadm;

GRANT masters TO bach, beethoven, mozart, vivaldi;

\du

CREATE DATABASE db_zero;

\c db_zero

CREATE TABLE tb_dev(campo1 int);
CREATE TABLE tb_sysadm(campo1 int);
CREATE TABLE tb_sre(campo1 int);

\dt

ALTER TABLE tb_dev OWNER TO dev;
ALTER TABLE tb_sysadm OWNER TO sysadm;
ALTER TABLE tb_sre OWNER TO sre;

GRANT dba TO beethoven;

\c db_zero mozart

SELECT session_user, current_user;

\du mozart

SELECT
  pg_get_userbyid(roleid) AS membro_de
  FROM pg_auth_members
  WHERE pg_get_userbyid(member) = 'mozart'
  ORDER BY membro_de;
