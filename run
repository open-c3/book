#!/bin/bash
set -e

C3BASEPATH=$( [[ "$(uname -s)" == Darwin ]] && echo "$HOME/open-c3-workspace" || echo "/data" )

cd $C3BASEPATH/open-c3-book || exit
git pull
./deploy.sh 
