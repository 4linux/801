CREATE POLICY po_users_rw_anotacao
    ON tb_anotacao
    FOR ALL
    TO PUBLIC
    USING (current_user = username)
    WITH CHECK (current_user = username);

\c db_rls joana

INSERT INTO tb_anotacao (dt, title, description) VALUES
    (now(), 'Teste', 'Primeira anotação da Joana'),
    ('2020-10-07', 'Segundo Teste', 'Segunda anotação da Joana'),
    (now() - '2 days'::interval, 'Título', 'Bla bla bla');

TABLE tb_anotacao;

\c db_rls alice


INSERT INTO tb_anotacao (dt, title, description) VALUES
    (now(), 'Teste 1', 'Primeira anotação da Alice'),
    (now() - '2 weeks'::interval, 'Título', 'Monomonomono');

\c db_rls admin
