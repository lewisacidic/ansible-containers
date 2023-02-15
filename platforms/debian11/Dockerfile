FROM debian:bullseye
LABEL maintainer="Rich Lewis <opensource@rpil.io>"

ENV container=docker
ENV DEBIAN_FRONTEND=noninteractive

# update registry install required packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
      sudo systemd systemd-sysv build-essential wget \
      libffi-dev libssl-dev procps ca-certificates iproute2 \
      python3-dev python3-pip python3-setuptools python3-wheel python3-apt \
  && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/* \
  && rm -Rf /usr/share/doc /usr/share/man \
  && apt-get clean

# enable systemd
RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
  /etc/systemd/system/*.wants/* \
  /lib/systemd/system/local-fs.target.wants/* \
  /lib/systemd/system/sockets.target.wants/*udev* \
  /lib/systemd/system/sockets.target.wants/*initctl* \
  /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
  /lib/systemd/system/systemd-update-utmp* \
  && systemctl set-default multi-user.target

# update pip and install ansible
RUN pip3 install --upgrade --no-cache-dir pip \
  && pip3 install --no-cache-dir ansible cryptography

# install ansible inventory file
RUN mkdir -p /etc/ansible
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/lib/systemd/systemd"]
