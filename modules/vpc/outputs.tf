output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_app_subnet_ids" {
  description = "Private app subnet IDs"
  value       = aws_subnet.private_app[*].id
}

output "private_db_subnet_ids" {
  description = "Private DB subnet IDs"
  value       = aws_subnet.private_db[*].id
}

output "web_sg_id" {
  description = "Web security group ID"
  value       = aws_security_group.web.id
}

output "app_sg_id" {
  description = "App security group ID"
  value       = aws_security_group.app.id
}

output "db_sg_id" {
  description = "DB security group ID"
  value       = aws_security_group.db.id
}

output "bastion_sg_id" {
  description = "Bastion security group ID"
  value       = var.enable_bastion ? aws_security_group.bastion[0].id : null
}

output "nat_gateway_ids" {
  description = "NAT Gateway IDs"
  value       = aws_nat_gateway.main[*].id
}

output "nat_public_ips" {
  description = "NAT Gateway public IPs"
  value       = aws_eip.nat[*].public_ip
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.main.id
}

output "public_route_table_id" {
  description = "Public route table ID"
  value       = aws_route_table.public.id
}

output "private_app_route_table_ids" {
  description = "Private app route table IDs"
  value       = aws_route_table.private_app[*].id
}

output "private_db_route_table_ids" {
  description = "Private DB route table IDs"
  value       = aws_route_table.private_db[*].id
}

output "availability_zones" {
  description = "Availability zones used"
  value       = var.availability_zones
}

output "vpc_flow_log_id" {
  description = "VPC Flow Log ID"
  value       = var.enable_flow_logs ? aws_flow_log.vpc[0].id : null
}

output "vpc_flow_log_group" {
  description = "CloudWatch log group for VPC Flow Logs"
  value       = var.enable_flow_logs ? aws_cloudwatch_log_group.vpc_flow_logs[0].name : null
}

#######################################
# Security Group Outputs
#######################################

output "web_security_group_id" {
  value = aws_security_group.web.id
}

output "app_security_group_id" {
  value = aws_security_group.app.id
}

output "db_security_group_id" {
  value = aws_security_group.db.id
}

output "bastion_security_group_id" {
  value = var.enable_bastion ? aws_security_group.bastion[0].id : null
}