## Day 5 배포 검증 — 2026-11-16

- 서울 리전에서 Terraform 리소스 12개 생성 성공
- Session Manager로 EC2 접속 성공
- cloud-init 완료 및 Docker·Compose 실행 확인
- GitHub 코드를 EC2에 내려받아 Docker Compose로 배포
- EC2 환경 설정: HTTP_BIND_IP=0.0.0.0, HTTP_PORT=80, APP_ENV=production
- 외부 /health/live 응답: alive
- 외부 /health/ready 응답: ready
- 외부 /api/version 응답: version=0.1.0, environment=production
- 외부 TCP 8000 접근: 연결 시간 초과
- 인프라와 Docker 설치는 자동화했으며, 앱 배포는 SSM에서 수동 수행

## 리소스 정리

- 배포 검증 후 terraform destroy 완료
- 실습용 AWS 리소스 삭제 완료
- 삭제 후 서비스 주소는 더 이상 사용하지 않음



## Day 6 자동 배포·재구축 검증 — 2026-11-16

- 최초 부팅 스크립트에 Git 다운로드, 환경 설정, Compose 실행 추가
- Day 5에서 검증한 Git 커밋을 지정해 앱 배포
- docker-buildx 설치 추가 및 버전 확인
- Terraform으로 리소스 12개 재생성
- SSM에서 수동 배포 명령 없이 컨테이너 실행 확인
- cloud-init 완료 및 FastAPI healthy 확인
- 외부 API에서 alive, ready, production 응답 확인
- 외부 TCP 8000 접근 시간 초과 확인
- 검증 후 terraform destroy로 리소스 12개 삭제 완료