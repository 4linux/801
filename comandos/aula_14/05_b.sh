initdb -U postgres -D /tmp/cluster2

sed -i 's/^#port = 5432/port = 5433/g' /tmp/cluster2/postgresql.conf

pg_ctl -D /tmp/cluster2 start

psql -p 5433 -U postgres -Atqc 'SELECT datname FROM pg_database;'

## Dropar as databases não utilizdas
psql -Atqc \
"
SELECT datname
    FROM pg_database
    WHERE datname NOT IN ('template0', 'template1', 'postgres', 'pagila')
" | xargs -i dropdb {}

## Dropar as tablespaces
psql -Atqc \
"
SELECT spcname
    FROM pg_tablespace
    WHERE spcname NOT IN ('pg_default', 'pg_global');
" | xargs -i psql -qc "DROP TABLESPACE {};"

pg_dumpall | psql -p 5433 -U postgres

psql -d pagila -p 5433 -U postgres -Atqc \
'SELECT relname FROM pg_stat_user_tables ORDER by relname LIMIT 5'

pg_dumpall > /tmp/cluster.dump.sql

pg_dumpall | bzip2 -9 -c > /tmp/cluster.dump.sql.bz2

ls -lh /tmp/cluster.* | awk '{print $(NF) " => " $5}'

## Removendo o cluster
pg_ctl -D /tmp/cluster2 -m immediate stop && rm -fr /tmp/cluster2

## Criando novamente o cluster
initdb -U postgres -D /tmp/cluster2

sed -i 's/^#port = 5432/port = 5433/g' /tmp/cluster2/postgresql.conf

pg_ctl -D /tmp/cluster2 start

time psql -p 5433 -f /tmp/cluster.dump.sql

## Removendo o cluster
pg_ctl -D /tmp/cluster2 -m immediate stop && rm -fr /tmp/cluster2

## Criando novamente o cluster
initdb -U postgres -D /tmp/cluster2

sed -i 's/^#port = 5432/port = 5433/g' /tmp/cluster2/postgresql.conf

pg_ctl -D /tmp/cluster2 start

time bunzip2 -dc /tmp/cluster.dump.sql.bz2 | psql -p 5433

pg_ctl -D /tmp/cluster2/ stop
