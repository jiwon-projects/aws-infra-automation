# Day 10 — GHCR 이미지 게시 자동화

- .github/workflows/publish-image.yml을 작성했다.
- main의 Project CI가 성공한 경우에만 검증한 커밋으로 이미지를 빌드했다.
- GITHUB_TOKEN과 packages:write 권한으로 GHCR에 게시했다.
- linux/amd64와 linux/arm64 이미지를 만들고 커밋별 태그·Digest를 기록했다.
- PR #3 병합 후 이미지 게시 성공, 로컬 동기화와 브랜치 정리를 확인했다.
- GHCR 이미지를 내려받아 실행하거나 EC2 배포에 연결하는 검증은 아직 진행하지 않았다.
