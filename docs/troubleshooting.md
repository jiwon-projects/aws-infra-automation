## Day 7 — CI Provider 체크섬 오류 해결

- 증상: GitHub Actions의 Terraform validate에서 체크섬 불일치 발생
- 대응: Mac ARM64와 Linux AMD64용 Provider 체크섬을 잠금 파일에 추가
- 실행 명령:
  terraform -chdir=infra providers lock -platform=darwin_arm64 -platform=linux_amd64
- 결과: FastAPI tests와 Terraform checks 모두 성공