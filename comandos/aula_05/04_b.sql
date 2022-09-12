CREATE POLICY po_users_mod_usuario
    ON tb_usuario
    FOR UPDATE
    USING (current_user = username)
    WITH CHECK (
        current_user = username
        AND shell IN (
            '/bin/bash',
            '/bin/sh',
            '/bin/dash',
            '/bin/zsh',
            '/bin/tcsh')
    );

SELECT username, nome_real, shell FROM tb_usuario;

UPDATE tb_usuario SET nome_real = 'Joana Silva' WHERE username = 'joana';

UPDATE tb_usuario
  SET (nome_real, shell) = ('Alice Silva', '/bin/fish')
  WHERE username = 'alice';

UPDATE tb_usuario
  SET (nome_real, shell) = ('Alice Silva', '/bin/zsh')
  WHERE username = 'alice';

SELECT username, nome_real, shell FROM tb_usuario;

SELECT policyname FROM pg_policies;

BEGIN;

DROP POLICY po_admin_all_priv_usuario ON tb_usuario;

DROP TABLE tb_usuario;

ROLLBACK;
