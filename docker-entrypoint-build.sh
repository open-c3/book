#!/bin/sh
set -x

cd /srv/gitbook-src

gitbook build || (gitbook install && gitbook build )
