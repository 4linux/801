cat << EOF > ~postgres/.pgvars
# Environment Variables
export LD_LIBRARY_PATH="${PG_LD_LIBRARY_PATH}:\${LD_LIBRARY_PATH}" 
export MANPATH="${PG_MANPATH}:\${MANPATH}"
export PATH="${PGBIN}:\${PATH}"
export PGDATA="${PGDATA}"
EOF

if [ -f ~postgres/.bash_profile ]; then
    echo -e "\nsource ~/.pgvars" >> ~postgres/.bash_profile
else
    echo -e "\nsource ~/.pgvars" >> ~postgres/.profile
fi

cat << EOF > ~postgres/.psqlrc
\set HISTCONTROL ignoreboth
\set COMP_KEYWORD_CASE upper
\x auto
EOF

mkdir -pm 0700 ${PGLOG} ${PGDATA} ${PGWAL} ${PG_STAT_TEMP}

wget -c \
https://ftp.postgresql.org/pub/source/v${PGVERSION}/postgresql-\
${PGVERSION}.tar.bz2 -P /tmp/

cd /tmp/ && tar xf postgresql-${PGVERSION}.tar.bz2

cd postgresql-${PGVERSION}

export PYTHON=`which python3`  # Variável de ambiente do executável Python 3

CONFIGURE_OPTS="
    --prefix=${PGHOME} \
    --with-python \
    --with-libxml \
    --with-openssl \
    --with-ldap \
    --with-uuid=e2fs \
    --includedir=/usr/local/include/pgsql/${PGMAJOR}
"

CPPFLAGS="-DLINUX_OOM_SCORE_ADJ=0"
