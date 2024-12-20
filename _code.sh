#!/bin/bash
set -e

C3BASEPATH=$( [[ "$(uname -s)" == Darwin ]] && echo "$HOME/open-c3-workspace" || echo "/data" )
. $C3BASEPATH/open-c3/Installer/scripts/multi-os-support.sh

cp _SUMMARY.md SUMMARY.md
rm -rf open-c3-code_ open-c3-code
git clone -b v2.6.0 git@github.com:open-c3/open-c3.git open-c3-code_
find open-c3-code_ -type l -exec rm {} \;

./c3mc-dtool-apidoc-make-sort > open-c3-code_/api.md
./c3mc-dtool-c3mcdoc-make     > open-c3-code_/c3mcdoc.md
./c3mc-dtool-todo-make        > open-c3-code_/c3todo.md

find open-c3-code_  -name "*.md"|sed 's/[^\/]*.md$//'|sed 's/open-c3-code_/open-c3-code/'|c3xargs  mkdir -p {}
find open-c3-code_  -name "*.md" |c3xargs echo {} {}|sed 's/ open-c3-code_/ open-c3-code/'|c3xargs bash -c  "cp {}"
find open-c3-code   -name "*.md" |grep -v ISSUE_TEMPLATE |grep -v web-shell/private|grep -v open-c3-code/README.md |c3xargs ./__code.sh {}|sort|awk '{print "    * [",$1,"](" ,$2,")"}' >> SUMMARY.md
rm -rf open-c3-code_
