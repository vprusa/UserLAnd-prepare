#!/bin/bash
#!/bin/sh
THIS_DIR=$(dirname `realpath "$0"`)
#set -e

# for variables DEBUG (for echo) and RUN_FUN (for exec) it is defined that
# containing specific flag character enables calling
# appropriate functions/procedures/debug/...
# Flags meanings:
# p -> prepare enviroment
# a -> apt
# y -> yum
# i -> install
# d -> dnf
# s -> sudo

DEBUG="aip"
RUN_FUN_DEFAULT="aip"

RUN_FUN=`[[ -z "$1" ]] && echo "${RUN_FUN_DEFAULT}" || echo "$1"`

# TODO as array with delimiter ';'
ADDITINAL_SCRIPTS_SRC=""

NOW_FILE_NAME=`date +%Y-%m-%d_%H-%M-%S`

INSTALL_CMD="apt"

[[ $DEBUG == *"a"* ]] && INSTALL_CMD="apt"
[[ $DEBUG == *"y"* ]] && INSTALL_CMD="yum"
[[ $DEBUG == *"d"* ]] && INSTALL_CMD="dnf"
[[ ! -z "$2" ]] && ADDITINAL_SCRIPTS_SRC=$2

if [[ $DEBUG == *"s"* ]] ; then
   echo "Run as root!"
   # TODO
   # INSTALL_CMD="sudo ${INSTALL_CMD}"
   exit
fi

function ex(){
  CMD=$1
  echo "Ex: $CMD"
  RES=`$CMD`
  echo "res: $RES"
}

function install(){
  [[ $DEBUG == *"i"* ]] && echo "Installing env..."
  # TODO ...
  I_CMD="${INSTALL_CMD} install -y "
  ex "${INSTALL_CMD} update"
  ex "${INSTALL_CMD} update --fix-missing"
  ex "${I_CMD} wget"
  ex "${I_CMD} unzip"
  ex "${I_CMD} vi"
  ex "${I_CMD} vim"
  ex "${I_CMD} screen"
  ex "${I_CMD} ssh"
  ex "${I_CMD} openssh"
  ex "${I_CMD} git"
  ex "${I_CMD} libpam-google-authenticator"
  ex "${I_CMD} google-authenticator"
  ex "${I_CMD} oathtool"
  ex "${I_CMD} nmap"
  ex "${I_CMD} dnsutils"
}

function prepare(){
  [[ $DEBUG == *"p"* ]] && echo "Preparing env..."
  # TODO ...
  # wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=FILEID' -O FILENAME
  GD_FILEID="$3"
  wget --no-check-certificate "https://docs.google.com/uc?export=download&id=${GD_FILEID}" -O gaik.zip
  git clone https://github.com/vprusa/oathIptablesKnock/
}

[[ $RUN_FUN == *"i"* ]] && install
[[ $RUN_FUN == *"p"* ]] && prepare

BASHRC_STR=`cat ~/.bashrc`
if [[ $BASHRC_STR != *"additional-scripts"* ]] ; then
  if [[ ! -z "$ADDITINAL_SCRIPTS_SRC" ]] ; then
    echo "" >> ~/.bash
    echo "# additional-scripts" >> ~/.bash
    echo "source ~/${ADDITINAL_SCRIPTS_SRC}.sh p" >> ~/.bash
  fi
fi

#
