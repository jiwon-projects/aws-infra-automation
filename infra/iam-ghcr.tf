# Terraform이 사용하는 AWS 계정 ID 조회
data "aws_caller_identity" "current" {}

locals {
  ghcr_token_parameter_arn = "arn:aws:ssm:${var.aws_region}:${data.aws_caller_identity.current.account_id}:parameter${var.ghcr_token_parameter_name}"
}

# EC2의 파라미터 조회 범위 제한
resource "aws_iam_role_policy" "ghcr_parameter_access" {
  name = "${var.project_name}-ghcr-parameter-access"
  role = aws_iam_role.ec2.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "ReadGHCRToken"
        Effect   = "Allow"
        Action   = "ssm:GetParameter"
        Resource = local.ghcr_token_parameter_arn
      },
      {
        Sid         = "DenyOtherParameterReads"
        Effect      = "Deny"
        Action      = "ssm:GetParameter*"
        NotResource = local.ghcr_token_parameter_arn
      }
    ]
  })
}