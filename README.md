
# AWS Infrastructure Automation & Security

## 프로젝트 소개

Terraform을 활용하여 AWS 인프라를 자동 구축하고,
Docker 기반 FastAPI 서비스를 배포하는 DevOps 프로젝트입니다.

## 프로젝트 목표

- AWS 인프라 구축 자동화
- Terraform을 통한 인프라 재현성 확보
- AWS 네트워크 및 접근 통제 구성
- FastAPI 서비스 컨테이너화
- 인프라 운영 및 보안 개선

## 기술 스택

| 분류 | 기술 |
|---|---|
| Cloud | AWS EC2, VPC, IAM |
| IaC | Terraform |
| Backend | Python, FastAPI |
| Container | Docker, Docker Compose |
| Web Server | Nginx |
| OS | Ubuntu 24.04 ARM64 |
| Version Control | Git, GitHub |

## 시스템 아키텍처

Internet
  → AWS Internet Gateway
  → Public Subnet
  → EC2
  → Nginx
  → Docker / FastAPI

자세한 내용은 [아키텍처 문서](docs/architecture.md)를 참고하세요.

## 프로젝트 진행 현황

- [x] 프로젝트 요구사항 정의
- [x] GitHub 저장소 생성
- [ ] AWS 아키텍처 설계 완료
- [ ] FastAPI 애플리케이션 구현
- [ ] Docker 환경 구성
- [ ] Terraform AWS 인프라 구축
- [ ] AWS 배포 및 테스트
- [ ] 보안 검증 및 문서화

## 프로젝트 문서

- [요구사항 정의](docs/requirements.md)
- [아키텍처](docs/architecture.md)
- [배포 가이드](docs/deployment.md)
- [트러블슈팅](docs/troubleshooting.md)
