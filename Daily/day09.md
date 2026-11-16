# Day 9 — Docker 통합 테스트 CI

- CI에 Docker integration tests 작업을 추가했다.
- 이미지 빌드·Compose 실행·Nginx 경유 API 응답을 검증했다.
- 컨테이너 간 통신과 FastAPI 8000번 포트 미게시를 검사했다.
- 실패 시에도 로그 출력과 컨테이너 정리가 실행되도록 구성했다.
- 세 번째 필수 검사로 등록하고 PR #2를 병합했다.
