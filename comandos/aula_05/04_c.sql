CREATE TABLE tb_anotacao(
    id serial PRIMARY KEY,
    username text DEFAULT current_user
        REFERENCES tb_usuario (username),
    dt timestamptz DEFAULT now(),
    title varchar(30),
    description text);

ALTER TABLE tb_anotacao ENABLE ROW LEVEL SECURITY;

GRANT SELECT, INSERT, UPDATE, DELETE ON tb_anotacao TO admin;

GRANT
    UPDATE (dt, title, description),
    INSERT (dt, title, description),
    SELECT, DELETE ON tb_anotacao TO PUBLIC;

GRANT USAGE ON tb_anotacao_id_seq TO PUBLIC;

CREATE POLICY po_admin_all_priv_anotacao
    ON tb_anotacao
    FOR ALL
    TO admin
    USING (true)
    WITH CHECK (true);
