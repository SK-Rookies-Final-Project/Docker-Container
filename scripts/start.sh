#!/bin/bash

# Kafka 클러스터 시작 스크립트
echo "Kafka 클러스터를 시작합니다..."

# 실행 순서가 중요합니다 (의존성 순서대로)
echo "1. Controller 노드들 시작..."
docker-compose -f docker-compose-kr.yml up -d

# Controller가 완전히 시작될 때까지 잠시 대기
echo "Controller 노드 초기화 대기 중..."
sleep 10

echo "2. Broker 노드들 시작..."
docker-compose -f docker-compose-br.yml up -d

# Broker가 완전히 시작될 때까지 대기
echo "Broker 노드 초기화 대기 중..."
sleep 15

echo "3. Schema Registry 시작..."
docker-compose -f docker-compose-sr.yml up -d

echo "4. Kafka Connect 시작..."
docker-compose -f docker-compose-cw.yml up -d

echo "5. ksqlDB 시작..."
docker-compose -f docker-compose-db.yml up -d

echo "6. Control Center 시작..."
docker-compose -f docker-compose-c3.yml up -d

echo "모든 서비스가 시작되었습니다!"
echo "Control Center: http://localhost:9021"
echo "ksqlDB: http://localhost:8088"
echo "Schema Registry 1: http://localhost:18081"
echo "Schema Registry 2: http://localhost:18082"
echo "Kafka Connect 1: http://localhost:18083"
echo "Kafka Connect 2: http://localhost:18084"

sudo systemctl start docker