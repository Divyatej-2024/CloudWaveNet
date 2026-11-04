output "vpc_id" {
  description = "Created VPC identifier."
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "Public subnet identifier."
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "Private subnet identifier."
  value       = aws_subnet.private.id
}

output "baseline_security_group_id" {
  description = "Security group with no inbound rules."
  value       = aws_security_group.baseline.id
}

output "vpc_flow_log_group" {
  description = "CloudWatch log group receiving VPC Flow Logs."
  value       = aws_cloudwatch_log_group.vpc_flow.name
}

output "vpn_connection_id" {
  description = "Optional VPN connection ID; null unless customer_gateway_ip is configured."
  value       = try(aws_vpn_connection.branch[0].id, null)
}
