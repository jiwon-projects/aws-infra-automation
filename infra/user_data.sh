#!/bin/bash
set -euxo pipefail

export DEBIAN_FRONTEND=noninteractive

# SSM Agent 준비
if ! snap list amazon-ssm-agent >/dev/null 2>&1; then
  snap install amazon-ssm-agent --classic
fi
snap start --enable amazon-ssm-agent

# Docker, Compose, Buildx와 배포 도구 설치
apt-get update
apt-get install -y \
  docker.io \
  docker-compose-v2 \
  docker-buildx \
  git \
  curl

systemctl enable --now docker

docker --version
docker compose version
docker buildx version

# 검증할 애플리케이션 버전 지정
APP_COMMIT="6e94ab6ac07edeb434854ac7353c9290cca329d0"

# 프로젝트 코드 다운로드
git clone --no-checkout \
  https://github.com/jiwon-projects/aws-infra-automation.git \
  /opt/aws-infra-automation

cd /opt/aws-infra-automation
git checkout --detach "$APP_COMMIT"

# EC2 전용 실행 환경
cat > .env <<'EOF'
HTTP_BIND_IP=0.0.0.0
HTTP_PORT=80
APP_ENV=production
APP_VERSION=0.1.0
EOF

# 애플리케이션 빌드 및 실행
docker compose config --quiet
docker compose up -d --build --wait --wait-timeout 180

# 배포 결과를 최초 부팅 로그에 기록
docker compose ps
curl -fsS --retry 5 --retry-connrefused --retry-delay 2 \
  --max-time 10 http://localhost/health/live

echo
echo "Application deployment completed."