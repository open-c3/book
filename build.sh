#!/bin/bash
set -e

./_code.sh

[[ -f ../open-c3-manage/book/node_modules.tar.gz && ! -d node_modules ]] && tar -zxvf ../open-c3-manage/book/node_modules.tar.gz

docker run --rm -v $PWD:/srv/gitbook-src --entrypoint /srv/gitbook-src/docker-entrypoint-build.sh khs1994/gitbook
