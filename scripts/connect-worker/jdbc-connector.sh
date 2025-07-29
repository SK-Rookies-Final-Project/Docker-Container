#!/bin/bash

# connector1에서 실행

cd /bin
./confluent-hub install confluentinc/kafka-connect-jdbc:10.8.0

mkdir ~/jdbc
