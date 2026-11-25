# Day 19 — 배포 기록에서 검증된 이미지 주소 읽기

## 실습 내용

- `scripts/read_verified_release.py`로 GitHub Actions에서 내려받은 `verified-release.json`을 읽었다.
- 프로젝트의 GHCR 주소와 SHA-256 Digest 형식, 소스 커밋, 실행 ID, 검증 환경을 검사한다.

## 검증 결과

- 실제 배포 기록에서 이미지 주소를 한 줄로 출력했다.
- 출력된 Digest가 같은 GitHub Actions 실행의 게시 로그와 일치했다.
- `latest` 태그를 전달하면 오류 메시지와 종료 코드 `1`을 반환했다.

## 배운 점

- 스크립트에 읽을 JSON 파일의 실제 경로를 전달해야 한다.
- 스크립트는 기록의 형식을 검사한다. 같은 실행의 게시 로그에 나온 Digest와 대조해 어떤 이미지가 검증됐는지 확인할 수 있다.