#!/bin/bash
set -e

cp _SUMMARY.md SUMMARY.md
rm -rf open-c3-code_ open-c3-code
git clone git@github.com:open-c3/open-c3.git open-c3-code_
find open-c3-code_  -name "*.md"|sed 's/[^\/]*.md//'|sed 's/open-c3-code_/open-c3-code/'|xargs -i{} mkdir -p {}
find open-c3-code_  -name "*.md" |xargs  -i echo {} {}|sed 's/ open-c3-code_/ open-c3-code/'|xargs -i{} bash -c  "cp {}"
find open-c3-code   -name "*.md" |grep -v ISSUE_TEMPLATE |grep -v web-shell/private |sort|xargs  -i echo {} {}|sed 's/.md//'|sed 's/\/README//'|sed 's/open-c3-code\///'|awk '{print "    * [",$1,"](" ,$2,")"}' >> SUMMARY.md
rm -rf open-c3-code_
