psql -Atqc "SELECT 'Hello, World';" -d db_zero -U mozart -h 192.168.56.70

psql -Atqc "SELECT 'Hello, World';" -d db_zero -U vivaldi -h 192.168.56.70

cat << EOF > ${PGDATA}/pg_hba.conf && \
pg_ctl reload && \
clear && \
cat ${PGDATA}/pg_hba.conf
local all postgres trust
host all all 127.0.0.1/32 scram-sha-256
host db_zero +dev 192.168.56.0/24 scram-sha-256
EOF

psql -Atqc "SELECT 'Hello, World';" -d db_zero -U beethoven -h 192.168.56.70

psql -Atqc "SELECT 'Hello, World';" -d db_zero -U beethoven -h 127.0.0.1

cat ${PGDATA}/pg_hba.conf.bkp > ${PGDATA}/pg_hba.conf && pg_ctl reload

cat << EOF > ~/.pgpass
# hostname:port:database:username:password
127.0.0.1:5432:*:*:123
EOF

chmod 0600 ~/.pgpass

psql -p 5432 -h 127.0.0.1 -U beethoven -d db_one

cat << EOF >> ~/.pg_service.conf
[meubd]
host=127.0.0.1
port=5432
dbname=postgres
user=postgres
EOF

psql

\password

psql service=meubd
