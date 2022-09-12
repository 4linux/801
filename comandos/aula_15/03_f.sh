initdb \
-D ${PGDATA} \
-E utf8 \
-U postgres \
-k \
--locale=pt_BR.utf8 \
--lc-collate=pt_BR.utf8 \
--lc-monetary=pt_BR.utf8 \
--lc-messages=en_US.utf8 \
-T portuguese \
-X /var/local/pgsql/${PGMAJOR}/wal

mv /tmp/{postgresql,pg_hba}.conf ${PGDATA}/

pg_ctl start

psql -f /tmp/omega.sql

repmgr \
    -d db_repmgr \
    -U user_repmgr \
    -h alpha \
    -f ${REPMGRDCONF} \
    --verbose witness register

systemctl restart repmgrd-${PGMAJOR} && \
systemctl status repmgrd-${PGMAJOR}

systemctl stop postgresql-${PGMAJOR}.service

tail -F /var/log/repmgr/${PGMAJOR}/repmgrd.log

repmgr -f ${REPMGRDCONF} cluster show

repmgr -f ${REPMGRDCONF} \
    node rejoin \
    -d 'host=beta user=user_repmgr dbname=db_repmgr port=5432' \
    --force-rewind

repmgr -f ${REPMGRDCONF} standby switchover

repmgr -f ${REPMGRDCONF} standby follow --upstream-node-id=1

repmgr -F \
    -d db_repmgr \
    -U user_repmgr \
    -h alpha \
    -f ${REPMGRDCONF} \
    --verbose witness register
