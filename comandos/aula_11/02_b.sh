mkdir /var/log/pgbouncer

chmod 770 ~pgbouncer /etc/pgbouncer /var/log/pgbouncer

chmod 660 /etc/pgbouncer/*

chown -R pgbouncer:postgres ~pgbouncer /var/log/pgbouncer /etc/pgbouncer

SQL="SELECT rolpassword FROM pg_authid WHERE rolname = 'aluno';"

HASH_PWD=`su - postgres -c "psql -Atqc \"${SQL}\""`

echo "\"aluno\" \"${HASH_PWD}\"" > /etc/pgbouncer/userlist.txt

cat << EOF > /etc/pgbouncer/pgbouncer.ini
[databases]
* = host=127.0.0.1 port=5432

[pgbouncer]
listen_addr = 127.0.0.1
auth_type = scram-sha-256
auth_file = /etc/pgbouncer/userlist.txt
logfile = /var/log/pgbouncer/pgbouncer.log
admin_users = postgres
pool_mode = session
default_pool_size=90
max_client_conn=3000
EOF
