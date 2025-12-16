# VPC Configuration (matches ClickOps)
# Originally i had tfvars in my .gitignore however as it does not contain anything sensitive (keys,passwords,secrets) it is fine to commit.
vpc_cidr = "10.0.0.0/16"

public_subnet_a_cidr = "10.0.1.0/24" # eu-west-2a public
public_subnet_a_az   = "eu-west-2a"

public_subnet_b_cidr = "10.0.3.0/24" # eu-west-2b public
public_subnet_b_az   = "eu-west-2b"


# Route for public route table (default route via IGW)
route_table_cidr = "0.0.0.0/0"


# Load Balancer Configuration
alb_name        = "memos-alb"
environment_tag = "staging"
alb_tg_name     = "memos-tg"


# For Memos, app listens on 5230
app_port = 5230

health_check_path                = "/healthz"
health_check_matcher             = "200"
health_check_interval            = 30
health_check_timeout             = 5
health_check_healthy_threshold   = 2
health_check_unhealthy_threshold = 2


# ECS Configuration
ecs_cluster_name  = "memos-ecs-cluster"
ecs_service_name  = "memos-ecs-service"
ecs_desired_count = 1

task_definition_family = "memos-task"
task_definition_cpu    = "256" # string, matches variables.tf
task_definition_memory = "512" # string, matches variables.tf

container_name = "memos"

#temporary test
container_image = "595552412690.dkr.ecr.eu-west-2.amazonaws.com/new-memos-app"

container_environment = {}

log_group_name     = "/ecs/memos"
log_retention_days = 7
log_stream_prefix  = "memos"

ecs_execution_role_name = "memos-ecs-execution-role"
assign_public_ip        = true

aws_region = "eu-west-2"


# Security Group Configuration
alb_sg_name    = "memos-alb-sg"
ecs_sg_name    = "memos-ecs-sg"
allow_all_cidr = "0.0.0.0/0"
http_port      = 80
https_port     = 443


