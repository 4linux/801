pg_ctl stop

cd `dirname "${PGDATA}"`

tar cvzf /tmp/cluster.tar.gz `basename ${PGDATA}`

tar xvf /tmp/cluster.tar.gz -C /tmp/

vim /tmp/data/postgresql.conf

pg_ctl -D /tmp/data start

psql -Atqc 'SELECT datname FROM pg_database;'

pg_ctl -D /tmp/data/ stop

pg_ctl start
