CREATE TABLE tb_x(campo int);

SELECT txid_current();

INSERT INTO tb_x (campo)
	SELECT generate_series(1, 3);

BEGIN;

SELECT xmin, xmax, campo FROM tb_x;

UPDATE tb_x SET campo = 33 WHERE campo = 3;

DELETE FROM tb_x WHERE campo = 2;
ROLLBACK;
