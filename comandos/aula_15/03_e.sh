export NODES=`cat /tmp/nodes.txt`

for NODE in ${NODES}; do
    cat ~postgres/.ssh/id_rsa.pub | \
    xargs -i ssh ${NODE} \
    "su - postgres -c 'echo {} >> ~postgres/.ssh/authorized_keys'"
    su - postgres -c "ssh -oStrictHostKeyChecking=no ${NODE} hostname"
done

repmgr -f ${REPMGRDCONF} primary register

repmgr -f ${REPMGRDCONF} cluster show

psql -qc 'SELECT * FROM repmgr.nodes;' -h alpha -U user_repmgr db_repmgr

pg_ctl -m i stop

repmgr -c -h alpha -U user_repmgr -d db_repmgr\
 -f ${REPMGRDCONF} -F standby clone

pg_ctl start

repmgr -f ${REPMGRDCONF} standby register

cat << EOF > /etc/repmgr/${PGMAJOR}/repmgr.conf
node_id=${NODEID}
node_name='`hostname`'
conninfo='host=`hostname` user=user_repmgr dbname=db_repmgr connect_timeout=2'
data_directory='${PGDATA}'
pg_bindir='${PGBIN}'
use_replication_slots='yes'
# Log
log_level=INFO
log_file='/var/log/repmgr/${PGMAJOR}/repmgrd.log'
log_status_interval=300
EOF

read -p \
    'Digite a versão majoritária: ' \
    PGMAJOR

pg_dumpall > /tmp/omega.sql

cp -v ${PGDATA}/{postgresql,pg_hba}.conf /tmp/

pg_ctl -m i stop

rm -fr /var/local/pgsql/${PGMAJOR}/{wal,data}
