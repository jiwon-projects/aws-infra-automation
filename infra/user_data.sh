#!/bin/bash
set -euxo pipefail

export DEBIAN_FRONTEND=noninteractive

# SSM Agent를 먼저 준비
if ! snap list amazon-ssm-agent >/dev/null 2>&1; then
  snap install amazon-ssm-agent --classic
fi
snap start --enable amazon-ssm-agent

# Ubuntu 저장소에서 Docker와 Compose 설치
apt-get update
apt-get install -y docker.io docker-compose-v2 git curl

# Docker를 즉시 시작하고 재부팅 후에도 자동 실행
systemctl enable --now docker

# 설치 결과를 부팅 로그에 기록
docker --version
docker compose version