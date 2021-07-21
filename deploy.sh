#!/bin/bash
set -e

rm -rf open-c3.github.io
gitbook build
git clone https://github.com/open-c3/open-c3.github.io

rm -rf open-c3.github.io/*
rsync -a _book/ open-c3.github.io/

cd open-c3.github.io 
git reset c40c88e77a8048a2efdae70dedcf6e302acdda26

git add *
git commit -m 'Automatic deployment'
git push -f

rm -rf ../open-c3.github.io
