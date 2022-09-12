######## Comandos para instalação no debian
echo \
    "deb http://apt.postgresql.org/pub/repos/apt `lsb_release -cs`-pgdg main" \
    > /etc/apt/sources.list.d/pgdg.list

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
apt-key add -

apt update

apt install -y postgresql

su - postgres

psql -Atqc 'SELECT version()' | \
awk '{print $1" "$2}'  # Exibindo a versão do PostgreSQL

######## Comandos para instalação no red hat 

yum install -y redhat-lsb-core curl dnf glibc-langpack-pt

dnf -qy module disable postgresql

DISTRO_VERSION=`lsb_release -r | awk '{print $2}' | cut -f1 -d.`

URL="https://download.postgresql.org/pub/repos/yum/reporpms/EL-\
${DISTRO_VERSION}-x86_64/pgdg-redhat-repo-latest.noarch.rpm"

dnf install -y ${URL}

read -p 'Versão majoritária do PostgreSQL que deseja instalar: ' PGMAJOR

dnf install -y postgresql${PGMAJOR}-server 

/usr/pgsql-${PGMAJOR}/bin/postgresql-${PGMAJOR}-setup initdb

systemctl enable --now postgresql-${PGMAJOR}
