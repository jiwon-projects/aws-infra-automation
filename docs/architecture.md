
# AWS Infrastructure Architecture

## 1. 아키텍처 개요

Terraform을 이용해 AWS 인프라를 자동 구축하고,
EC2에서 Docker 기반 FastAPI 서비스를 운영한다.

## 2. AWS 리전

- Region: ap-northeast-2 (Seoul)
- OS: Ubuntu 24.04 ARM64
- Instance Type: t4g.small

## 3. 네트워크 구성

| Resource | CIDR / Configuration |
|---|---|
| VPC | 10.20.0.0/16 |
| Public Subnet | 10.20.1.0/24 |
| Internet Gateway | Public Internet 연결 |
| Public Route Table | 0.0.0.0/0 → IGW |
| Security Group | Inbound TCP 80 |
| EC2 | Public IP 할당 |

## 4. 서비스 구성

Internet
    ↓
Internet Gateway
    ↓
Public Subnet
    ↓
EC2
    ↓
Nginx (Port 80)
    ↓
Docker Container
    ↓
FastAPI (Port 8000)

FastAPI의 8000번 포트는 EC2의
127.0.0.1에만 바인딩한다.

## 5. 보안 설계

- SSH 22번 포트 외부 접근 차단
- FastAPI 8000번 포트 외부 접근 차단
- HTTP 80번 포트 허용
- AWS Systems Manager를 통한 서버 관리
- IAM Role을 통한 EC2 권한 관리
- AWS 액세스 키를 소스 코드에 저장하지 않음

## 6. 인프라 관리

Terraform으로 다음 작업을 수행한다.

- terraform init
- terraform plan
- terraform apply
- terraform destroy

인프라 재구축 후 동일한 서비스가
정상 실행되는지 검증한다.

## 7. 향후 개선

- HTTPS 적용
- Staging / Production 분리
- Terraform Remote State
- GitHub Actions CI/CD
- 자동 배포 및 롤백
