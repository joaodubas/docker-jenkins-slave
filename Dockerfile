# jenkins-slave
#
# VERSION: see `TAG`
FROM csanchez/jenkins-swarm-slave
MAINTAINER Joao Paulo Dubas "joao.dubas@gmail.com"

USER root
RUN apt-get -y -qq --force-yes update \
    && apt-get -y -qq --force-yes install \
        build-essential \
        python-setuptools \
        python-dev \
        ssh \
        sudo \
    && easy_install pip

RUN groupadd -g 999 docker \
    && usermod -aG sudo,docker jenkins-slave \
    && passwd -d jenkins-slave \
    && ssh-keyscan -H github.com >> /etc/ssh/ssh_know_hosts

RUN pip install \
        paramiko==1.15.2 \
        PyYAML==3.11 \
        Jinja2==2.7.3 \
        httplib2==0.9 \
        docker-py==0.7.1 \
    && pip install ansible==1.8.2

USER jenkins-slave
