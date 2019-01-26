#!/bin/bash

function get_platform_type() {
  local type=-1
  if [[ "$OSTYPE" == "darwin"* ]]; then
    type=0
  fi

  if [ $type -eq -1 ]; then
    echo >&2 "OS type $OSTYPE is unsupported currently.";
  fi

  echo $type
}

function get_mime_type() {
  local file=$1
  echo $(file --mime-type -b "$file")
}

function print_error() {
  local msg=$1
  local bold_red="\033[1;31m"
  local normal="\033[0m"
  echo ${bold_red}ERROR:${normal} $msg
}

function print_warning() {
  local msg=$1
  local bold_yellow="\033[1;33m"
  local normal="\033[0m"
  echo ${bold_yellow}WARNING:${normal} $msg
}

function print_hint() {
  local msg=$1
  local bold_cyan_bkg="\033[1;46m"
  local normal="\033[0m"
  echo ${bold_cyan_bkg}HINT${normal}: $msg
}

function print_title() {
  local msg=$1
  local bold_green="\033[1;32m"
  local normal="\033[0m"
  echo "\n${bold_green}$msg\n----------------------------------------\n${normal}"
}