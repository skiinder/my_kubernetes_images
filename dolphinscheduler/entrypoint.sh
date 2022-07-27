#!/bin/bash
if [ ! -e continue ]
then
  ./install.sh
  touch continue
fi

if [ ! $1 ]
then
  CMD=(ping www.baidu.com)
else
  CMD=(bin/dolphinscheduler-daemon.sh start $1)
fi
exec /usr/bin/tini -s -- "${CMD[@]}"