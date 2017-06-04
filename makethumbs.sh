#!/bin/zsh

if [[ $# -eq 0 ]] ; then
  echo 'Please provide a folder name'
  exit 0
fi

folder=$1
mkdir -p public/images/thumbs/$folder
cd public/images/$folder
for filename in *
do
  convert $filename -resize 100x100\^ -gravity center -extent 100x100 "../thumbs/$folder/$filename"
done
