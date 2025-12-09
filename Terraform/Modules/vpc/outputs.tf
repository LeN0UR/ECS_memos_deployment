output "vpc_id" {
  description = "ID of the main VPC"
  value       = aws_vpc.memos_vpc.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets (used for ALB and ECS)"
  value       = [
    aws_subnet.public_subnet_1_m.id,
    aws_subnet.public_subnet_2_m.id,
  ]
}

output "public_subnet_1_id" {
  description = "ID of the first public subnet (AZ a)"
  value       = aws_subnet.public_subnet_1_m.id
}

output "public_subnet_2_id" {
  description = "ID of the second public subnet (AZ b)"
  value       = aws_subnet.public_subnet_2_m.id
}

output "igw_id" {
  description = "ID of the Internet Gateway attached to the VPC"
  value       = aws_internet_gateway.igw_mindful_m.id
}

output "public_route_table_id" {
  description = "ID of the public route table associated with the public subnets"
  value       = aws_route_table.mindful_motion_rt_m.id
}
