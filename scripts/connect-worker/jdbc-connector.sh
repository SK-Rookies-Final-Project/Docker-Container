#!/bin/bash

# connector1에서 실행

cd /bin
./confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.8.0

mkdir -p ~/jdbc
