FROM mooxe/ocaml_base:prd

MAINTAINER FooTearth "footearth@gmail.com"

USER root
WORKDIR /root

# extra ppa
RUN \
  apt-get install -y software-properties-common && \
  add-apt-repository ppa:git-core/ppa && \
  apt-add-repository ppa:fish-shell/release-2
  # add-apt-repository ppa:fish-shell/nightly-master

# Launchpad locale mirror
ARG MIRROR_LP
ENV MIRROR_LP ${MIRROR_LP}

# echo "1: ${MIRROR_LP}" && \
# echo "2: ${MIRROR_LP}"; \
RUN \
  if [ ! -z ${MIRROR_LP} ]; then \
    cp -R /etc/apt/sources.list.d \
      /etc/apt/sources.list.d.bak; \
    for sl_file in `ls /etc/apt/sources.list.d/`; do \
      # cat /etc/apt/sources.list.d/${sl_file}; \
      sed -i -e \
        "s/ppa.launchpad.net/${MIRROR_LP}/g" \
        /etc/apt/sources.list.d/${sl_file}; \
    done; \
  fi

# system update
RUN \
  apt-get update && \
  apt-get -y upgrade

RUN apt-get install -y git

# zsh && fish
RUN apt-get install -y fish zsh

RUN \
  apt-get autoremove -y && \
  apt-get clean

USER opam
WORKDIR /home/opam/opam-repository

# Bash-it
RUN \
  git clone --depth=1 https://github.com/Bash-it/bash-it.git \
    ~/.bash_it && \
  bash -lc "~/.bash_it/install.sh"

# on my zsh
RUN \
  git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git \
    ~/.oh-my-zsh && \
  cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# fisherman
# curl -sL get.fisherman.sh | fish
RUN \
  curl -Lo ~/.config/fish/functions/fisher.fish \
    --create-dirs git.io/fisherman
# RUN git clone https://github.com/fisherman/fisherman ~/.local/share/fisherman && \
#   cd ~/.local/share/fisherman && \
#   make && cd ~

RUN fish -lc "fisher omf/theme-robbyrussell"
# RUN git clone https://github.com/oh-my-fish/theme-robbyrussell.git \
#     ~/.config/fisherman/cache/robbyrussell && \
#   echo 'source ~/.config/fisherman/cache/robbyrussell/fish_prompt.fish' >> \
#     ~/.config/fish/config.fish

RUN echo "\
set fish_greeting '' \n\
set -gx LC_ALL en_US.UTF-8 \n\
set -gx LC_CTYPE en_US.UTF-8 \
  " > ~/.config/fish/config.fish

RUN \
  if [ ! -z ${MIRROR_LP} ]; then \
    rm -rf /etc/apt/sources.list.d; \
    mv /etc/apt/sources.list.d.bak \
      /etc/apt/sources.list.d; \
  fi
