cd public/images/fb_photos
for filename in *
do
  convert $filename -resize 100x100\^ -gravity center -extent 100x100 "../thumbs/fb_photos/$filename"
done
