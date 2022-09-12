CREATE OR REPLACE function fc_member_of(role_ text)
  RETURNS TABLE (member_of text)
  AS $identificador$
BEGIN
    RETURN QUERY
    SELECT
      pg_get_userbyid(roleid)::text
      FROM pg_auth_members
      WHERE pg_get_userbyid(member) = role_;
  RETURN;
END;
$identificador$ LANGUAGE PLPGSQL;

SELECT fc_member_of('mozart');

INSERT INTO tb_dev (campo1) VALUES (1);
INSERT INTO tb_sysadm (campo1) VALUES (517);

INSERT INTO tb_sre (campo1) VALUES (5448);

\c db_zero bach

SELECT fc_member_of('bach');

SELECT session_user, current_user;

\c db_zero beethoven

SELECT fc_member_of('beethoven');

SELECT * FROM tb_dev;
SELECT * FROM tb_sysadm;
SELECT * FROM tb_sre;

SET ROLE dba;

\du dba

RESET role;
