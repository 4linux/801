###### sr0
pg_ctl stop

###### sr1
pg_ctl promote

psql -Atqc 'SELECT pg_is_in_recovery()'

dropdb db_teste
dropdb db_teste2

psql -Atqc 'SELECT datname FROM pg_database'

sed 's/\(^autovacuum = off\)/\1\nautovacuum = on/g' -i \
/var/local/pgsql/14/conf.d/rep.conf

pg_ctl reload

psql -Atqc "SELECT pg_create_physical_replication_slot('rs_sr0');"

###### sr0
echo "autovacuum = off" >> /var/local/pgsql/14/conf.d/rep.conf

## pg_rewind resynchronizes a PostgreSQL cluster with another copy of the cluster.
DBCONN='host=192.168.56.71 dbname=postgres user=user_rep password=123'
pg_rewind -P -R \
  -D ${PGDATA} \
  --source-server="${DBCONN}"

pg_ctl start
