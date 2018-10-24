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
  
# bwrap
ENV Bubblewrap_VERSION 0.3.1-2
ENV BubblewrapDEB bubblewrap_${Bubblewrap_VERSION}_amd64.deb
RUN curl -kL -O \
      https://launchpadlibrarian.net/391591982/${BubblewrapDEB} && \
    dpkg -i ${BubblewrapDEB} && \
    rm -rf ${BubblewrapDEB}

ENV OCAML_VERSION 4.07.0
RUN mkdir -p ocaml && \
    cd ocaml && \
    curl -kL -o ocaml-${OCAML_VERSION} \
      http://caml.inria.fr/pub/distrib/ocaml-4.07/ocaml-${OCAML_VERSION}.tar.gz && \
    tar xvf ocaml-${OCAML_VERSION} && \
    cd ocaml-${OCAML_VERSION} && \
    ./configure -no-graph && \
    make world.opt && \
    make install && \
    cd && \
    rm -rf ocaml

ENV OPAM_VERSION 2.0.1
RUN curl -kL -o /usr/local/bin/opam \
      https://github.com/ocaml/opam/releases/download/${OPAM_VERSION}/opam-${OPAM_VERSION}-x86_64-linux && \
    chmod +x /usr/local/bin/opam

# RUN \
#   echo "test -r /root/.opam/opam-init/init.sh && . /root/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true" >> \
#     ~/.profile && \
#   # bash
#   bash -lc "opam init --shell=bash" && \
#   bash -lc "eval $(opam env)" && \
#   # zsh
#   zsh -lc "opam init --shell=zsh" && \
#   zsh -lc "eval $(opam env)" && \
#   # fish
#   echo "source /root/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true" >> \
#     ~/.config/fish/config.fish && \
#   fish -lc "opam init --shell=fish" && \
#   fish -lc "fisher edc/bass" && \
#   fish -lc "bass eval opam env"

# RUN \
#   opam install -y conf-libev lwt utop \
#     core batteries \
#     ocamlscript 

# RUN \
#   echo '#\
# use "topfind";;\n#\
# thread;;\n#\
# camlp4o;;\n#\
# require "core.top";;\n#\
# require "core.syntax";;\
# ' >> ~/.ocamlinit

# RUN \
#   apt-get autoremove -y && \
#   apt-get clean
