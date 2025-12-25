output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.memos_vpc.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]
}

output "igw_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}
