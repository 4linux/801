sed 's/ENABLED="false"/ENABLED="true"/g' -i /etc/default/sysstat

systemctl restart sysstat.service

sar -A

rm -f /var/log/sysstat/*

/usr/lib/sysstat/sadc 1 50 /var/log/sysstat/sa`date +%Y%m%d`

sar 2 10

sar -p -d 1 1
