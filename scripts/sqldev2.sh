#!/bin/bash
docker start oracle-xe
nohup oracle-sqldeveloper > /dev/null 2>&1 &
disown
kill -9 $PPID
