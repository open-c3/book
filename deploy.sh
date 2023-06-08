#!/bin/bash
set -e

rm -rf open-c3.github.io
./build.sh

#sed -i "s|https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css|https://webapps1.chicago.gov/cdn/Bootstrap-3.3.7/bootstrap.min.css|g" `grep https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css -rl _book`
#sed -i "s|https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js|https://webapps1.chicago.gov/cdn/Bootstrap-3.3.7/bootstrap.min.js|g"    `grep https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js -rl _book`


sed -i "s|https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css|../css/bootstrap.min.css|g" `grep https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css -rl _book`
sed -i "s|https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js|../js/bootstrap.min.js|g"     `grep https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js -rl _book`

git clone git@github.com:open-c3/open-c3.github.io.git

rm -rf open-c3.github.io/*
rsync -a _book/ open-c3.github.io/

cd open-c3.github.io 
git reset c40c88e77a8048a2efdae70dedcf6e302acdda26

git add *
git commit -m 'Automatic deployment'
git push -f

rm -rf ../open-c3.github.io
