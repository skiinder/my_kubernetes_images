#!/bin/bash
CLASS=$1
shift
case "$CLASS" in
'master' | 'regionserver')
  CMD=(${HBASE_HOME}/bin/hbase-daemon.sh foreground_start ${CLASS})
  ;;
*)
  CMD=(ping www.baidu.com)
  ;;
esac
exec /usr/bin/tini -s -- "${CMD[@]}"
