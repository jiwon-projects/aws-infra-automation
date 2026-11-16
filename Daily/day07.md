# Day 7 — GitHub Actions CI

- .github/workflows/ci.yml에 Python·Terraform 검증을 구성했다.
- pytest, Terraform fmt·validate, 부팅 스크립트 문법 검사를 자동 실행했다.
- Mac ARM64와 Linux AMD64용 Provider 체크섬을 잠금 파일에 추가했다.
- 체크섬 오류 해결 후 두 CI 작업의 성공을 확인했다.
