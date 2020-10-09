#!/bin/bash

if [ ! -d "$1" ]; then
  echo Only accept a directory as input
  exit
fi

#First check: metaflac --export-tags-to=- "{}" \;
#DISCID may be referred from CD.
#metaflac --remove-tag=DISCID "$1/*.flac"
#MUSICBRAINZ_DISCID is likely generated.
find "$1" -iname "*.flac" -exec metaflac --remove-tag=MUSICBRAINZ_DISCID "{}" +
#Album artist??
find "$1" -iname "*.flac" -exec metaflac --remove-tag=ARTISTSORT "{}" +

RETURN=`pwd`
echo cd \"$1\"
#Having any ID3 tags on FLAC is incorrect.
echo metaflac --remove-all-tags *.flac
#ALBUM=`perl -ne 'print;exit;' "$1/id3.tag"`
#PUB=`cat "$1/id3.tag" | perl -ne 'print  if $. == 2`
#DATE=`cat "$1/id3.tag" | perl -ne 'print  if $. == 3`
#GENRE=`cat "$1/id3.tag" | perl -ne 'print  if $. == 4`
#URL=`cat "$1/id3.tag" | perl -ne 'print  if $. == 5`
#SERIES=`cat "$1/id3.tag" | perl -ne 'print  if $. == 6`
cat "$1/tag.db" | \
  sed '1s/^\(.\+\)$/metaflac --set-tag="ALBUM=\1" *.flac/'  | \
  sed '2s/^\(.\+\)$/metaflac --set-tag="PUBLISHER=\1" *.flac/'    | \
  sed '3s/^\(.\+\)$/metaflac --set-tag="DATE=\1" *.flac/'   | \
  sed '4s/^\(.\+\)$/metaflac --set-tag="GENRE=\1" *.flac/'  | \
  sed '5s/^\(.\+\)$/metaflac --set-tag="REF_URL=\1" *.flac/'    | \
  sed '6s/^\(.\+\)$/metaflac --set-tag="GROUPING=\1" *.flac/' | \
  sed '7s/^\(.\+\)$/metaflac --set-tag="DISCID=\1" *.flac/' | \
  sed '8,$s/^\([0-9]\{2\}\)\t\([0-9]\{2\}\)\t\(.\+\)\t\(.\+\)$/metaflac --set-tag="TRACKNUMBER=\1\" --set-tag="TRACKTOTAL=\2" --set-tag="TITLE=\3" --set-tag="ARTIST=\4" --set-tag="DISCNUMBER=1" "\1 - Track \1.flac"/'
echo id3v2 -D *.flac
echo cd \"$RETURN\"

# output in a file
