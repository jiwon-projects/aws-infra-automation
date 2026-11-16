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