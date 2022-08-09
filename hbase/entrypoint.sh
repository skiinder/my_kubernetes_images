#!/bin/bash
CLASS=$1
shift
case "$CLASS" in
'master' | 'regionserver')
  CMD=(${HBASE_HOME}/bin/hbase ${CLASS} start)
  ;;
'queryserver')
  CMD=(python3 ${HBASE_HOME}/queryserver/bin/queryserver.py)
  ;;
*)
  CMD=(ping www.baidu.com)
  ;;
esac
exec /usr/bin/tini -s -- "${CMD[@]}"
