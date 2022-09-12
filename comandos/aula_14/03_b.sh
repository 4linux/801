CHKPNT_START=`psql -Atqc "SELECT pg_start_backup('${NOW}');"`

echo ${CHKPNT_START}

cat ${PGDATA}/backup_label

psql -qc "SELECT pg_walfile_name('${CHKPNT_START}');"

tar czf /var/backups/pgsql/14/data/cluster.tar.gz ${PGDATA}

CHKPNT_FINAL=`psql -Atqc "SELECT pg_stop_backup();"`

echo ${CHKPNT_FINAL}

psql -qc "SELECT pg_walfile_name('${CHKPNT_FINAL}');"

pg_ctl stop && rm -fr ${PGDATA}

tar xvf /var/backups/pgsql/14/data/cluster.tar.gz -C /

touch ${PGDATA}/recovery.signal

pg_ctl start

psql -Atqc 'SELECT datname FROM pg_database;'
