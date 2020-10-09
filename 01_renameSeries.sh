#!/bin/bash

if [ ! -d "$1" ]; then
  echo Only accept a directory as input
  exit
fi

###
### Sound Juicer extracts audio and rename files
### in the syntax of ## - Track ##.flac by default
find "$1" -type f -iname "*.flac" | \
  perl -ne 'chomp;if(/\D(\d) - Track \1\D/){print $_."\t";s/(\d) - Track \1/0\1 - Track 0\1/;print $_."\n";}' | \
  perl -ne '/^(.+)\t(.+)$/;print "mv -i \"$1\" \"$2\"\n" if $1 ne $2;'
