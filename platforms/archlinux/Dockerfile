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
  && rm -rf /var/cache/pacman/pkg/* /var/tmp/* /tmp/*

# delete some systemd unit files that might cause issues and configure systemd
RUN rm -f /lib/systemd/system/{anaconda,basic,multi-user}.target.wants/* \
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
RUN pip3 install --no-cache-dir --upgrade pip \
  && pip3 install --no-cache-dir ansible cryptography

# install ansible inventory file
RUN mkdir -p /etc/ansible \
  && echo -e "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/usr/lib/systemd/systemd"]
