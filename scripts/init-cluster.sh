#!/bin/bash

# Ubuntu 22.04 LTS Docker 설치 스크립트
# 실행 방법: chmod +x install-docker.sh && ./install-docker.sh

set -e  # 오류 발생 시 스크립트 중단

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 로그 함수
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 시작 메시지
log_info "Ubuntu 22.04 LTS Docker 설치를 시작합니다..."

# 1. 시스템 패키지 업데이트
log_info "시스템 패키지 업데이트 중..."
sudo apt update -y

# 2. 기본 필요 패키지 설치
log_info "기본 패키지 설치 중..."
sudo apt install -y wget net-tools openssh-server firewalld unzip curl git

# 3. Docker 설치를 위한 필수 패키지 설치
log_info "Docker 설치 준비 패키지 설치 중..."
sudo apt-get install -y apt-transport-https ca-certificates gnupg lsb-release software-properties-common

# 4. 기존 Docker 관련 패키지 제거 (충돌 방지)
log_info "기존 Docker 패키지 제거 중..."
sudo apt-get remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true

# 5. Docker의 공식 GPG 키 추가 (Ubuntu 22.04 권장 방법)
log_info "Docker GPG 키 추가 중..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# 6. Docker 공식 저장소 추가 (Ubuntu 22.04 권장 방법)
log_info "Docker 저장소 추가 중..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 7. 패키지 목록 업데이트
log_info "패키지 목록 업데이트 중..."
sudo apt-get update -y

# 8. Docker 설치
log_info "Docker 설치 중..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 9. Docker 서비스 시작 및 부팅 시 자동 시작 설정
log_info "Docker 서비스 시작 및 자동 시작 설정 중..."
sudo systemctl start docker
sudo systemctl enable docker

# 10. 현재 사용자를 docker 그룹에 추가 (sudo 없이 docker 명령 사용 가능)
log_info "현재 사용자를 docker 그룹에 추가 중..."
sudo usermod -aG docker $USER

# 11. Docker Compose 설치 (standalone 버전)
log_info "Docker Compose 설치 중..."
DOCKER_COMPOSE_VERSION="v2.29.7"
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# 12. Docker Compose 실행 권한 부여
sudo chmod +x /usr/local/bin/docker-compose

# 13. 심볼릭 링크 생성 (이미 존재하는 경우 강제 덮어쓰기)
sudo ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose

# 14. 설치 확인
log_info "설치 확인 중..."

# Docker 버전 확인
if docker --version >/dev/null 2>&1; then
    log_info "Docker 설치 성공: $(docker --version)"
else
    log_error "Docker 설치 실패"
    exit 1
fi

# Docker Compose 버전 확인
if docker-compose --version >/dev/null 2>&1; then
    log_info "Docker Compose 설치 성공: $(docker-compose --version)"
else
    log_error "Docker Compose 설치 실패"
    exit 1
fi

# Docker 서비스 상태 확인
if sudo systemctl is-active --quiet docker; then
    log_info "Docker 서비스가 정상적으로 실행 중입니다."
else
    log_error "Docker 서비스가 실행되지 않습니다."
    exit 1
fi

# 완료 메시지
echo
log_info "=== 설치 완료 ==="
log_info "Docker 및 Docker Compose 설치가 완료되었습니다."
log_warn "주의: docker 그룹 변경사항을 적용하려면 로그아웃 후 다시 로그인하거나"
log_warn "      'newgrp docker' 명령을 실행하세요."
echo
log_info "설치된 버전 정보:"
echo "  - $(docker --version)"
echo "  - $(docker-compose --version)"
echo
log_info "Docker 테스트 명령: docker run hello-world"