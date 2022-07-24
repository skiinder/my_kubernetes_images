#!/bin/bash
CLASS=$1
shift
CMD=(ping www.baidu.com)
case "$CLASS" in
'hiveserver2')
  CMD=($HIVE_HOME/bin/hive --service hiveserver2)
  ;;
'init_metastore')
  $HIVE_HOME/bin/schematool -validate -dbType mysql || $HIVE_HOME/bin/schematool -initSchema -dbType mysql -verbose
  exit
  ;;
'metastore')
  CMD=($HIVE_HOME/bin/hive --service metastore)
  ;;
esac
exec /usr/bin/tini -s -- "${CMD[@]}"