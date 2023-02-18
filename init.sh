#!/bin/bash
docker run --rm -p 4000:4000 -v $PWD:/srv/gitbook-src --entrypoint /srv/gitbook-src/docker-entrypoint-init.sh khs1994/gitbook
