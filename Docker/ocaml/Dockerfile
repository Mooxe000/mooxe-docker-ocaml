FROM mooxe/ocaml_base:dev

MAINTAINER FooTearth "footearth@gmail.com"

USER root
WORKDIR /root

# system update
RUN \
  apt-get update && \
  apt-get -y upgrade

RUN apt-get install -y m4 libev-dev

RUN \
  apt-get autoremove -y && \
  apt-get clean

USER opam
WORKDIR /home/opam

RUN fish -lc "fisher edc/bass" && \
    fish -lc "bass eval opam env"

RUN opam install --unlock-base -y utop
RUN opam install --unlock-base -y base
RUN opam install --unlock-base -y core
RUN opam install --unlock-base -y batteries

# ocamlscript 

RUN \
  echo '#\
use "topfind";;\n#\
thread;;\n#\
camlp4o;;\n#\
require "core.top";;\n#\
require "core.syntax";;\
' >> ~/.ocamlinit
