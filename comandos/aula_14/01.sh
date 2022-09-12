
## Desativar a montagem em memória do /tmp
umount /tmp

dropdb --maintenance-db template1 postgres && \
createdb -T template0 --maintenance-db=template1 postgres

psql -Atqc \
"
SELECT datname
    FROM pg_database
    WHERE datname NOT IN ('template0', 'template1', 'postgres')
" | xargs -i dropdb {}

psql -Atqc \
"
SELECT spcname
    FROM pg_tablespace
    WHERE spcname NOT IN ('pg_default', 'pg_global');
" | xargs -i psql -qc "DROP TABLESPACE {};"

yum install -y wget tree

wget https://ftp.postgresql.org/pub/projects/pgFoundry/dbsamples/pagila/\
pagila/pagila-0.10.1.zip -P /tmp/ && \
cd /tmp && \
unzip pagila-0.10.1.zip

createdb pagila

psql -f pagila-0.10.1/pagila-schema.sql pagila && \
psql -f pagila-0.10.1/pagila-data.sql pagila

## Como root 
# read -p 'Digite a versão majoritária: ' PGMAJOR

export BKPDIR="/var/backups/pgsql/14"
mkdir -pm 700 ${BKPDIR}/{data,wal}
mkdir -pm 700 ${BKPDIR}/dump/{compact,custom,dir,tar,text}

chown -R postgres: /var/backups/pgsql

tree /var/backups/pgsql
