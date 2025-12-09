variable "vpc_CIDR" {
  description = "cidr block for the vpc"
  type        = string
  default     = "10.0.0.0/16"
}

# First public subnet config 
variable "public_subnet_a_cidr" {
  description = "cidr block for public subnet a"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_a_az" {
  description = "AZ for public subnet a"
  type        = string
  default     = "eu-west-2a"
}

# Second public subnet config
variable "public_subnet_b_cidr" {
  description = "cidr block for public subnet b"
  type        = string
  default     = "10.0.3.0/24"
}

variable "public_subnet_b_az" {
  description = "AZ for public subnet b"
  type        = string
  default     = "eu-west-2b"
}

# route table
variable "route_table_cidr" {
  description = "cidr block for the route table"
  type        = string
  default     = "0.0.0.0/0"
}