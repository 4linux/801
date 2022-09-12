CREATE INDEX idx_spgist ON tb_foo USING spgist (faixa);
CREATE INDEX idx_spgist_op_class ON tb_foo USING spgist (faixa range_ops);

EXPLAIN ANALYZE
SELECT
  id,
  faixa
  FROM tb_foo
  WHERE faixa @> 777;

SELECT
    indexname indice,
    pg_size_pretty(pg_relation_size(indexname::text)) tamanho
    FROM pg_indexes
    WHERE tablename = 'tb_foo';

DROP TABLE tb_foo;
