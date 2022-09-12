tail -14 ${PGDATA}/pg_hba.conf

vim ${PGDATA}/postgresql.conf
"
listen_addresses = '*'
wal_level = replica
archive_mode = on
archive_command = '/bin/true'
max_wal_senders = 10
max_replication_slots = 10
hot_standby = on
shared_preload_libraries = 'repmgr'
"

vim ${PGDATA}/postgresql.conf
"
listen_addresses = '*'
shared_preload_libraries = 'repmgr'
"

systemctl restart postgresql-${PGMAJOR}.service

psql << EOF
-- Criação do usuário do repmgr
CREATE ROLE user_repmgr
    REPLICATION
    LOGIN
    SUPERUSER;

-- Criação da base de dados (metadados) do repmgr:
CREATE DATABASE db_repmgr OWNER user_repmgr;
EOF

su - postgres -c "ssh-keygen -P '' -t rsa -f ~/.ssh/id_rsa"

cat << EOF > /tmp/nodes.txt
192.168.56.71
192.168.56.72
192.168.56.73
192.168.56.74
alpha
beta
gamma
omega
alpha.local
beta.local
gamma.local
omega.local
EOF
