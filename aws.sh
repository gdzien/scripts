#!/bin/bash
# Author: Grzegorz Dzien <gdzien@gmail.com>

# aws.sh, ver 0.1

# Simple script to fetch instance meta-data easier.

get_data() {
  if [ -z "$1" ] || [ "${1,,}" == "list" ]
  then
    curl 169.254.169.254/latest/meta-data/
    echo
    return
  else
    curl 169.254.169.254/latest/meta-data/$1
    echo
  fi
}

get_data $1
exit
