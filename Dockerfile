#
# Java development base container
# Build and test java applications
#
FROM openjdk:12-jdk-alpine

LABEL maintainer="http://kolleh.com"
LABEL lang="java"
# Build tool (java, mvn, gradle, wrapper)
LABEL build-tool="wrapper"

ENV MAVEN_CLI_OPTS "-s .m2/settings.xml --batch-mode"
ENV MAVEN_OPTS "-Dmaven.repo.local=.m2/repository"

# Install packages for linting, building, and testing source code
RUN apk update -q \ 
      && apk add --no-cache python3 docker nodejs nodejs-npm curl unzip bash \
      && npm install -g dockerlint \
      && python3 -m ensurepip \
      && rm -r /usr/lib/python*/ensurepip \ 
      && pip3 install --upgrade pip setuptools \ 
      && if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && rm -r /root/.cache

RUN mkdir /app

WORKDIR /app

EXPOSE 8080/tcp

CMD ["/bin/bash"]
