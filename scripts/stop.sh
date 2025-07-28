#!/bin/bash

# Kafka 클러스터 중지 스크립트
echo "Kafka 클러스터를 중지합니다..."

# 역순으로 중지 (의존성을 고려)
echo "1. Control Center 중지..."
docker-compose -f ../inventory/docker-compose-c3.yml down

echo "2. ksqlDB 중지..."
docker-compose -f ../inventory/docker-compose-db.yml down

echo "3. Kafka Connect 중지..."
docker-compose -f ../inventory/docker-compose-cw.yml down

echo "4. Schema Registry 중지..."
docker-compose -f ../inventory/docker-compose-sr.yml down

echo "5. Broker 노드들 중지..."
docker-compose -f ../inventory/docker-compose-br.yml down

echo "6. Controller 노드들 중지..."
docker-compose -f ../inventory/docker-compose-kr.yml down

echo "모든 서비스가 중지되었습니다!"