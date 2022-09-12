sed "s:\(^#listen_addresses.*\):\1\nlisten_addresses = '*':g" \
-i ${PGDATA}/postgresql.conf

sed "s:\(^#log_destination.*\):\1\nlog_destination = 'stderr':g" \
-i ${PGDATA}/postgresql.conf

sed "s:\(^#logging_collector.*\):\1\nlogging_collector = on:g" \
-i ${PGDATA}/postgresql.conf

sed "s:\(^#\)\(log_filename.*\):\1\2\n\2:g" \
-i ${PGDATA}/postgresql.conf

sed "s:\(^#log_directory.*\):\1\nlog_directory = '${PGLOG}':g" \
-i ${PGDATA}/postgresql.conf

sed "s:\(^#stats_temp_directory.*\):\1\nstats_temp_directory = '${PG_STAT_TEMP}':g" \
-i ${PGDATA}/postgresql.conf

echo -e \
"\ntmpfs ${PG_STAT_TEMP} tmpfs size=32M,uid=postgres,gid=postgres 0 0"\
 >> /etc/fstab

mount -a

systemctl enable --now postgresql-${PGMAJOR}

## Debian
apt purge -y ${PKG_RM} ${PKG_DEB}

## Red hat
dnf erase -y ${PKG_RM} ${PKG_RH}
