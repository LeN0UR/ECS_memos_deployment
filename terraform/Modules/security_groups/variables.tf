variable "vpc_id" {
  description = "ID of the VPC where security groups will be created"
  type        = string
}

variable "alb_sg_name" {
  description = "Name of the ALB security group"
  type        = string
}

variable "ecs_sg_name" {
  description = "Name of the ECS tasks security group"
  type        = string
}

variable "allow_all_cidr" {
  description = "CIDR used for world-open rules (e.g. 0.0.0.0/0)"
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

variable "app_port" {
  description = "Application port ECS tasks listen on (e.g. 5230 for Memos)"
  type        = number
}

variable "environment_tag" {
  description = "Environment tag (e.g. staging, prod)"
  type        = string
}
