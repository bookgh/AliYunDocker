#!/bin/bash

dir=`pwd`
. /etc/profile



version=v1.10.0

cd $dir
mkdir -p ../$version && cd ../$version

while read line; do
   file=$(echo $line | awk -F '/' '{print $NF}' | awk -F ':' '{print $1}')
   mkdir -p $file
   echo $line >$file/Dockerfile
done <../pull/list
