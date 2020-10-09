#!/bin/bash

if [ ! -d "$1" ]; then
  echo Only accept a directory as input
  exit
fi

if [ ! -x "$(command -v lltag)"]; then
  echo "sudo apt-get install lltag" && exit
fi

find "$1" -iname "*.mp3" -exec lltag -T --no-tagging --rename "%A/%A - %n - %t - %a" "{}" +


#find "$1" -iname "*.flac" -exec id3v2 -R "{}" \; | \
#  perl -ne 'print if /Filename|TRCK|TIT2|TPE1/' | \
#  perl -pe 's/^Filename: ((.+)\/([^\/]+)(\.\w{3,4}))$/mv -i "\1" "\2\/\2 - \3\4"/' | \
#  perl -pe 's/^TRCK: (\d{1,})\/\d{1,}$/ - \1/' | \
#  perl -pe 's/^TIT2: (.+)$/ - \1/' | \
#  perl -pe 's/^TPE1: (.+)/ - \1/'
