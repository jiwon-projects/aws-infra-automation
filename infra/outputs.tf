output "instance_id" {
  description = "EC2 instance ID for Systems Manager"
  value       = aws_instance.app.id
}

output "public_ip" {
  description = "EC2 public IPv4 address"
  value       = aws_instance.app.public_ip
}

output "service_url" {
  description = "Service URL after deploying the application"
  value       = "http://${aws_instance.app.public_ip}"
}

output "ami_id" {
  description = "Ubuntu AMI selected for the instance"
  value       = data.aws_ami.ubuntu.id
}