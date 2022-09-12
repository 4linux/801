CREATE TABLE tb_foo (campo int);

CREATE INDEX idx_teste ON tb_foo (campo);

INSERT INTO tb_foo (campo) SELECT generate_series(1, 1000000);

ALTER INDEX idx_teste SET (fillfactor = 70);

REINDEX INDEX idx_teste;

DROP TABLE tb_foo;

