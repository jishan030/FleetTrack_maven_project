# VPC
resource "aws_vpc" "fleettrack_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-VPC"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.fleettrack_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-Public-Subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "fleettrack_igw" {
  vpc_id = aws_vpc.fleettrack_vpc.id

  tags = {
    Name = "${var.project_name}-IGW"
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.fleettrack_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.fleettrack_igw.id
  }

  tags = {
    Name = "${var.project_name}-Public-RT"
  }
}

# Public Route Table Association
resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Private Subnet 1
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.fleettrack_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.project_name}-Private-Subnet-1"
  }
}

# Private Subnet 2
resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.fleettrack_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.project_name}-Private-Subnet-2"
  }
}

# FleetTrack Security Group
resource "aws_security_group" "fleettrack_sg" {
  name        = "${var.project_name}-SG"
  description = "Security group for FleetTrack application"
  vpc_id      = aws_vpc.fleettrack_vpc.id

  # HTTP
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-SG"
  }
}

# Latest Ubuntu 24.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# IAM Role for EC2 Systems Manager
resource "aws_iam_role" "ec2_ssm_role" {
  name = "${var.project_name}-EC2-SSM-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# SSM Policy
resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-EC2-Profile"
  role = aws_iam_role.ec2_ssm_role.name
}

# FleetTrack EC2 Instance
resource "aws_instance" "fleettrack_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.fleettrack_sg.id]
  key_name                    = var.key_pair_name
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = true

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-EC2"
  }
}

# Database Security Group
resource "aws_security_group" "rds_sg" {
  name   = "${var.project_name}-RDS-SG"
  vpc_id = aws_vpc.fleettrack_vpc.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.fleettrack_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-RDS-SG"
  }
}

# RDS Subnet Group
resource "aws_db_subnet_group" "fleettrack_db_subnets" {
  name = "fleettrack-db-subnets"

  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]

  tags = {
    Name = "${var.project_name}-DB-Subnet-Group"
  }
}

# RDS MySQL
resource "aws_db_instance" "fleettrack_db" {
  identifier        = "fleettrack-mysql"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "fleettrack"
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.fleettrack_db_subnets.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible     = false
  multi_az                = false
  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false

  tags = {
    Name = "${var.project_name}-MySQL"
  }
}

# Private S3 Bucket for React Frontend
resource "aws_s3_bucket" "frontend" {
  bucket = var.frontend_bucket_name

  tags = {
    Name = "${var.project_name}-Frontend"
  }
}

resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket                  = aws_s3_bucket.frontend.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# CloudFront Origin Access Control
resource "aws_cloudfront_origin_access_control" "frontend" {
  name                              = "${var.project_name}-OAC"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# CloudFront Distribution
resource "aws_cloudfront_distribution" "frontend" {
  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name              = aws_s3_bucket.frontend.bucket_regional_domain_name
    origin_id                = "FleetTrack-S3"
    origin_access_control_id = aws_cloudfront_origin_access_control.frontend.id
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "FleetTrack-S3"
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name = "${var.project_name}-CloudFront"
  }
}

# Allow CloudFront to access private S3 bucket
resource "aws_s3_bucket_policy" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "AllowCloudFrontRead"
      Effect    = "Allow"
      Principal = {
        Service = "cloudfront.amazonaws.com"
      }
      Action   = "s3:GetObject"
      Resource = "${aws_s3_bucket.frontend.arn}/*"
      Condition = {
        StringEquals = {
          "AWS:SourceArn" = aws_cloudfront_distribution.frontend.arn
        }
      }
    }]
  })
}