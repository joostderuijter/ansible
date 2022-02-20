FROM debian:buster-slim
WORKDIR /usr/local/bin
RUN apt-get update && \
    apt-get install -y software-properties-common curl git build-essential sudo && \
    apt-add-repository "deb http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main" && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 && \
    apt-get update && \
    apt-get install -y ansible

RUN useradd -m joost && echo "joost:nice" | chpasswd && adduser joost sudo
ENV USER=joost
USER joost
WORKDIR /home/joost/ansible

COPY . .
CMD ["sh", "-c", "ansible-playbook --ask-become-pass --ask-vault-pass local.yml"]
