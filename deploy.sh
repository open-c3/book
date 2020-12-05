#!/bin/bash
set -e

rm -rf open-c3.github.io
gitbook build
git clone https://github.com/open-c3/open-c3.github.io

rm -rf open-c3.github.io/*
rsync -a _book/ open-c3.github.io/

cd open-c3.github.io 
git reset 16580961eec5d26fc9ce61694da4ff2a1ae2f2ec

git add *
git commit -m 'Automatic deployment'
git push -f

rm -rf ../open-c3.github.io
