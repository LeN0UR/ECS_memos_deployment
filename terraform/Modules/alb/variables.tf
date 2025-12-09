
variable "vpc_id" {
  description = "VPC ID where the ALB and target group will be created"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list (string)
}

variable "security_group_id_alb" {
  description = "ALB security group ID"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN for the HTTPS listener"
  type        = string
}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "alb_tg_name" {
  description = "Name of the ALB target group"
  type        = string
}

variable "environment_tag" {
  description = "Environment tag value (e.g. dev, staging, prod)"
  type        = string
}

variable "app_port" {
  description = "Port the application/container listens on"
  type        = number
}

variable "http_port" {
  description = "HTTP listener port"
  type        = number
}

variable "https_port" {
  description = "HTTPS listener port"
  type        = number
}

# Target group health checks

variable "health_check_path" {
  description = "Health check path for the ALB target group"
  type        = string
}

variable "health_check_matcher" {
  description = "HTTP status code matcher for health checks (e.g. 200)"
  type        = string
}

variable "health_check_interval" {
  description = "Time in seconds between health checks"
  type        = number
}

variable "health_check_timeout" {
  description = "Health check timeout in seconds"
  type        = number
}

variable "health_check_healthy_threshold" {
  description = "Number of consecutive successes before considering healthy"
  type        = number
}

variable "health_check_unhealthy_threshold" {
  description = "Number of consecutive failures before considering unhealthy"
  type        = number
}
