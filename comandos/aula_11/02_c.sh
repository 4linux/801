cat << EOF > /etc/systemd/system/pgbouncer.service 
[Unit]
Description=connection pooler for PostgreSQL
Documentation=man:pgbouncer(1)
Documentation=https://www.pgbouncer.org/
After=network.target
#Requires=pgbouncer.socket

[Service]
Type=notify
User=pgbouncer
ExecStart=/usr/local/pgbouncer/bin/pgbouncer /etc/pgbouncer/pgbouncer.ini
ExecReload=/bin/kill -HUP \${MAINPID}
KillSignal=SIGINT
#LimitNOFILE=1024

[Install]
WantedBy=multi-user.target
EOF

cat << EOF > /etc/security/limits.d/pgbouncer.conf
pgbouncer   soft    nofile 30000
pgbouncer   hard    nofile 30000
EOF

systemctl enable --now pgbouncer.service

apt purge -y ${PKG} ${PKG_DEB}

createdb db_bench

pgbench -i db_bench

psql -Atqc 'SHOW max_connections;'

pgbench -U aluno -c 500 -t 10 db_bench

pgbench -U aluno -c 500 -t 10 -p 6432 db_bench
