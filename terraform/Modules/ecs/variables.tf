
variable "environment_tag" {
  description = "Environment tag (e.g. dev, staging, prod)"
  type        = string
}

variable "aws_region" {
  description = "AWS region (e.g. eu-west-2)"
  type        = string
}


variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
}


variable "subnet_ids" {
  description = "List of subnet IDs for ECS tasks"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "Security group ID for ECS tasks"
  type        = string
}

variable "assign_public_ip" {
  description = "Whether tasks get public IPs"
  type        = bool
}

variable "task_definition_family" {
  description = "Family name of the ECS task definition"
  type        = string
}

variable "task_definition_cpu" {
  description = "Fargate CPU units for the task definition"
  type        = string
}

variable "task_definition_memory" {
  description = "Fargate memory for the task definition (MiB)"
  type        = string
}

variable "container_name" {
  description = "Name of the container in the task definition"
  type        = string
}

variable "container_image" {
  description = "Container image URI (e.g. ECR image)"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag to deploy (e.g. git SHA)"
  type        = string
  default     = "latest"
}

variable "app_port" {
  description = "Port the application listens on inside the container"
  type        = number
}

variable "container_environment" {
  description = "Environment variables for the container"
  type        = map(string)
  default     = {}
}


variable "log_group_name" {
  description = "CloudWatch log group name for ECS tasks"
  type        = string
}

variable "log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
}

variable "log_stream_prefix" {
  description = "CloudWatch logs stream prefix"
  type        = string
}


variable "ecs_execution_role_name" {
  description = "Name of the ECS execution IAM role"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the ALB target group to attach the service to"
  type        = string
}
