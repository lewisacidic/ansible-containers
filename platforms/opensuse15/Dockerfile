FROM opensuse/leap:15.4
LABEL maintainer "Rich Lewis <opensource@rpil.io>"

RUN zypper up -y
RUN zypper install -y dbus-1 systemd-sysvinit && zypper clean
RUN cp /usr/lib/systemd/system/dbus.service /etc/systemd/system/; \
    sed -i 's/OOMScoreAdjust=-900//' /etc/systemd/system/dbus.service

RUN zypper install -y sudo python3 python3-pip python3-setuptools python3-wheel && zypper clean
RUN pip3 install --no-cache-dir --upgrade pip
RUN pip3 install --no-cache-dir ansible cryptography

RUN mkdir -p /etc/ansible && \
    echo -e "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/lib/systemd/systemd"]
