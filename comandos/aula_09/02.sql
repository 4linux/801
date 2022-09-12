### 3 TERMINAIS
# A (alpha)
# B (Beta)
# Y (Gamma)

Y> Criar tabela
CREATE TABLE tb_foo AS
	SELECT generate_series(1, 5)
		AS campo;
Y> Pegar OID
SELECT oid FROM pg_class WHERE relname = 'tb_foo';

A> Pegar PID Conexão
SELECT pg_backend_pid();

B> Pegar PID Conexão

SELECT pg_backend_pid();

A> 
BEGIN;
SELECT txid_current();

B> 
BEGIN;
SELECT txid_current();

Y>
SELECT
	pid, locktype, relation, tuple, transactionid, mode, granted
	FROM pg_locks
	WHERE pid IN (768, 761)
	ORDER BY pid;

A>
UPDATE tb_foo SET campo = 0 WHERE campo = 1;
TABLE tb_foo;

Y>
SELECT
	pid, locktype, relation, tuple, transactionid, mode, granted
	FROM pg_locks
	WHERE pid IN (768, 761)
	ORDER BY pid;
	
B> 	
UPDATE tb_foo SET campo = 33 WHERE campo = 3;
TABLE tb_foo;

Y>
SELECT
	pid, locktype, relation, tuple, transactionid, mode, granted
	FROM pg_locks
	WHERE pid IN (768, 761)
	ORDER BY pid;

B>
UPDATE tb_foo SET campo = 11 WHERE campo = 1;

Y>
SELECT
	pid, locktype, relation, tuple, transactionid, mode, granted
	FROM pg_locks
	WHERE pid IN (768, 761)
	ORDER BY pid;

A>	
UPDATE tb_foo SET campo = 333 WHERE campo = 3;

Y>
SELECT
	pid, locktype, relation, tuple, transactionid, mode, granted
	FROM pg_locks
	WHERE pid IN (768, 761)
	ORDER BY pid;

B> 
TABLE tb_foo;
COMMIT;
