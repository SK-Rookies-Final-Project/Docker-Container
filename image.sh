#!/bin/bash

IMAGE="confluentinc/cp-server"
TAG="7.7.1"

# 이미지와 태그 존재 여부 확인
STATUS=$(curl -s -o /dev/null -w "%{http_code}" \
  "https://hub.docker.com/v2/repositories/${IMAGE}/tags/${TAG}/")

if [ "$STATUS" -eq 200 ]; then
  echo "✅ 이미지 ${IMAGE}:${TAG} 는 Docker Hub에 존재합니다."
else
  echo "❌ 이미지 ${IMAGE}:${TAG} 는 Docker Hub에 존재하지 않습니다."
fi
