# Ansible docker image : Ubuntu 18.04

[![Build Status](https://travis-ci.org/Xat59/docker-ubuntu1804.svg?branch=master)](https://travis-ci.com/github/Xat59/docker-ubuntu1804)

Ubuntu 18.04 docker image for ansible role testing.
I use docker to test my ansible roles on several OS using CI tool, such as [Travis](https://travis-ci.com/github/Xat59/).

## How to build ?

1. [Install docker](https://docs.docker.com/engine/install/)
2. Go through this directory : ```cd docker-ubuntu1804```
3. Build the image : ```docker build -t ubuntu1804-ansible .```

## How to use ?

1. [Install docker](https://docs.docker.com/engine/install/)
2. Get the CentOS8 image that has ansible embedded : ```docker pull xat59/ubuntu1804:latest```
3. Run a container from CentOS8 with ansible embedded : ```docker run -d --privileged --volume /sys/fs/cgroup:/sys/fs/cgroup:ro xat59/ubuntu1804:latest```
4. Use any ansible command you need, such as ansible-playbook : ```docker exec --tty <container_id> env TERM=xterm ansible-playbook playbook.yml```

## License

MIT / BSD

## Author Information

Created by Xat59 in 2020.