variable "aws_region" {
  description = "AWS resources region"
  type        = string
  default     = "ap-northeast-2"
}

variable "project_name" {
  description = "Prefix for resource names"
  type        = string
  default     = "aws-infra-automation"
}

variable "environment" {
  description = "Infrastructure environment"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC"
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidr" {
  description = "IPv4 CIDR block for the public subnet"
  type        = string
  default     = "10.20.1.0/24"
}

variable "instance_type" {
  description = "ARM64-compatible EC2 instance type"
  type        = string
  default     = "t4g.small"
}

variable "ghcr_token_parameter_name" {
  description = "Parameter Store path for the GHCR read-only token"
  type        = string
  default     = "/projects/aws-infra-automation/ghcr-token"
}

variable "api_image" {
  description = "FastAPI image pinned by digest"
  type        = string
  default     = "ghcr.io/jiwon-projects/aws-infra-automation@sha256:2967a677d10fa6018e0b1f5c5a45a2aefa3ab163b3c5c800f56eaa21873a9e69"

  validation {
    condition     = can(regex("^ghcr[.]io/jiwon-projects/aws-infra-automation@sha256:[0-9a-f]{64}$", var.api_image))
    error_message = "프로젝트 GHCR 이미지의 전체 SHA256 Digest를 지정하세요."
  }
}

variable "ghcr_username" {
  description = "GitHub username that owns the read-only token"
  type        = string
  default     = "jiwoninnuk"
}