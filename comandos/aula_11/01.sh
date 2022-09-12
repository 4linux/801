ipcs -m

sysctl vm.swappiness

echo 'vm.swappiness = 1' >> /etc/sysctl.d/pgsql.conf

sysctl -p /etc/sysctl.d/pgsql.conf

sysctl vm.swappiness

sysctl vm.overcommit_memory

echo 'vm.overcommit_memory = 2' >> /etc/sysctl.d/pgsql.conf

sysctl -p /etc/sysctl.d/pgsql.conf

sysctl vm.overcommit_memory

blockdev --report | head -1 && \
blockdev --report | egrep '(nvme0n1|sda|sdb)$'

blockdev --getra /dev/sda

blockdev --setra 4096 /dev/sda
