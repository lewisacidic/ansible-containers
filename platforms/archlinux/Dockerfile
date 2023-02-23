FROM docker.io/archlinux:latest
LABEL maintainer="Rich Lewis <opensource@rpil.io>"

ENV ANSIBLE_USER=ansible
ENV container=docker

# update registry and install required packages
RUN pacman --noconfirm -Syyu \
  && pacman --noconfirm -S \
    python \
    python-pip \
    python-wheel \
    which \
    sudo \
  && rm /var/cache/pacman/pkg/*

# enable systemd
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
  && rm -f /lib/systemd/system/multi-user.target.wants/* \
           /etc/systemd/system/*.wants/* \
           /lib/systemd/system/local-fs.target.wants/* \
           /lib/systemd/system/sockets.target.wants/*udev* \
           /lib/systemd/system/sockets.target.wants/*initctl* \
           /lib/systemd/system/basic.target.wants/*

# Create ansible user
RUN useradd -lm ${ANSIBLE_USER} && \
  && echo "%${ANSIBLE_USER} ALL=(ALL) NOPASSWD: ALL >> /etc/sudoers

# update pip and install ansible
RUN pip3 install --no-cache-dir --upgrade pip \
  && pip3 install --no-cache-dir ansible cryptography

# install ansible inventory file
RUN mkdir -p /etc/ansible \
    && echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]
