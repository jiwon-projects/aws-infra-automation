# Day 5 — AWS 수동 배포 검증

- terraform apply로 리소스 12개를 생성했다.
- SSM 접속 후 Docker·Compose 설치와 cloud-init 완료를 확인했다.
- GitHub 코드를 내려받아 EC2용 .env를 만들고 Compose를 실행했다.
- 외부 HTTP 요청에서 alive·ready·production 응답을 확인했다.
- 외부 8000번 접근 차단과 실습 후 리소스 삭제를 확인했다.
