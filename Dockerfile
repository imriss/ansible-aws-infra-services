FROM imriss:archlinux
RUN echo 'Ansible AWS on Arch Linux'
MAINTAINER Reza Farrahi <imriss@ieee.org>
LABEL description="Ansible AWS / Arch Linux"

RUN  pacman -Syyu --noconfirm && \
  pacman -S findutils nano vi --noconfirm && \
  pacman-db-upgrade && \
  export editor=nano && \
  pacman -S --noconfirm python python-yaml wget python-pip && \
  pip install --upgrade pip && \
  pip install simplejson 

# Contains the version we need to pull for ansible
COPY ANSIBLE_DOCKER_ENV /

# Collect Ansible
RUN /bin/bash -c 'source /ANSIBLE_DOCKER_ENV \
    && pip install git+https://github.com/ansible/ansible.git@$ANSIBLE_COMMIT_HASH#egg=ansible boto boto3 awscli'

VOLUME ["/project", "/root/.aws"]
WORKDIR /project
