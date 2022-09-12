PKG_RM='bison gcc flex make'

PKG='bzip2 wget'

PKG_DEB="libreadline-dev libssl-dev libxml2-dev libldap2-dev \
uuid-dev python3-dev"

## Caso debian 
apt update && apt install -y ${PKG} ${PKG_RM} ${PKG_DEB} && \

sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
sed -i -e 's/# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen

PKG_RH="readline-devel openssl-devel libxml2-devel openldap-devel \
libuuid-devel python3 python3-devel"

## Caso Red Hat 
dnf install -y ${PKG} ${PKG_RM} ${PKG_RH} glibc-langpack-pt 

groupadd -r postgres &> /dev/null

useradd \
    -c 'PostgreSQL system user' \
    -s /bin/bash \
    -k /etc/skel \
    -d /var/local/pgsql \
    -g postgres \
    -m -r postgres  &> /dev/null

read -p \
    'Digite o número de versão completo (X.Y) do PostgreSQL a ser baixado: ' \
    PGVERSION

export PGMAJOR=`echo ${PGVERSION} | cut -f1 -d.`

PGHOME="/usr/local/pgsql/${PGMAJOR}"  # Diretório de instalação do PostgreSQL
PGBIN="${PGHOME}/bin"  # Diretório de binários executáveis
PG_LD_LIBRARY_PATH="${PGHOME}/lib"  # Diretório de bibliotecas
PG_MANPATH="${PGHOME}/man"  # Diretório de manuais
PGLOG="/var/log/pgsql/${PGMAJOR}"  # Diretório de logs
PGDATA="/var/local/pgsql/${PGMAJOR}/data"  # Diretório de dados do PostgreSQL
PGWAL="/var/local/pgsql/${PGMAJOR}/wal"  # Diretório de logs de transação
PG_STAT_TEMP="/var/local/pgsql/${PGMAJOR}/pg_stat_tmp"  # Diretório de estatísticas temporárias
