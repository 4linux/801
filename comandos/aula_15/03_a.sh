cat << EOF >> /etc/hosts

# Cluster repmgr =============================================================
192.168.56.71  alpha    alpha.local
192.168.56.72  beta     beta.local
192.168.56.73  gamma    gamma.local
192.168.56.74  omega    omega.local
EOF

hostnamectl set-hostname <hostname>

 init 6

read -p \
    'Digite a versão majoritária: ' \
    PGMAJOR

export PG_HOME="/usr/local/pgsql/${PGMAJOR}"
export PGDATA="/var/local/pgsql/${PGMAJOR}/data"
export PGBIN="${PG_HOME}/bin"
export REPMGR_HOME="/usr/local/repmgr/${PGMAJOR}"
export PATH="${PGBIN}:${PATH}"

export PKG="\
gcc \
make \
flex \
libxslt1-dev \
libxml2-dev \
libselinux1-dev \
libpam0g-dev \
libssl-dev \
libkrb5-dev \
libedit-dev \
zlib1g-dev \
libreadline-dev \
wget
"

apt update && apt install -y wget ${PKG} && apt clean

read -p 'Digite a versão (X.Y.Z) do repmgr a ser baixada: ' REPMGR_VERSION

export REPMGR_URL="https://repmgr.org/download/repmgr-${REPMGR_VERSION}.tar.gz"

wget -c ${REPMGR_URL} -P /tmp/

cd /tmp/ && tar xvf repmgr-${REPMGR_VERSION}.tar.gz && cd repmgr-${REPMGR_VERSION}

