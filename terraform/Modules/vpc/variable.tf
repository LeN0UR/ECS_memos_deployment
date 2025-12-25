variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "environment_tag" {
  description = "Environment tag (e.g. staging, prod)"
  type        = string
}

variable "public_subnet_a_cidr" {
  description = "CIDR block for public subnet A"
  type        = string
}

variable "public_subnet_a_az" {
  description = "Availability zone for public subnet A"
  type        = string
}

variable "public_subnet_b_cidr" {
  description = "CIDR block for public subnet B"
  type        = string
}

variable "public_subnet_b_az" {
  description = "Availability zone for public subnet B"
  type        = string
}

variable "route_table_cidr" {
  description = "CIDR route for public route table (usually 0.0.0.0/0)"
  type        = string
}
