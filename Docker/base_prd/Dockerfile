FROM ocaml/opam2:ubuntu-16.04-ocaml-4.08

MAINTAINER FooTearth "footearth@gmail.com"

USER root
WORKDIR /root
# ENV HOME=/root

ENV \
  SYSMIRROR_163=mirrors.163.com \
  SYSMIRROR_aliyun=mirrors.aliyun.com \
  SYSMIRROR_souhu=mirrors.souhu.com \
  SYSMIRROR_ustc=mirrors.ustc.edu.cn
ENV SOURCES_FILE=/etc/apt/sources.list

# Update sources list
RUN \
  export SYSMIRROR=${SYSMIRROR_aliyun} && \
  sed -i \
    -e "s/archive.ubuntu.com/${SYSMIRROR}/g" \
    -e "s/security.ubuntu.com/${SYSMIRROR}/g" \
    ${SOURCES_FILE}

# system update
RUN \
  apt-get update && \
  apt-get -y upgrade

RUN apt-get install -y curl apt-utils

RUN \
  apt-get autoremove -y && \
  apt-get clean

USER opam
WORKDIR /home/opam/opam-repository
