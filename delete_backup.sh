#!/bin/bash


for file in `\find . -maxdepth 1 -type d -name 'backup_*'`; do
  ## delete by name 1 week ago dirs
  datetime="${file##*/backup_}"
  datetime="${datetime//-//}"
  datetime="${datetime//./:}"
  datetime="${datetime//_/ }"
  if [ $(date -d '1 minute ago' +%s) -gt $(date -d "$datetime" +%s) ] ; then
    echo "remove" + $file
    rm -rf $file
  fi
done


