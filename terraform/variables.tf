variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "FleetTrack"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "key_pair_name" {
  description = "Existing AWS EC2 Key Pair"
  type        = string
  default     = "pairrrr"
}

variable "db_username" {
  type    = string
  default = "fleetadmin"
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "frontend_bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
}