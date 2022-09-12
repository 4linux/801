read -p 'Digite a versão antiga: ' PGMAJOR_OLD

read -p 'Digite a versão nova: ' PGMAJOR_NEW

PGDATAOLD="/var/local/pgsql/${PGMAJOR_OLD}/data"
PGDATANEW="/var/local/pgsql/${PGMAJOR_NEW}/data"
PGBINOLD="/usr/local/pgsql/${PGMAJOR_OLD}/bin"
PGBINNEW="/usr/local/pgsql/${PGMAJOR_NEW}/bin"

${PGBINOLD}/pg_ctl -m f -D ${PGDATAOLD} stop

${PGBINNEW}/pg_ctl -m f -D ${PGDATANEW} stop

pg_upgrade

sed -i 's/port = 5433/port = 5432/g' ${PGDATANEW}/postgresql.conf

${PGBINNEW}/pg_ctl -D ${PGDATANEW} start

./analyze_new_cluster.sh

./delete_old_cluster.sh

