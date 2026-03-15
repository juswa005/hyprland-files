#!/bin/bash

if [[ $1 == "image" ]]; then
  cliphist decode | magick - -resize 200x200 png:-
else
  cliphist decode
fi
