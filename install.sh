#!/usr/bin/env bash

: ${BUILD_DIR=ocaml/build}

: ${OCAML_VERSION=4.06.1+rc1}
: ${OCAML_SOURCE_DIR=ocaml-$OCAML_VERSION}
: ${OCAML_URL_PREFIX=https://github.com/ocaml/ocaml/archive}

mkdir -p ${BUILD_DIR}/${OCAML_SOURCE_DIR}
pushd ${BUILD_DIR}

  curl -kL -o ${OCAML_SOURCE_DIR}.tar.gz \
    ${OCAML_URL_PREFIX}/${OCAML_VERSION}.tar.gz

  tar xvf ${OCAML_SOURCE_DIR}.tar.gz \
    -C ${OCAML_SOURCE_DIR} \
    --strip-components 1

  pushd ${OCAML_SOURCE_DIR}
    ./configure -no-graph
    make world.opt
    make install
  popd

popd

rm -rf ocaml

###########
# ocamlbrew
# ---------
# add-apt-repository ppa:avsm/ppa
# apt-get install ocaml ocaml-native-compilers camlp4-extra opam
###########
# curl -kL https://raw.github.com/hcarty/ocamlbrew/master/ocamlbrew-install | env OCAMLBREW_FLAGS="-r" bash
# curl -kL https://raw.github.com/hcarty/ocamlbrew/master/ocamlbrew-install | bash


: ${OPAM_VERSION=2.0.0-beta6}
: ${OPAM_URL_PREFIX=https://github.com/ocaml/opam/releases/download}
: ${OPAM_BIN=/usr/local/bin/opam}

curl -kL -o ${OPAM_BIN} \
  ${OPAM_URL_PREFIX}/${OPAM_VERSION}/opam-${OPAM_VERSION}-$(uname -m)-$(uname -s | tr '[A-Z]' '[a-z]')
chmod +x ${OPAM_BIN}

########### 
# opam
# ---------
# wget https://raw.github.com/ocaml/opam/master/shell/opam_installer.sh -O - | sh -s /usr/local/bin
# opam update && \
# opam install opam-devel

