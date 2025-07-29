#!/bin/bash

cd /home/appuser/jdbc
# 권한 부여
chmod u+x create-connector.sh
# Connector 생성
./create-connector.sh jdbc-mysql-source.json