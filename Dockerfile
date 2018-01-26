FROM mooxe/base:dev

MAINTAINER FooTearth "footearth@gmail.com"

WORKDIR /root

# system update
RUN \
  apt-get update && \
  apt-get -y upgrade

RUN \
  apt-get install -y \
    curl make gcc g++ libev-dev \
    bzip2 unzip m4 \
    rsync mercurial darcs 
    # ocaml-nox opam m4 utop

ADD opam/opam /usr/local/bin/opam
RUN chmod +x /usr/local/bin/opam

RUN opam init -y

RUN \
  opam install -y conf-libev lwt utop \
    core batteries \
    ocamlscript 

RUN \
  # bash
  yes | opam init --shell=bash && \
  bash -lc "eval `opam config env`" && \
  # zsh
  yes | opam init --shell=zsh && \
  zsh -lc "eval `opam config env`" && \
  # fish
  yes | opam init --shell=fish && \
  fish -lc "fisher edc/bass" && \
  fish -lc "bass eval opam config env"

RUN \
  echo '#\
use "topfind";;\n#\
thread;;\n#\
camlp4o;;\n#\
require "core.top";;\n#\
require "core.syntax";;\
' >> ~/.ocamlinit

RUN \
  apt-get autoremove -y && \
  apt-get clean
