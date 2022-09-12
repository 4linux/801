
## Como root 
mkdir /var/local/pgsql
chown postgres: /var/local/pgsql

## su - postgres

read -p 'Digite a versão majoritária: ' PGMAJOR

mkdir -pm 0700 /var/local/pgsql/14/ts/alpha

psql -qc "CREATE TABLESPACE ts_alpha \
    LOCATION '/var/local/pgsql/14/ts/alpha';"
    
psql -qc 'CREATE DATABASE db_teste TABLESPACE = ts_alpha;'

pg_basebackup \
    -X stream \
    -T /var/local/pgsql/14/ts/alpha=/var/backups/pgsql/14/ts/alpha \
    -D /var/backups/pgsql/14/data/pg_basebackup
    
sed -i  's/^port = 5432/port = 5433/g' \
    /var/backups/pgsql/14/data/pg_basebackup/postgresql.conf
    
sed -i  's/^#port = 5432/port = 5433/g' \
    /var/backups/pgsql/14/data/pg_basebackup/postgresql.conf
    
sed 's/^\(data_directory.*\)/#\1/g' -i \
    /var/backups/pgsql/14/data/pg_basebackup/postgresql.conf

sed 's/^\(hba_file.*\)/#\1/g' -i \
    /var/backups/pgsql/14/data/pg_basebackup/postgresql.conf

sed 's/^\(ident_file.*\)/#\1/g' -i \
    /var/backups/pgsql/14/data/pg_basebackup/postgresql.conf
    
sed 's/^\(external_pid_file.*\)/#\1/g' -i \
    /var/backups/pgsql/14/data/pg_basebackup/postgresql.conf
    
pg_ctl start -D /var/backups/pgsql/14/data/pg_basebackup

psql -p 5433 -qc '\db'

psql -p 5433 -Atqc 'SELECT datname FROM pg_database'

pg_ctl -D /var/backups/pgsql/14/data/pg_basebackup stop
