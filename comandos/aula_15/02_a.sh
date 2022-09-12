#### Comandos na sr0

## Tornar a sr0 como master novamente
pg_ctl promote 

vim ${PGDATA}/postgresql.conf
"
password_encryption = scram-sha-256
wal_level = logical  
max_replication_slots = 10 
max_wal_senders = 10
"

echo 'host all all 192.168.56.71/32 scram-sha-256' >> ${PGDATA}/pg_hba.conf

##### Remover o commit sincronico
vim /var/local/pgsql/14/conf.d/rep.conf
## Remover as linhas abaixo:
synchronous_commit = remote_apply
synchronous_standby_names = 'sr1'

pg_ctl restart

#### Comandos na sr1
vim ${PGDATA}/postgresql.conf
"
password_encryption = scram-sha-256
max_replication_slots = 10  
max_logical_replication_workers = 10 
max_worker_processes = 8
"

pg_ctl restart

#### Comandos nas duas!

psql -c "CREATE ROLE user_teste WITH REPLICATION LOGIN PASSWORD '123';"

psql -qc 'CREATE DATABASE db_teste OWNER user_teste;'

psql -d db_teste -U user_teste -qc 'CREATE TABLE tb_teste(campo int);'

###
psql -d db_teste -qc \
'CREATE PUBLICATION pb_teste FOR ALL TABLES;'

