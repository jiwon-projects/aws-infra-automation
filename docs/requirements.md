# AWS Infrastructure Automation & Security

## 1. 프로젝트 개요

AWS 기반 웹 서비스 인프라를 Terraform으로 자동 구축하고, 접근 통제 및 배포 환경을 표준화하는 개인 DevOps 프로젝트.

## 2. 프로젝트 목적

- AWS 인프라의 수동 구축 작업 자동화
- 인프라 구성의 재현성 확보
- 최소 권한 원칙에 기반한 서버 접근 통제
- Docker 기반 FastAPI 애플리케이션 운영
- 운영 절차 및 장애 해결 과정 문서화

## 3. 기술 스택

- Cloud: AWS EC2, VPC, IAM, Systems Manager
- IaC: Terraform
- Backend: Python, FastAPI
- Container: Docker, Docker Compose
- Reverse Proxy: Nginx
- OS: Ubuntu 24.04 ARM64
- Version Control: Git, GitHub

## 4. 주요 요구사항

1. Terraform으로 AWS 인프라를 생성하고 삭제할 수 있어야 한다.
2. FastAPI 서비스가 HTTP 요청에 정상 응답해야 한다.
3. 외부에서 FastAPI 내부 포트에 직접 접근할 수 없어야 한다.
4. 관리자는 SSH 인바운드 포트 없이 서버를 관리할 수 있어야 한다.
5. 인프라를 제거하고 다시 구축해도 동일하게 동작해야 한다.
6. 모든 구축·검증 과정을 문서로 남겨야 한다.

## 5. 완료 기준

- Terraform Apply 및 Destroy 성공
- FastAPI Health Check HTTP 200
- 외부 포트 접근 통제 검증
- EC2 관리자 접속 검증
- 인프라 재구축 성공
- README 및 운영 문서 작성 완료

## 6. 향후 확장

- Staging / Production 환경 분리
- Terraform Remote State
- GitHub Actions CI/CD
- 자동 배포 및 롤백
- 모니터링 및 Kubernetes 운영