#!/bin/bash

set -e

# Uninstall installed docker
yum -y remove docker docker-client docker-client-latest docker-common \
    docker-latest docker-latest-logrotate docker-logrotate docker-selinux \
    docker-engine-selinux docker-engine

# Set up repository
yum -y install yum-utils device-mapper-persistent-data lvm2

# Use Aliyun Docker
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# Install docker
# on a new system with yum repo defined, forcing older version and ignoring obsoletes introduced by 17.06.0
yum makecache fast
yum install -y --setopt=obsoletes=0 \
   docker-ce-17.03.2.ce-1.el7.centos.x86_64 \
   docker-ce-selinux-17.03.2.ce-1.el7.centos.noarch


# Config Images Sources
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["http://3272dd08.m.daocloud.io"]
}
EOF

systemctl daemon-reload
systemctl enable docker
systemctl start docker

docker version
