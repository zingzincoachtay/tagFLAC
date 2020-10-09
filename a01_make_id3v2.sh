#!/bin/bash

if [ ! -d "$1" ]; then
  echo Only accept a directory as input
  exit
fi

#TYER for v2.3
#TDRC for v2.4

RETURN=`pwd`
echo cd \"$1\"
echo id3v2 -D *.flac
cat "$1/id3.tag" | \
  sed '1s/^\(.\+\)$/id3v2 --TALB "\1" *.flac  /' | \
  sed '2s/^\(.\+\)$/id3v2 --TPUB "\1" *.flac  /' | \
  sed '3s/^\(.\+\)$/id3v2 --TYER "\1" *.flac  /' | \
  sed '4s/^\(.\+\)$/id3v2 --TCON "\1" *.flac  /' | \
  sed '5s/^\(.\+\)$/id3v2 --WCOM "\1" *.flac  /' | \
  sed '6s/^\(.\+\)$/id3v2 --TIT1 "\1" *.flac  /' | \
  sed '7,$s/^\([0-9]\{2\}\)\t\([0-9]\{2\}\)\t\(.\+\)\t\(.\+\)$/id3v2 --TRCK "\1\/\2" --TIT2 "\3" --TPE1 "\4" "\1 - Track \1.flac"/' 
echo cd \"$RETURN\"
