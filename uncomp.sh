#! /pkg/bin/bash

if [ $# -eq 0 ] ; then
  echo 'usage: uncomp {filelist}+'
  exit 1
fi

for arg in $@ ; do
  case $arg in
    *.tar.gz) tar -xzf $arg ;;
    *.tar.Z) tar -xZf $arg ;;
    *.tar) tar -xf $arg ;;
    *.Z) uncompress $arg ;;
    *.gz) gunzip $arg ;;
    *.zip) unzip $arg ;;
    *) echo uncomp: $arg has no compression extension.
  esac
done #for
 
