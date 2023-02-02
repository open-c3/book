#!/bin/bash
set -e

FILE=$1

X=`head -n 1 $FILE|grep  '^# '| wc -l`

if [ "X$X" == "X1" ];then
    TITLE=`head -n 1 $FILE|grep  '^# '|sed 's/# //'|sed 's/ //'`
else
    TITLE=`echo $FILE|sed 's/.md//'|sed 's/\/README//'|sed 's/open-c3-code\///'`
fi
echo "$TITLE /$FILE"
