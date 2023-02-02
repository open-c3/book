#!/bin/bash
./code.sh
docker run -it --rm -p 4000:4000 -v $PWD:/srv/gitbook-src --entrypoint /srv/gitbook-src/docker-entrypoint-serve.sh khs1994/gitbook
