psql -d pagila -qc "
SELECT
    relname tabela
    FROM pg_stat_user_tables
    ORDER by tabela LIMIT 5;
"

## read -p 'Digite a versão majoritária: ' PGMAJOR

pg_dump -j7 -Fd pagila -f /var/backups/pgsql/14/dump/dir

dropdb pagila && createdb pagila

pg_restore -d pagila -j7 -Fd /var/backups/pgsql/14/dump/dir

psql -d pagila -qc "
SELECT
    relname tabela
    FROM pg_stat_user_tables
    ORDER by tabela LIMIT 5;
"

pg_dump -Ft pagila > /var/backups/pgsql/14/dump/tar/pagila.tar

dropdb pagila && createdb pagila

pg_restore -d pagila -Ft /var/backups/pgsql/14/dump/tar/pagila.tar

psql -d pagila -qc "
SELECT
    relname tabela
    FROM pg_stat_user_tables
    ORDER by tabela LIMIT 5;
"

pg_dump -Fc pagila > /var/backups/pgsql/14/dump/custom/pagila.dump

dropdb pagila && createdb pagila

pg_restore -j5 -d pagila \
  -Fc /var/backups/pgsql/14/dump/custom/pagila.dump

psql -d pagila -qc "
SELECT
    relname tabela
    FROM pg_stat_user_tables
    ORDER by tabela LIMIT 5;
"

pg_dump -C pagila > /var/backups/pgsql/14/dump/text/pagila.sql

dropdb pagila

psql -f /var/backups/pgsql/14/dump/text/pagila.sql

psql -d pagila -qc "
SELECT
    relname tabela
    FROM pg_stat_user_tables
    ORDER by tabela LIMIT 5;
"

pg_dump -C pagila | \
  gzip -9 > /var/backups/pgsql/14/dump/compact/pagila.gz

dropdb pagila

gunzip -c /var/backups/pgsql/14/dump/compact/pagila.gz | psql

psql -d pagila -qc "
SELECT
    relname tabela
    FROM pg_stat_user_tables
    ORDER by tabela LIMIT 5;
"

pg_dump -C pagila | \
  bzip2 -9 > /var/backups/pgsql/14/dump/compact/pagila.bz2
  
dropdb pagila

bunzip2 -c /var/backups/pgsql/14/dump/compact/pagila.bz2 | psql

psql -d pagila -qc "
SELECT
    relname tabela
    FROM pg_stat_user_tables
    ORDER by tabela LIMIT 5;
"

du -hs /var/backups/pgsql/14/dump/* | \
fgrep -v compact && \
du -hs /var/backups/pgsql/14/dump/compact/*
