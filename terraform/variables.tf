# VPC Variables

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_a_cidr" {
  description = "CIDR block for public subnet A"
  type        = string
}

variable "public_subnet_a_az" {
  description = "Availability Zone for public subnet A"
  type        = string
}

variable "public_subnet_b_cidr" {
  description = "CIDR block for public subnet B"
  type        = string
}

variable "public_subnet_b_az" {
  description = "Availability Zone for public subnet B"
  type        = string
}

variable "route_table_cidr" {
  description = "CIDR block for the default route in the public route table (usually 0.0.0.0/0)"
  type        = string
}


# Load Balancer Variables


variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "environment_tag" {
  description = "Environment tag to apply to resources (e.g. staging, prod)"
  type        = string
}

variable "alb_tg_name" {
  description = "Name of the ALB target group"
  type        = string
}

variable "app_port" {
  description = "Port the application container listens on"
  type        = number
}

variable "health_check_path" {
  description = "Path for ALB target group health checks"
  type        = string
}

variable "health_check_matcher" {
  description = "HTTP status code matcher for health checks (e.g. 200)"
  type        = string
}

variable "health_check_interval" {
  description = "Interval between health checks in seconds"
  type        = number
}

variable "health_check_timeout" {
  description = "Health check timeout in seconds"
  type        = number
}

variable "health_check_healthy_threshold" {
  description = "Number of health checks before considering a target healthy"
  type        = number
}

variable "health_check_unhealthy_threshold" {
  description = "Number of failed health checks before considering a target unhealthy"
  type        = number
}


# ECS Variables


variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "ecs_desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
}

variable "log_group_name" {
  description = "Name of the CloudWatch Logs log group"
  type        = string
}

variable "log_retention_days" {
  description = "Number of days to retain logs"
  type        = number
}

variable "task_definition_family" {
  description = "Family name of the ECS task definition"
  type        = string
}

variable "task_definition_cpu" {
  description = "CPU units for the ECS Fargate task (e.g. \"256\")"
  type        = string
}

variable "task_definition_memory" {
  description = "Memory (MiB) for the ECS Fargate task (e.g. \"512\")"
  type        = string
}

variable "container_name" {
  description = "Name of the container in the task definition"
  type        = string
}

variable "container_image" {
  description = "Container image repository URI (no tag), e.g. ECR repo URI"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag to deploy (e.g. git SHA)"
  type        = string
  default     = "latest"
}

variable "log_stream_prefix" {
  description = "Prefix for ECS log streams"
  type        = string
}

variable "ecs_execution_role_name" {
  description = "Name of the ECS execution IAM role"
  type        = string
}

variable "assign_public_ip" {
  description = "Whether ECS tasks should be assigned public IPs"
  type        = bool
}

variable "container_environment" {
  description = "Environment variables to inject into the container"
  type        = map(string)
  default     = {}
}

variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
}


# Security Group Variables


variable "alb_sg_name" {
  description = "Name of the ALB security group"
  type        = string
}

variable "ecs_sg_name" {
  description = "Name of the ECS tasks security group"
  type        = string
}

variable "allow_all_cidr" {
  description = "CIDR used for open access (e.g. 0.0.0.0/0)"
  type        = string
}

variable "http_port" {
  description = "HTTP port (usually 80)"
  type        = number
}

variable "https_port" {
  description = "HTTPS port (usually 443)"
  type        = number
}


# ACM


variable "domain_name" {
  description = "name of domain hosting the app"
  type        = string
  default     = "nourdemo.com"
}


