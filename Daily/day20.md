# Day 20 — 배포 기록으로 이미지 실행 및 검증

## 실습 내용

- `verified-release.json`에서 이미지 주소를 읽어 `API_IMAGE`에 저장했다.
- 배포용 Docker Compose로 해당 Digest의 이미지를 Mac에서 실행했다.
- `day20` 프로젝트의 Nginx를 로컬 `8084` 포트로 연결했다.

## 검증 결과

- `verify_release.sh day20`의 검사 6개가 모두 통과했다.
- 실행 이미지의 Digest, API 응답, Nginx와 API 간 통신, API 8000번 포트 미게시를 확인했다.
- 검증 후 컨테이너 두 개와 실습 네트워크를 제거했다.

## 배운 점

- 배포 기록에서 읽은 Digest를 Compose에 전달하면 API 이미지를 재빌드하지 않고 지정한 버전을 실행할 수 있다.