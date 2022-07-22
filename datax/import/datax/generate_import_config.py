# ecoding=utf-8
import json
import getopt
import os
import sys
import MySQLdb

# MySQL相关配置，需根据实际情况作出修改
mysql_host = os.getenv("MYSQL_SERVICE_HOST")
mysql_port = os.getenv("MYSQL_SERVICE_PORT")
mysql_user = os.getenv("MYSQL_USERNAME")
mysql_passwd = os.getenv("MYSQL_PASSWORD")

# HDFS NameNode相关配置，需根据实际情况作出修改
# hdfs_nn_host = "hadoop102"
# hdfs_nn_port = "8020"
# HIVE输出路径
hive_output_dir = os.getenv("HIVE_OUTPUT_DIR")
do_date = os.getenv("DO_DATE")
redis_host = os.getenv("REDIS_HOST")
default_fs = os.getenv("DEFAULT_FS")

# 生成配置文件的目标路径，可根据实际情况作出修改
output_file = os.getenv("OUTPUT_FILE")


def get_connection():
    return MySQLdb.connect(host=mysql_host, port=int(mysql_port), user=mysql_user, passwd=mysql_passwd)


def get_mysql_meta(database, table):
    connection = get_connection()
    cursor = connection.cursor()
    sql = "SELECT COLUMN_NAME,DATA_TYPE from information_schema.COLUMNS WHERE TABLE_SCHEMA=%s AND TABLE_NAME=%s ORDER BY ORDINAL_POSITION"
    cursor.execute(sql, [database, table])
    fetchall = cursor.fetchall()
    cursor.close()
    connection.close()
    return fetchall


def get_mysql_columns(database, table):
    return map(lambda x: x[0], get_mysql_meta(database, table))


def get_hive_columns(database, table):
    def type_mapping(mysql_type):
        mappings = {
            "bigint": "bigint",
            "int": "bigint",
            "smallint": "bigint",
            "tinyint": "bigint",
            "decimal": "string",
            "double": "double",
            "float": "float",
            "binary": "string",
            "char": "string",
            "varchar": "string",
            "datetime": "string",
            "time": "string",
            "timestamp": "string",
            "date": "string",
            "text": "string"
        }
        return mappings[mysql_type]

    meta = get_mysql_meta(database, table)
    return map(lambda x: {"name": x[0], "type": type_mapping(x[1].lower())}, meta)


def generate_json(source_database, source_table):
    job = {
        "job": {
            "setting": {
                "speed": {
                    "channel": 3
                },
                "errorLimit": {
                    "record": 0,
                    "percentage": 0.02
                }
            },
            "content": [{
                "reader": {
                    "name": "mysqlreader",
                    "parameter": {
                        "username": mysql_user,
                        "password": mysql_passwd,
                        "column": get_mysql_columns(source_database, source_table),
                        "splitPk": "",
                        "connection": [{
                            "table": [source_table],
                            "jdbcUrl": [
                                "jdbc:mysql://" + mysql_host + ":" + mysql_port + "/" + source_database + "?useSSL=false"]
                        }]
                    }
                },
                "writer": {
                    "name": "hdfswriter",
                    "parameter": {
                        "defaultFS": default_fs,
                        "fileType": "text",
                        "path": "/".join([hive_output_dir, source_table + "_full", do_date]),
                        "fileName": source_table,
                        "column": get_hive_columns(source_database, source_table),
                        "writeMode": "append",
                        "fieldDelimiter": "\t",
                        "compress": "gzip",
                        "hadoopConfig": {
                            "fs.jfs.impl": "io.juicefs.JuiceFileSystem",
                            "fs.AbstractFileSystem.jfs.impl": "io.juicefs.JuiceFS",
                            "juicefs.meta": "redis://" + redis_host + "/1"
                        }
                    }
                }
            }]
        }
    }
    output_path = os.path.dirname(output_file)
    if not os.path.exists(output_path):
        os.makedirs(output_path)
    with open(output_file, "w") as f:
        json.dump(job, f)
        f.close()


if __name__ == '__main__':
    source_database = os.getenv("SOURCE_DATABASE")
    source_table = os.getenv("SOURCE_TABLE")

    generate_json(source_database, source_table)
