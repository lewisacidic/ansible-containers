FROM alpine:3.17
LABEL maintainer="Rich Lewis"

ENV container=docker
ENV ANSIBLE_USER=ansible

RUN apk --no-cache add \
  sudo \
  ca-certificates \
  rsync \
  git \
  openrc \
  python3 \
  py3-pip \
  python3-dev \
  libffi-dev \
  musl-dev \
  gcc \
  libressl-dev \
  build-base

# Create ansible user
RUN adduser ${ANSIBLE_USER} -D -G wheel \
  && echo -e "%${ANSIBLE_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# update pip and install ansible
RUN pip3 install --no-cache-dir --upgrade pip \
  && pip3 install --no-cache-dir ansible cryptography

# Disable requiretty.
RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/sbin/init"]
