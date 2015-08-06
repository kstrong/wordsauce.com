#!/bin/zsh

cd public
find . -name '*.DS_Store' -type f -delete
rsync -av images/ wordsauce:~/wordsauce.com/public/images
cd -

