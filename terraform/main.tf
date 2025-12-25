# VPC  
module "vpc" {
  source = "./Modules/vpc"

  vpc_name        = "memos-vpc"
  vpc_cidr        = var.vpc_cidr
  environment_tag = var.environment_tag

  public_subnet_a_cidr = var.public_subnet_a_cidr
  public_subnet_a_az   = var.public_subnet_a_az

  public_subnet_b_cidr = var.public_subnet_b_cidr
  public_subnet_b_az   = var.public_subnet_b_az

  route_table_cidr = var.route_table_cidr
}

# Security Groups
module "security_groups" {
  source = "./Modules/security_groups"

  vpc_id = module.vpc.vpc_id

  alb_sg_name     = var.alb_sg_name
  ecs_sg_name     = var.ecs_sg_name
  allow_all_cidr  = var.allow_all_cidr
  http_port       = var.http_port
  https_port      = var.https_port
  app_port        = var.app_port
  environment_tag = var.environment_tag
}

# ACM (data block as cert already exists)
data "aws_acm_certificate" "cert" {
  domain      = "nourdemo.com"
  statuses    = ["ISSUED"]
  most_recent = true
}

# ALB
module "alb" {
  source = "./Modules/alb"

  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
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

# ECS
module "ecs" {
  source = "./Modules/ecs"

  # networking + integration
  subnet_ids            = module.vpc.public_subnet_ids
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
  image_tag       = var.image_tag
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

# Route53
module "route53" {
  source = "./Modules/route53"

  domain_name       = var.domain_name
  alb_dns_name      = module.alb.alb_dns_name
  alb_zone_id       = module.alb.alb_zone_id
  create_www_record = true
}
