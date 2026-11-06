output "vpc_id" {
  description = "FleetTrack VPC ID"
  value       = aws_vpc.fleettrack_vpc.id
}

output "public_subnet_id" {
  description = "FleetTrack Public Subnet ID"
  value       = aws_subnet.public_subnet.id
}

output "internet_gateway_id" {
  description = "FleetTrack Internet Gateway ID"
  value       = aws_internet_gateway.fleettrack_igw.id
}

output "security_group_id" {
  description = "FleetTrack Security Group ID"
  value       = aws_security_group.fleettrack_sg.id
}

output "ec2_instance_id" {
  value = aws_instance.fleettrack_server.id
}

output "ec2_public_ip" {
  value = aws_instance.fleettrack_server.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.fleettrack_server.public_dns
}

output "frontend_bucket_name" {
  value = aws_s3_bucket.frontend.bucket
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.frontend.domain_name
}