FROM mooxe/base:dev

MAINTAINER FooTearth "footearth@gmail.com"

WORKDIR /root

# system update
RUN \
  apt-get update && \
  apt-get -y upgrade

RUN \
  apt-get install -y \
    ocaml-nox opam m4 utop

RUN \
  opam init -y && \
  opam install -y core utop

RUN \
  yes | opam init --shell=bash && \
  bash -lc "eval `opam config env`"

RUN \
  yes | opam init --shell=zsh && \
  zsh -lc "eval `opam config env`"

RUN \
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
