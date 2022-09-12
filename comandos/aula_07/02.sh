cat << EOF >> ~/.bash_profile
export PGMAJOR=14
export PATH=$PATH:/usr/pgsql-${PGMAJOR}/bin
EOF

source ~/.bash_profile

pg_ctl stop

postgres \
    -c log_connections=yes \
    -c log_destination='stderr' \
    -c port=5433 \
    -c log_disconnections=yes \
    -c logging_collector=off

psql -p 5433

pg_ctl start

export PGOPTIONS="-c work_mem=12MB"
psql -Atqc 'SHOW work_mem;'
