NJOBS=`expr \`nproc\` + 1`

MAKEOPTS="-j${NJOBS}"

CHOST="x86_64-unknown-linux-gnu"

CFLAGS="-march=native -O2 -pipe"

CXXFLAGS="$CFLAGS"

./configure ${CONFIGURE_OPTS}

make world

make install-world

cat << EOF > /lib/systemd/system/postgresql-${PGMAJOR}.service
[Unit]
Description=PostgreSQL ${PGMAJOR} database server
After=syslog.target
After=network.target
[Service]
Type=forking
User=postgres
Group=postgres
Environment=PGDATA=${PGDATA}
OOMScoreAdjust=-1000    
ExecStart=${PGBIN}/pg_ctl start -D ${PGDATA} -s -w -t 300
ExecStop=${PGBIN}/pg_ctl stop -D ${PGDATA} -s -m fast
ExecReload=${PGBIN}/pg_ctl reload -D ${PGDATA} -s
TimeoutSec=300
[Install]
WantedBy=multi-user.target
EOF

chown -R postgres: /var/{log,local}/pgsql

su - postgres -c "\
    initdb \
        -D ${PGDATA} \
        -E utf8 \
        -U postgres \
        -k \
        --locale=pt_BR.utf8 \
        --lc-collate=pt_BR.utf8 \
        --lc-monetary=pt_BR.utf8 \
        --lc-messages=en_US.utf8 \
        -T portuguese \
        -X ${PGWAL}"
