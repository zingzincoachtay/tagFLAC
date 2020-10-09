#!/bin/bash

if [ ! -d "$1" ]; then
  echo Only accept a directory as input
  exit
fi

if [ ! -x "$(command -v lltag)"]; then
  echo "sudo apt-get install lltag" && exit
fi

find "$1" -iname "*.flac" -exec lltag -T --no-tagging --rename "%A/%A - %n - %t - %a" "{}" +
