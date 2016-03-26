#!/bin/zsh

folder="new_photos"
cd public/images/$folder
for filename in *
do
  convert $filename -resize 100x100\^ -gravity center -extent 100x100 "../thumbs/$folder/$filename"
done
