CREATE DATABASE db_rls;

\c db_rls;

CREATE ROLE admin LOGIN PASSWORD '123'; -- Administrador
CREATE ROLE alice LOGIN PASSWORD '123'; -- Usuário comum
CREATE ROLE joana LOGIN PASSWORD '123'; -- Usuário comum

CREATE TABLE tb_usuario(
    username text PRIMARY KEY, -- Usuário
    pw_hash text, -- Hash de senha
    nome_real text NOT NULL, -- Nome
    shell text NOT NULL ); -- Shell

INSERT INTO tb_usuario VALUES ('admin', '###', 'Administrador', '/bin/tcsh');

GRANT SELECT, INSERT, UPDATE, DELETE ON tb_usuario TO admin;

GRANT SELECT (username, nome_real, shell) ON tb_usuario TO PUBLIC;

GRANT UPDATE (pw_hash, username, nome_real, shell) ON tb_usuario TO PUBLIC;

ALTER TABLE tb_usuario ENABLE ROW LEVEL SECURITY;

\c db_rls admin;

TABLE tb_usuario;

CREATE POLICY po_admin_all_priv_usuario
    ON tb_usuario
    TO admin
    USING (true)
    WITH CHECK (true);

INSERT INTO tb_usuario VALUES
    ('alice', '###', 'Alice', '/bin/bash'),
    ('joana', '###', 'Joana', '/bin/zsh');

TABLE tb_usuario;

\c db_rls alice

SELECT username, nome_real, shell FROM tb_usuario;

CREATE POLICY po_all_view_usuario
    ON tb_usuario
    FOR SELECT
    USING (true);
