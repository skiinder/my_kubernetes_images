#!/bin/bash
#export SOURCE_DATABASE=gmall
#export SOURCE_TABLE=base_trademark
#export MYSQL_SERVICE_HOST=localhost
#export MYSQL_SERVICE_PORT=30213
#export MYSQL_USERNAME=root
#export MYSQL_PASSWORD=0WWbJU72qA
#export HIVE_OUTPUT_DIR=/warehouse/gmall/ods
#export DO_DATE=2020-06-14
export OUTPUT_FILE=${DATAX_HOME}/output.json

python generate_import_config.py && python bin/datax.py ${OUTPUT_FILE}
