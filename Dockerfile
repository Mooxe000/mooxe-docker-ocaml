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

# ADD opam/opam /usr/local/bin/opam
# RUN chmod +x /usr/local/bin/opam
RUN curl -kLo- \
  https://raw.githubusercontent.com/Mooxe000/mooxe-docker-ocaml/master/install.sh \
    | bash

RUN \
  echo "test -r /root/.opam/opam-init/init.sh && . /root/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true" >> \
    ~/.profile && \
  # bash
  bash -lc "opam init --shell=bash" && \
  bash -lc "eval $(opam env)" && \
  # zsh
  zsh -lc "opam init --shell=zsh" && \
  zsh -lc "eval $(opam env)" && \
  # fish
  echo "source /root/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true" >> \
    ~/.config/fish/config.fish && \
  fish -lc "opam init --shell=fish" && \
  fish -lc "fisher edc/bass" && \
  fish -lc "bass eval opam env"

RUN \
  opam install -y conf-libev lwt utop \
    core batteries \
    ocamlscript 

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
