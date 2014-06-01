#!/bin/zsh

cd public
find . -name '*.DS_Store' -type f -delete
tar zcvf images.tar.gz images/*
scp images.tar.gz wordsauce@wintersfear.com:~/wordsauce.com/public/
ssh wordsauce@wintersfear.com "cd ~/wordsauce.com/public; tar zxvf images.tar.gz; rm images.tar.gz;"
rm images.tar.gz
cd -

