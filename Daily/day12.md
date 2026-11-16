# Day 12 — 비공개 GHCR 이미지의 EC2 자동 배포

- GHCR 패키지를 비공개로 유지하면서 EC2 자동 배포를 구성했다.
- GitHub의 read:packages 토큰을 Parameter Store에 SecureString으로 저장했다.
- 파라미터 경로는 /projects/aws-infra-automation/ghcr-token을 사용했다.
- EC2 역할에 지정한 파라미터 외의 값 조회를 차단하는 인라인 정책을 추가했다.
- Terraform templatefile로 Compose·Nginx 설정을 EC2에 전달했다.
- EC2에서 Boto3와 IAM 역할로 토큰을 조회하고 표준 입력으로 GHCR에 로그인했다.
- 임시 Docker 로그인 폴더가 부팅 스크립트 종료 후 제거된 것을 확인했다.
- EC2에서 FastAPI를 빌드하지 않고 지정한 Digest의 이미지를 실행했다.
- 외부 API에서 alive, ready, production 응답을 확인했다.
- 외부 TCP 8000 접근 시간 초과를 확인했다.
- 실습 후 Terraform 리소스 13개, 별도 파라미터와 GitHub 토큰을 삭제했다.

## 문제 해결

처음 지정한 파라미터 이름은 aws 예약 접두사 규칙으로 거부됐다.
앞에 /projects를 추가해 생성했다.

## 재배포 전 준비

실습용 토큰과 파라미터를 삭제했으므로, 다음 배포 전에는 새 읽기용 토큰을 발급하고 같은 파라미터 경로에 저장해야 한다.

토큰 값은 Git·Terraform 코드·Daily 문서에 기록하지 않는다.