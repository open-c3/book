#!/bin/bash
set -e

./_code.sh

docker run --rm -v $PWD:/srv/gitbook-src --entrypoint /srv/gitbook-src/docker-entrypoint-build.sh khs1994/gitbook
