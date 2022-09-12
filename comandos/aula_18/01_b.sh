read -p 'Digite a versão antiga: ' PGMAJOR_OLD

read -p 'Digite a versão nova: ' PGMAJOR_NEW

export CONFIGOLD="/etc/postgresql/${PGMAJOR_OLD}/main"
export CONFIGNEW="/etc/postgresql/${PGMAJOR_NEW}/main"
export PGDATAOLD="/var/lib/postgresql/${PGMAJOR_OLD}/main"
export PGDATANEW="/var/lib/postgresql/${PGMAJOR_NEW}/main"
export PGBINOLD="/usr/lib/postgresql/${PGMAJOR_OLD}/bin"
export PGBINNEW="/usr/lib/postgresql/${PGMAJOR_NEW}/bin"

${PGBINOLD}/pg_ctl -m f -D ${PGDATAOLD} stop

${PGBINNEW}/pg_ctl -m f -D ${PGDATANEW} stop

${PGBINNEW}/pg_upgrade \
  -o "-c config_file=${CONFIGOLD}/postgresql.conf" \
  -O "-c config_file=${CONFIGNEW}/postgresql.conf"


sed -i "s/port = 5433/port = 5432/g" ${CONFIGNEW}/postgresql.conf

${PGBINNEW}/pg_ctl start -D ${CONFIGNEW}

./analyze_new_cluster.sh

./delete_old_cluster.sh
