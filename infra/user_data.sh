#!/bin/bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

# SSM Agent 준비
if ! snap list amazon-ssm-agent >/dev/null 2>&1; then
  snap install amazon-ssm-agent --classic
fi
snap start --enable amazon-ssm-agent

# 이미지 실행과 Parameter Store 조회 도구 설치
apt-get update
apt-get install -y docker.io docker-compose-v2 python3-boto3 curl

systemctl enable --now docker

# Terraform에서 전달한 실행 설정 저장
mkdir -p /opt/aws-infra-automation/nginx
cd /opt/aws-infra-automation

cat > compose.release.yaml <<'COMPOSE_EOF'
${release_compose}
COMPOSE_EOF

cat > nginx/default.conf <<'NGINX_EOF'
${nginx_config}
NGINX_EOF

cat > .env <<'ENV_EOF'
API_IMAGE=${api_image}
HTTP_BIND_IP=0.0.0.0
HTTP_PORT=80
APP_ENV=production
APP_VERSION=0.1.0
ENV_EOF

docker compose -f compose.release.yaml config --quiet

# 로그인 정보는 임시 폴더에만 저장하고 종료 시 삭제
export DOCKER_CONFIG
DOCKER_CONFIG=$(mktemp -d /run/ghcr-auth.XXXXXX)
trap 'rm -rf "$DOCKER_CONFIG"' EXIT

# EC2 역할로 토큰을 조회해 표준 입력으로 로그인
python3 - <<'PY'
import subprocess

import boto3

ssm = boto3.client("ssm", region_name=${aws_region_json})
token = ssm.get_parameter(
    Name=${ghcr_parameter_name_json},
    WithDecryption=True,
)["Parameter"]["Value"]

subprocess.run(
    [
        "docker",
        "login",
        "ghcr.io",
        "--username",
        ${ghcr_username_json},
        "--password-stdin",
    ],
    input=token,
    text=True,
    check=True,
)
PY

# 이미지를 먼저 다운로드하고 로컬 빌드 없이 실행
docker compose -f compose.release.yaml pull
docker compose -f compose.release.yaml up \
  -d --no-build --pull never --wait --wait-timeout 180

docker compose -f compose.release.yaml ps

curl -fsS --retry 5 --retry-connrefused --retry-delay 2 \
  --max-time 10 http://localhost/health/live

echo
echo "GHCR image deployment completed."