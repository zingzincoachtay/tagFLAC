#!/bin/bash

if [ ! -d "$1" ]; then
  echo Only accept a directory as input
  exit
fi

#[ ! -x "$(command -v id3v2)" ] && echo "sudo apt-get install id3v2
#[ ! -x "$(command -v metaflac)" ] && echo "sudo apt-get install metaflac"
if [ ! -x "$(command -v id3v2)"]; then
  echo "sudo apt-get install id3v2" && exit
fi
if [ ! -x "$(command -v metaflac)"]; then
  echo "sudo apt-get install metaflac" && exit
fi

###
### Stripping the inappropriately tagged
find "$1" -iname "*.flac" -exec id3v2 -D "{}" +
###
### Stripping the existing tags
### 1. Strip any commercial info
### 2. Meta tags are consistent across album
find "$1" -iname "*.flac" -exec metaflac --remove-all-tags "{}" +
###
### When I need to redo the tagging.
### I would rename the FLAC file based on metadata
find "$1" -iname "*.flac" | sort | perl -pe 's/^((.+)\/(.+? - )(\d{2})( - .+))$/mv -i "\1" "\2\/\4 - Track \4.flac"/ '
