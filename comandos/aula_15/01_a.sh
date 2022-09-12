## Com o usuário postgres, nas duas máquinas sr0 e sr1
mkdir -pm 0700 /var/local/pgsql/14/conf.d

touch /var/local/pgsql/14/conf.d/rep.conf && \
chmod 0600 /var/local/pgsql/14/conf.d/rep.conf

## Usuário postgres, sr0 apenas

rm -rf ${PGDATA}

initdb -k

pg_ctl start 

vim ${PGDATA}/postgresql.conf
"
listen_addresses = '*'
password_encryption = scram-sha-256
wal_level = replica
max_wal_senders = 3
max_replication_slots = 2
include_dir = '/var/local/pgsql/14/conf.d'
"

cat << EOF > /var/local/pgsql/14/conf.d/rep.conf
cluster_name = 'sr0'
primary_slot_name = 'rs_sr0'
EOF

psql -qc "
SELECT name, context
  FROM pg_settings
  WHERE name IN (
                 'password_encryption',
                 'wal_level',
                 'max_replication_slots',
                 'cluster_name'
                 );
"

pg_ctl restart

psql -Atqc "
CREATE USER user_rep
  WITH REPLICATION
  SUPERUSER
  ENCRYPTED PASSWORD '123';
"

psql -Atqc "SELECT pg_create_physical_replication_slot('rs_sr1');"
