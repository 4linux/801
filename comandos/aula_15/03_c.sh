cat << EOF > /etc/repmgr/${PGMAJOR}/repmgr.conf
node_id=${NODEID}
node_name='`hostname`'
conninfo='host=`hostname` user=user_repmgr dbname=db_repmgr\
 connect_timeout=2'
data_directory='${PGDATA}'
pg_bindir='${PGBIN}'
use_replication_slots='yes'
witness_sync_interval=15
# repmgrd
failover=automatic
promote_command='${PGBIN}/repmgr standby promote\
 -f /etc/repmgr/${PGMAJOR}/repmgr.conf --log-to-file'
follow_command='${PGBIN}/repmgr standby follow\
 -f /etc/repmgr/${PGMAJOR}/repmgr.conf --log-to-file --upstream-node-id=%n'
# Log
log_level=INFO
log_file='/var/log/repmgr/${PGMAJOR}/repmgrd.log'
log_status_interval=300
EOF

read -p 'Digite os IPs dos nós (separados por um espaço): ' IP

cat << EOF >> ${PGDATA}/pg_hba.conf

# REPMGR ======================================================================
# repmgr database
EOF

for i in ${IP}
do
	echo "host  db_repmgr  user_repmgr  ${i}/32 trust" >> \
    ${PGDATA}/pg_hba.conf
done

cat << EOF >> ${PGDATA}/pg_hba.conf

# Replication
EOF

for i in ${IP}
do
	echo "host  replication  user_repmgr  ${i}/32 trust" >> \
    ${PGDATA}/pg_hba.conf
done

cat << EOF >> ${PGDATA}/pg_hba.conf
# =============================================================================
EOF

