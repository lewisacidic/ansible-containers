FROM debian:bullseye
LABEL maintainer="Rich Lewis <opensource@rpil.io>"

ENV ANSIBLE_USER=ansible
ENV container=docker

ENV DEBIAN_FRONTEND=noninteractive

# update registry and install required packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
      sudo \
      systemd \
      systemd-sysv \
      build-essential \
      wget \
      libffi-dev \
      libssl-dev \
      procps \
      ca-certificates \
      iproute2 \
      python3-dev \
      python3-pip \
      python3-setuptools \
      python3-wheel \
      python3-apt \
  && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/* \
  && rm -Rf /usr/share/doc /usr/share/man \
  && apt-get clean \
  && rm -rf /var/tmp/* /tmp/*

# delete some systemd unit files that might cause issues and configure systemd
RUN rm -f \
    /lib/systemd/system/{anaconda,basic,multi-user}.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
    /lib/systemd/system/systemd-update-utmp* \
  && systemctl set-default multi-user.target

# Create ansible user
RUN useradd -lm ${ANSIBLE_USER} \
  && echo -e "%${ANSIBLE_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# update pip and install ansible
RUN pip3 install --upgrade --no-cache-dir pip \
  && pip3 install --no-cache-dir ansible cryptography

# install ansible inventory file
RUN mkdir -p /etc/ansible \
  && echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/lib/systemd/systemd"]
