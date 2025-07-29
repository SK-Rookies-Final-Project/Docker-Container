#!/bin/bash

# connector1에서 실행

cd /bin
echo "1" | ./confluent-hub install confluentinc/kafka-connect-jdbc:10.8.0

mkdir ~/jdbc
