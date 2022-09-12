./configure --prefix /usr/local/repmgr/${PGMAJOR} && make && make install

apt purge -y ${PKG}

mkdir -pm 700 {/etc,/var/log}/repmgr/${PGMAJOR}

chown -R postgres: {/etc,/var/log}/repmgr ~postgres/

cat << EOF > /lib/systemd/system/repmgrd-${PGMAJOR}.service
[Unit]
Description=A replication manager, and failover management tool for PostgreSQL
After=syslog.target
After=network.target
After=postgresql-${PGMAJOR}.service
[Service]
Type=forking
User=postgres
Group=postgres
PIDFile=/var/run/repmgr/${PGMAJOR}/repmgrd.pid
# Where to send early-startup messages from the server 
# This is normally controlled by the global default set by systemd
# StandardOutput=syslog
ExecStart=${PGBIN}/repmgrd \
-f /etc/repmgr/${PGMAJOR}/repmgr.conf -p /var/run/repmgr/${PGMAJOR}/repmgrd.pid -d --verbose
ExecStop=kill -TERM \`cat /var/run/repmgr/${PGMAJOR}/repmgrd.pid\`
ExecReload=kill -HUP \`cat /var/run/repmgr/repmgrd.pid\`
# Give a reasonable amount of time for the server to start up/shut down
TimeoutSec=300
[Install]
WantedBy=multi-user.target
EOF

systemctl enable repmgrd-${PGMAJOR}.service

cat << EOF > /usr/lib/tmpfiles.d/repmgr-${PGMAJOR}.conf
d /var/run/repmgr/${PGMAJOR} 0755 postgres postgres -
EOF

systemd-tmpfiles --create

echo "export REPMGRDCONF='/etc/repmgr/${PGMAJOR}/repmgr.conf'" >> \
~postgres/.pgvars

read -p 'Digite o ID do nó: ' NODEID

touch /etc/repmgr/${PGMAJOR}/repmgr.conf

chown -R postgres: /etc/repmgr

