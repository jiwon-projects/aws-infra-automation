# Day 11 — GHCR 이미지 실행과 Digest 고정

- GHCR에 게시한 FastAPI 이미지를 Digest로 다운로드했다.
- Apple Silicon Mac에서 linux/arm64 이미지임을 확인했다.
- 기존 개발용 compose.yaml을 유지하고 compose.release.yaml을 추가했다.
- build 대신 image를 사용하고, API_IMAGE 환경변수로 실행할 이미지를 지정했다.
- --no-build 옵션으로 로컬 재빌드 없이 실행했다.
- day11 프로젝트와 로컬 8082 포트로 기존 실습 환경과 구분했다.
- Nginx 경유 요청에서 alive, ready, image-test 응답을 확인했다.
- Nginx와 FastAPI 간 내부 통신, FastAPI 8000번 포트 미게시를 확인했다.
- 검증 후 day11 컨테이너와 네트워크를 정리했다.

## 검증한 FastAPI 이미지

ghcr.io/jiwon-projects/aws-infra-automation@sha256:2967a677d10fa6018e0b1f5c5a45a2aefa3ab163b3c5c800f56eaa21873a9e69

## 실행 방법

같은 터미널에 API_IMAGE를 설정한 뒤 실행한다.

```bash
docker compose -p day11 -f compose.release.yaml up -d --no-build --wait
```

이번 검증은 Mac에서 수행했으며, GHCR 이미지 기반 EC2 배포는 아직 진행하지 않았다.