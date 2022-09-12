SET default_statistics_target = 1;

CREATE TABLE tb_teste_stat
	AS SELECT (random() * 1000000)::int AS campo
		FROM generate_series(1, 10000000);

SELECT count(*) FROM pg_stats WHERE tablename = 'tb_teste_stat';

ANALYZE VERBOSE tb_teste_stat;

SET default_statistics_target = 2;

ANALYZE VERBOSE tb_teste_stat;

SELECT count(*) FROM pg_stats WHERE tablename = 'tb_teste_stat';

SET default_statistics_target = 10;

ANALYZE VERBOSE tb_teste_stat;

SET default_statistics_target = 1000;

ANALYZE VERBOSE tb_teste_stat;

EXPLAIN ANALYZE SELECT count(*) FROM tb_teste_stat WHERE campo % 17 = 0;

DROP TABLE tb_teste_stat;

 SET default_statistics_target = 1;
 
 CREATE TABLE tb_teste_stat
	AS SELECT (random() * 1000000)::int AS campo
		FROM generate_series(1, 10000000);
		
EXPLAIN ANALYZE SELECT count(*) FROM tb_teste_stat WHERE campo % 17 = 0;

