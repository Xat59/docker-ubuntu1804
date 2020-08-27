FROM ubuntu:18.04
LABEL maintainer="Xat59"

ENV pip_packages="ansible"

# Install RPM packages via YUM
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
    apt-utils \
    locales \
    python3-setuptools \
    python3-pip \
    software-properties-common \
    rsyslog systemd systemd-cron sudo iproute2 \
&& rm -Rf /var/lib/apt/lists/* \
&& rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
&& apt-get clean

# Disable kernel log module
RUN sed -i 's/^\($ModLoad imklog\)/#\1/' /etc/rsyslog.conf

# Install ansible via pip
RUN pip3 install ${pip_packages}

# Disable requiretty
RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers

# Replace initial initctl
COPY initctl_faker .
RUN chmod +x initctl_faker && rm -fr /sbin/initctl && ln -s /initctl_faker /sbin/initctl

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

# Remove unnecessary getty and udev targets that result in high CPU usage when using
# multiple containers with Molecule (https://github.com/ansible/molecule/issues/1104)
RUN rm -f /lib/systemd/system/systemd*udev* \
    && rm -f /lib/systemd/system/getty.target

VOLUME ["/sys/fs/cgroup", "/tmp", "/run" ]
CMD ["/lib/systemd/systemd"]