#### Comandos na sr1
psql -d db_teste -qc "
CREATE SUBSCRIPTION sb_teste
  CONNECTION 'host=192.168.56.70
              port=5432
              dbname=db_teste
              user=user_teste
              password=123'
  PUBLICATION pb_teste;
"

#### Comandos na sr0
psql -d db_teste -Atqc \
'INSERT INTO tb_teste SELECT generate_series(1, 5)'

#### Comandos na sr1
psql -d db_teste -Atqc \
'SELECT campo FROM tb_teste;'

#### Executar nas duas!
psql -d db_teste -U user_teste -qc 'CREATE TABLE tb_teste2(campo int);'

#### Comandos na sr0
psql -d db_teste -Atqc \
'INSERT INTO tb_teste2 SELECT generate_series(1, 5)'

#### Comandos na sr1
psql -d db_teste -Atqc \
'SELECT campo FROM tb_teste2;'

#### Comandos na sr1
psql -d db_teste -Atqc \
'ALTER SUBSCRIPTION sb_teste REFRESH PUBLICATION;'

#### Comandos na sr1
psql -d db_teste -Atqc \
'SELECT campo FROM tb_teste2;'