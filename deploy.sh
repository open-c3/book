#!/bin/bash
set -e

C3BASEPATH=$( [[ "$(uname -s)" == Darwin ]] && echo "$HOME/open-c3-workspace" || echo "/data" )
. $C3BASEPATH/open-c3/Installer/scripts/multi-os-support.sh

rm -rf open-c3-dev.github.io
./build.sh

#c3sed "s|https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css|https://webapps1.chicago.gov/cdn/Bootstrap-3.3.7/bootstrap.min.css|g" `grep https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css -rl _book`
#c3sed "s|https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js|https://webapps1.chicago.gov/cdn/Bootstrap-3.3.7/bootstrap.min.js|g"    `grep https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js -rl _book`


c3sed "s|https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css|../css/bootstrap.min.css|g" `grep https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css -rl _book`
c3sed "s|https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js|../js/bootstrap.min.js|g"     `grep https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js -rl _book`

git clone git@github.com:open-c3-dev/open-c3-dev.github.io.git

rm -rf open-c3-dev.github.io/*
rsync -a _book/ open-c3-dev.github.io/

cd open-c3-dev.github.io
git reset 5f16fe6b1de2ae0f368f4a0b511d68385ebd3e95

git add *
git commit -m 'Automatic deployment'
git push -f

rm -rf ../open-c3-dev.github.io
