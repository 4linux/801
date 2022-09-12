CREATE TABLE tb_cidade (
    uf CHAR(2),
    nome VARCHAR(50)
    ) PARTITION BY LIST (uf);

CREATE TABLE tb_cidade_sul
    PARTITION OF tb_cidade
    FOR VALUES IN ('RS', 'SC', 'PR');

CREATE TABLE tb_cidade_sudeste
    PARTITION OF tb_cidade
    FOR VALUES IN ('SP', 'RJ', 'MG', 'ES');

CREATE TABLE tb_cidade_centro_oeste
    PARTITION OF tb_cidade
    FOR VALUES IN ('DF', 'GO', 'MS', 'MT');

CREATE TABLE tb_cidade_nordeste
    PARTITION OF tb_cidade
    FOR VALUES IN ('MA', 'PI', 'CE', 'RN', 'PB', 'PE', 'AL', 'SE', 'BA');

CREATE TABLE tb_cidade_norte
    PARTITION OF tb_cidade
    FOR VALUES IN ('AC', 'AM', 'RO', 'RR', 'AP', 'PA', 'TO');

INSERT INTO tb_cidade (uf, nome) VALUES
    ('SP', 'São Paulo'),
    ('SP', 'Santo André'),
    ('SP', 'São Bernardo do Campo'),
    ('RJ', 'Niterói'),
    ('MG', 'Belo Horizonte'),
    ('MG', 'Varginha'),
    ('RN', 'Natal'),
    ('RO', 'Porto Velho'),
    ('RS', 'Porto Alegre'),
    ('PR', 'Curitiba');

SELECT uf, nome FROM tb_cidade;

SELECT uf, nome FROM tb_cidade_sul;

SELECT uf, nome FROM tb_cidade_sudeste;

DROP TABLE tb_cidade;
