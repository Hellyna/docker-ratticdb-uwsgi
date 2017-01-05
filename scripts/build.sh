set -e

export HOME=/root
cd

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y --no-install-recommends \
  build-essential \
  ca-certificates \
  gettext \
  git \
  libldap2-dev \
  libpq-dev \
  libsasl2-dev \
  libxml2-dev \
  libxslt-dev \
  python-pip \
  python2.7 \
  python2.7-dev

mkdir -p /srv

git clone --depth 2 https://github.com/Hellyna/RatticWeb.git /srv/rattic

rm -rvf /srv/rattic/.git

pip install -r /srv/rattic/requirements-pgsql.txt
pip install jinja2 uwsgi

apt-get purge -y \
  build-essential \
  ca-certificates \
  git \
  libldap2-dev \
  libpq-dev \
  libsasl2-dev \
  libxml2-dev \
  libxslt-dev \
  python-pip

apt-get install -y --no-install-recommends \
  libldap-2.4 \
  libpq5 \
  libsasl2-2 \
  libxml2 \
  libxslt1.1

update-alternatives --install \
  /usr/bin/python python /usr/bin/python2.7 1

apt-get autoremove -y
apt-get clean -y
rm -rvf /var/lib/apt/lists/*
rm -rvf /var/tmp/*
rm -rvf /tmp/*

set +e
