# VPC

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "memos-vpc"
    Environment = var.environment_tag
  }
}


# Internet Gateway


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "memos-igw"
    Environment = var.environment_tag
  }
}


# Public Subnets


resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = var.public_subnet_a_az
  map_public_ip_on_launch = true

  tags = {
    Name        = "memos-public-subnet-a"
    Environment = var.environment_tag
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = var.public_subnet_b_az
  map_public_ip_on_launch = true

  tags = {
    Name        = "memos-public-subnet-b"
    Environment = var.environment_tag
  }
}


# Public Route Table


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.route_table_cidr # "0.0.0.0/0" from tfvars
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "memos-public-rt"
    Environment = var.environment_tag
  }
}

# Route Table Associations

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}


module "security_groups" {
  source = "./Modules/security_groups"

  vpc_id          = aws_vpc.vpc.id
  alb_sg_name     = "memos alb sg"
  ecs_sg_name     = "memos ecs sg"
  allow_all_cidr  = "0.0.0.0/0"
  http_port       = var.http_port
  https_port      = var.https_port   
  app_port        = var.app_port
  environment_tag = var.environment_tag
}

module "alb" {
  source = "./Modules/alb"

  vpc_id = aws_vpc.vpc.id
  public_subnet_ids = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_b.id,
  ]

  security_group_id_alb = module.security_groups.alb_sg_id

  alb_name        = var.alb_name
  alb_tg_name     = var.alb_tg_name
  environment_tag = var.environment_tag

  app_port   = var.app_port
  http_port  = var.http_port
  https_port = var.https_port

  health_check_path                = var.health_check_path
  health_check_matcher             = var.health_check_matcher
  health_check_interval            = var.health_check_interval
  health_check_timeout             = var.health_check_timeout
  health_check_healthy_threshold   = var.health_check_healthy_threshold
  health_check_unhealthy_threshold = var.health_check_unhealthy_threshold

  acm_certificate_arn = data.aws_acm_certificate.cert.arn


}


# ACM (data block as cert already exists)
data "aws_acm_certificate" "cert" {
  domain      = "nourdemo.com"
  statuses    = ["ISSUED"]
  most_recent = true
}


module "ecs" {
  source = "./Modules/ecs"

  # networking + integration
  subnet_ids            = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
  ecs_security_group_id = module.security_groups.ecs_sg_id
  target_group_arn      = module.alb.target_group_arn

  # cluster + service
  ecs_cluster_name = var.ecs_cluster_name
  ecs_service_name = var.ecs_service_name
  desired_count    = var.ecs_desired_count

  # task definition
  task_definition_family = var.task_definition_family
  task_definition_cpu    = var.task_definition_cpu
  task_definition_memory = var.task_definition_memory

  container_name  = var.container_name
  container_image = var.container_image
  app_port        = var.app_port

  container_environment = var.container_environment

  # logging
  log_group_name     = var.log_group_name
  log_retention_days = var.log_retention_days
  log_stream_prefix  = var.log_stream_prefix

  # IAM
  ecs_execution_role_name = var.ecs_execution_role_name

  # misc
  assign_public_ip = var.assign_public_ip
  environment_tag  = var.environment_tag
  aws_region       = var.aws_region
}

module "route53" {
  source = "./Modules/route53"

  domain_name       = var.domain_name 
  alb_dns_name      = module.alb.alb_dns_name
  alb_zone_id       = module.alb.alb_zone_id
  create_www_record = true 
}
