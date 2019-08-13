#
# Java development base container
# Build and test java applications
#
FROM openjdk:12-jdk-oracle

LABEL maintainer="http://kolleh.com"
LABEL lang="java"
# Build tool (java, mvn, gradle, wrapper)
LABEL build-tool="wrapper"

ENV MAVEN_CLI_OPTS "-s .m2/settings.xml --batch-mode"
ENV MAVEN_OPTS "-Dmaven.repo.local=.m2/repository"

# Install packages for linting, building, and testing source code
RUN yum upgrade && yum install yum-utils && yum-config-manager --enable *addons
RUN yum install -y python36 docker-engine nodejs curl unzip bash
RUN python3 -m ensurepip && pip3 install --upgrade pip setuptools && if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && rm -r /root/.cache
RUN yum install nodejs && npm install -g dockerlint

RUN mkdir /app

WORKDIR /app

EXPOSE 8080/tcp

CMD ["/bin/bash"]
