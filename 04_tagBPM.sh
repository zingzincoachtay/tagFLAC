#!/bin/bash

if [ ! -d "$1" ]; then
  echo Only accept a directory as input
  exit
fi

#if the `bpm-tag` fails with: sox FAIL formats: no handler for file extension `mp3'
#sudo apt-get install libsox-fmt-mp3

find "$1" -iname "*.flac" -exec bpm-tag  "{}" \;

find "$1" -iname "*.mp3" -exec bpm-tag  "{}" \;

