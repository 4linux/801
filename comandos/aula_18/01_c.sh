read -p 'Digite a versão antiga: ' PGMAJOR_OLD

read -p 'Digite a versão nova: ' PGMAJOR_NEW

export PGDATAOLD="/var/lib/pgsql/${PGMAJOR_OLD}/data"
export PGDATANEW="/var/lib/pgsql/${PGMAJOR_NEW}/data"
export PGBINOLD="/usr/pgsql-${PGMAJOR_OLD}/bin"
export PGBINNEW="/usr/pgsql-${PGMAJOR_NEW}/bin"

${PGBINOLD}/pg_ctl -m f -D ${PGDATAOLD} stop

${PGBINNEW}/pg_ctl -m f -D ${PGDATANEW} stop

${PGBINNEW}/pg_upgrade

sed -i "s/port = 5433/port = 5432/g" ${PGDATANEW}/postgresql.conf

${PGBINNEW}/pg_ctl start -D ${PGDATANEW}

./analyze_new_cluster.sh

./delete_old_cluster.sh
