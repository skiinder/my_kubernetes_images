#!/bin/bash
find ./ -type f | grep -v md5sum | xargs -n1 md5sum | sort -k1 > md5sum.txt
tardir=$(cd ./; pwd)
unset t_md5sum
unset t_file
cat md5sum.txt | while read line
do
  array=($line)
  o_md5sum="${array[0]}"
  o_file="${array[1]}"
  if [ "$t_md5sum" = "$o_md5sum" ]
  then
    unset prefix
    echo "$o_file duplicated"
    cd $(dirname "$o_file")
    while [ ! $(pwd) = "$tardir" ]
    do
      cd ..
      prefix="$prefix../"
    done
    rm -rf "$o_file"
    ln -s "$prefix$t_file" "$o_file"
    sed -i '''/$o_file/d''' md5sum.txt
  else
    t_file="$o_file"
    t_md5sum="$o_md5sum"
  fi
done
rm -rf md5sum.txt
