###### sr0
psql -Atqc '
SELECT pg_size_pretty(
                      pg_current_wal_lsn() - 
                      replay_lsn) FROM pg_stat_replication'

###### sr1
psql -qc "
SELECT
  -- Localização WAL recebida e sincronizada para disco
  pg_last_wal_receive_lsn(),

  -- Localização WAL replicada durante recuperação
  pg_last_wal_replay_lsn(),

  -- Timestamp da última transação replicada durante recuperação
  pg_last_xact_replay_timestamp();
"

##################### Alterando para replicação síncrona
###### sr0
cat << EOF >> /var/local/pgsql/14/conf.d/rep.conf
synchronous_commit = remote_apply
synchronous_standby_names = 'sr1'
EOF

psql -Atqc "
SELECT context
  FROM pg_settings
  WHERE name IN (
                 'synchronous_commit',
                 'synchronous_standby_names');
"

pg_ctl reload

psql -tqc 'SELECT * FROM pg_stat_replication'

cat << EOF | psql -tq
\x on
SELECT * FROM pg_replication_slots;
EOF

time createdb db_teste2

###### sr1
psql -Atqc 'SELECT datname FROM pg_database'