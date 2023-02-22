FROM opensuse/leap:15.4
LABEL maintainer "Rich Lewis <opensource@rpil.io>"

ENV ANSIBLE_USER=ansible
ENV container=docker
#
# Create ansible user
RUN useradd -lm ${ANSIBLE_USER} \
  && echo "%${ANSIBLE_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# update registry and install required packages
RUN zypper up -y \
    && zypper install -y dbus-1 systemd-sysvinit sudo python3 python3-pip python3-setuptools python3-wheel \
    && zypper clean

# enable systemd
RUN cp /usr/lib/systemd/system/dbus.service /etc/systemd/system/; \
    sed -i 's/OOMScoreAdjust=-900//' /etc/systemd/system/dbus.service

# update pip and install ansible
RUN pip3 install --no-cache-dir --upgrade pip \
  && pip3 install --no-cache-dir ansible cryptography

# install ansible inventory file
RUN mkdir -p /etc/ansible && \
    echo -e "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]
