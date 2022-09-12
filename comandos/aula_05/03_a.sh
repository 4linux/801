export PATH=$PATH:/usr/pgsql-14/bin

vim ${PGDATA}/postgresql.conf

"
listen_addresses = '*'
password_encryption = scram-sha-256
"

 /usr/pgsql-14/bin/pg_ctl restart

cp ${PGDATA}/pg_hba.conf ${PGDATA}/pg_hba.conf.bkp

cat << EOF | psql -Atq
ALTER ROLE bach PASSWORD '123';
ALTER ROLE beethoven PASSWORD '123';
ALTER ROLE mozart PASSWORD '123';
ALTER ROLE vivaldi PASSWORD '123';
EOF

cat << EOF > ${PGDATA}/pg_hba.conf && \
 /usr/pgsql-14/bin/pg_ctl reload && \
clear && \
cat ${PGDATA}/pg_hba.conf
local all postgres trust
host db_zero +dev 192.168.56.0/24 scram-sha-256
EOF

psql -qc 'SELECT * FROM pg_hba_file_rules;'

psql -Atqc "SELECT 'Hello, World';" -d db_zero -U beethoven
