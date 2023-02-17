#!/bin/bash
set -e

cp _SUMMARY.md SUMMARY.md
rm -rf open-c3-code_ open-c3-code
git clone -b v2.6.0 git@github.com:open-c3/open-c3.git open-c3-code_

./c3mc-dtool-apidoc-make-sort > open-c3-code_/api.md

find open-c3-code_  -name "*.md"|sed 's/[^\/]*.md//'|sed 's/open-c3-code_/open-c3-code/'|xargs -i{} mkdir -p {}
find open-c3-code_  -name "*.md" |xargs  -i echo {} {}|sed 's/ open-c3-code_/ open-c3-code/'|xargs -i{} bash -c  "cp {}"
find open-c3-code   -name "*.md" |grep -v ISSUE_TEMPLATE |grep -v web-shell/private|grep -v open-c3-code/README.md |xargs  -i ./__code.sh {}|sort|awk '{print "    * [",$1,"](" ,$2,")"}' >> SUMMARY.md
rm -rf open-c3-code_
