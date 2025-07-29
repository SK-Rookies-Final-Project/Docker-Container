# 옵션 1: 프로젝트명 기반 정리 (권장)
PROJECT_NAME=${1:-"myproject"}  # 기본값 또는 첫 번째 인자

echo "=== Docker 리소스 정리 (프로젝트: $PROJECT_NAME) ==="

# 1. 특정 프로젝트의 컨테이너 중지 및 삭제
echo "1. 컨테이너 정리 중..."
docker stop $(docker ps -q --filter "name=$PROJECT_NAME")
docker rm $(docker ps -aq --filter "name=$PROJECT_NAME")

# 2. 특정 태그/레이블의 이미지만 삭제
echo "2. 이미지 정리 중..."
docker rmi -f $(docker images -q --filter "reference=$PROJECT_NAME*")

# 3. 특정 볼륨만 삭제 (레이블 기반)
echo "3. 볼륨 정리 중..."
docker volume rm $(docker volume ls -q --filter "label=project=$PROJECT_NAME")

# 4. 사용자 정의 네트워크 중 특정 네트워크만 삭제
echo "4. 네트워크 정리 중..."
docker network rm $(docker network ls -q --filter "name=$PROJECT_NAME")

echo "=== 정리 완료 ==="