#!/usr/bin/env bash

: ${OPAM_VERSION=2.0.0-rc4}
: ${OPAM_URL_PREFIX=https://github.com/ocaml/opam/releases/download}
: ${OPAM_BIN=/usr/local/bin/opam}

: ${OPAM_PLATFORM=x86_64}
: ${OPAM_SYSTEM=linux}

curl -kL -o opam \
  ${OPAM_URL_PREFIX}/${OPAM_VERSION}/opam-${OPAM_VERSION}-${OPAM_PLATFORM}-${OPAM_SYSTEM}
