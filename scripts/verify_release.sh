#!/usr/bin/env bash
set -euo pipefail

trap 'echo "배포 검증 실패: 위 오류를 확인하세요." >&2' ERR

# 실행 위치와 관계없이 프로젝트 루트에서 검사한다.
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

# 검사 대상과 기대값을 명시적으로 받는다.
PROJECT_NAME="${1:?사용법: bash scripts/verify_release.sh 프로젝트명}"
: "${API_IMAGE:?기대하는 이미지 Digest를 지정하세요}"
: "${HTTP_PORT:?검사할 로컬 포트를 지정하세요}"
: "${APP_ENV:?기대하는 실행 환경을 지정하세요}"
: "${APP_VERSION:?기대하는 버전을 지정하세요}"

COMPOSE=(docker compose -p "$PROJECT_NAME" -f compose.release.yaml)
BASE_URL="http://127.0.0.1:$HTTP_PORT"

echo "[1/6] 실행 중인 컨테이너 확인"
API_CONTAINER="$("${COMPOSE[@]}" ps --status running -q api)"
NGINX_CONTAINER="$("${COMPOSE[@]}" ps --status running -q nginx)"

if [[ -z "$API_CONTAINER" || -z "$NGINX_CONTAINER" ]]; then
  echo "API 또는 Nginx가 실행 중이 아닙니다." >&2
  exit 1
fi

echo "[2/6] 이미지 Digest와 API 헬스체크 확인"
RUNNING_IMAGE="$(docker inspect "$API_CONTAINER" --format '{{.Config.Image}}')"

if [[ "$RUNNING_IMAGE" != "$API_IMAGE" ]]; then
  echo "이미지 참조가 일치하지 않습니다." >&2
  echo "기대값: $API_IMAGE" >&2
  echo "실제값: $RUNNING_IMAGE" >&2
  exit 1
fi

HEALTH="$(docker inspect "$API_CONTAINER" --format '{{.State.Health.Status}}')"
if [[ "$HEALTH" != "healthy" ]]; then
  echo "API 헬스체크 상태가 healthy가 아닙니다: $HEALTH" >&2
  exit 1
fi

echo "[3/6] 외부 경로의 생존·준비 상태 확인"
curl -fsS --connect-timeout 3 --max-time 10 "$BASE_URL/health/live" \
  | python3 -c 'import json, sys; assert json.load(sys.stdin)["status"] == "alive", "생존 상태 불일치"'

curl -fsS --connect-timeout 3 --max-time 10 "$BASE_URL/health/ready" \
  | python3 -c 'import json, sys; assert json.load(sys.stdin)["status"] == "ready", "준비 상태 불일치"'

echo "[4/6] 실행 환경과 버전 확인"
curl -fsS --connect-timeout 3 --max-time 10 "$BASE_URL/api/version" \
  | python3 -c '
import json, sys
data = json.load(sys.stdin)
assert data["environment"] == sys.argv[1], "실행 환경 불일치"
assert data["version"] == sys.argv[2], "버전 불일치"
' "$APP_ENV" "$APP_VERSION"

echo "[5/6] Nginx에서 API로 내부 통신 확인"
"${COMPOSE[@]}" exec -T nginx \
  wget -T 5 -qO- http://api:8000/health/live \
  | python3 -c 'import json, sys; assert json.load(sys.stdin)["status"] == "alive", "내부 응답 불일치"'

echo "[6/6] API 8000번 포트의 호스트 미게시 확인"
docker inspect "$API_CONTAINER" --format '{{json .HostConfig.PortBindings}}' \
  | python3 -c '
import json, sys
bindings = json.load(sys.stdin) or {}
assert not bindings.get("8000/tcp"), "API 8000번 포트가 호스트에 게시되어 있습니다"
'

echo "배포 검증 완료: 모든 검사를 통과했습니다."