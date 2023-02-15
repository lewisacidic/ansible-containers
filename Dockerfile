FROM debian:bullseye
LABEL maintainer="Rich Lewis <opensource@rpil.io>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       sudo systemd systemd-sysv ca-certificates iproute2 \
       python3 python3-pip python3-wheel python3-apt \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/* \
    && apt-get clean

RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
    /lib/systemd/system/systemd-update-utmp*

RUN pip3 install --upgrade pip
RUN pip3 install ansible cryptography

RUN systemctl set-default multi-user.target

RUN mkdir -p /etc/ansible
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/lib/systemd/systemd"]
