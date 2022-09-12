BEGIN;

SET LOCAL role masters;

SELECT session_user, current_user;

SET LOCAL role dba;

COMMIT;

\c db_zero bach

SELECT fc_member_of('bach');

SET ROLE dba;

\c db_zero beethoven

SET ROLE masters;

SET ROLE dev;

REASSIGN OWNED BY dev TO beethoven;

\dt

REASSIGN OWNED BY sysadm, sre TO beethoven;

ALTER TABLE tb_dev OWNER TO dev;
ALTER TABLE tb_sysadm OWNER TO sysadm;
ALTER TABLE tb_sre OWNER TO sre;
