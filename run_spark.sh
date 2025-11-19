#!/bin/bash

# Script to run PySpark in Docker container

# 1. Set script name (first argument)
SCRIPT_NAME=$1

if [ -z "$SCRIPT_NAME" ]; then
    echo "Usage: ./run_spark.sh <script_name.py>"
    exit 1
fi

# 2. Run inside Spark container
docker exec -it spark bash -c "
export HADOOP_CONF_DIR=/opt/spark/hadoop-3.0.0/etc/hadoop
export SPARK_DIST_CLASSPATH=\$(/opt/spark/hadoop-3.0.0/bin/hadoop classpath)
/opt/spark/bin/spark-submit /opt/spark/work-dir/$SCRIPT_NAME
"
