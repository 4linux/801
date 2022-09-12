## Usuário postgres, sr0
cat << EOF >> ${PGDATA}/pg_hba.conf

# App connection =============================================================
host postgres user_rep 192.168.56.70/32 scram-sha-256
host postgres user_rep 192.168.56.71/32 scram-sha-256

# Streaming replication ======================================================
host replication user_rep 192.168.56.70/32 scram-sha-256
host replication user_rep 192.168.56.71/32 scram-sha-256
EOF

pg_ctl reload

##### Usuário postgres, sr1
pg_ctl stop && rm -fr ${PGDATA}

DBCONN='host=192.168.56.70 dbname=postgres user=user_rep password=123'
pg_basebackup -D ${PGDATA} -Fp -Xs -P -R -d "${DBCONN}"

cat << EOF > /var/local/pgsql/14/conf.d/rep.conf
cluster_name = 'sr1'
primary_slot_name = 'rs_sr1'
autovacuum = off
EOF

chmod 0600 /var/local/pgsql/14/conf.d/rep.conf

pg_ctl start

psql -Atqc 'SELECT pg_is_in_recovery()'

###### sr0
psql -Atqc 'SELECT pg_is_in_recovery()'

time createdb db_teste

###### sr1
psql -Atqc 'SELECT datname FROM pg_database'

###### sr0
psql -tqc 'SELECT * FROM pg_stat_replication'

cat << EOF | psql -qt
\x on
SELECT * FROM pg_replication_slots;
EOF

###### sr1
psql -tqc 'SELECT * FROM pg_stat_wal_receiver'

psql -Atqc 'SELECT now() - pg_last_xact_replay_timestamp()'

###### sr0
psql -Atqc 'SELECT pg_current_wal_lsn() - replay_lsn FROM pg_stat_replication'
