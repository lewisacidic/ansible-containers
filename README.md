# docker-ansible

[Ansible](https://docs.ansible.com/ansible/latest/index.html)-enabled images for
various linux distributions, principally intended for testing with 
[molecule](https://molecule.readthedocs.io/en/latest/).
Available at [ghcr.io/lewisacidic/ansible](https://ghcr.io/lewisacidic/ansible).

## Available images

Currently supported distributions are:

- Ubuntu (22.04)
- Debian (Bullseye)
- OpenSUSE (15.4)
- Arch
- Fedora (37)
- Rocky (9)
- Alpine (3.17)

Each image can be pulled using an appropriate tag, i.e. ghcr.io/lewisacidic/ansible:ubuntu

Each is configured with:

- a full ansible install
- a user with passwordless sudo permissions
- the ability to be run with the appropriate init system (see below)

## Running

Init systems such as systemd, openRC and sysvinit require to run as with PID 1.
Thus, in order to run the container with the init system (e.g. to test playbooks
that interact with services) it is necessary to start the container using a few
extra flags.

For example:

```shell
docker run -v /sys/fs/cgroup:/sys/fs/cgroup:ro --privileged --cap-add SYS_ADMIN -it ghcr.io/lewisacidic/ansible:alpine
```



