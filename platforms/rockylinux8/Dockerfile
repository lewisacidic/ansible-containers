FROM rockylinux:9
LABEL maintainer="Rich Lewis"

ENV container=docker
ENV ANSIBLE_USER=ansible

# update registry and install required packages
RUN yum -y install rpm dnf-plugins-core \
  && yum -y update \
  && yum -y install \
    epel-release \
    initscripts \
    sudo \
    which \
    hostname \
    libyaml \
    python3 \
    python3-pip \
    python3-pyyaml \
  && yum clean all
# enable systemd
RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
  /etc/systemd/system/*.wants/* \
  /lib/systemd/system/local-fs.target.wants/* \
  /lib/systemd/system/sockets.target.wants/*udev* \
  /lib/systemd/system/sockets.target.wants/*initctl* \
  /lib/systemd/system/basic.target.wants/* \
  /lib/systemd/system/anaconda.target.wants/*

# Create ansible user
RUN useradd -lm ${ANSIBLE_USER} \
  && echo "%${ANSIBLE_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# update pip and install ansible
RUN pip3 install --no-cache-dir --upgrade pip \
  && pip3 install --no-cache-dir ansible cryptography

# Disable requiretty.
RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]
