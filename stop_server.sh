#!/bin/zsh

ssh wordsauce@wintersfear.com "cat ~/wordsauce.com/tmp/pids/unicorn.pid | xargs kill -QUIT"

