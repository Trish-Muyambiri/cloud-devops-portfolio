output "vpc_id" {
  value = aws_vpc.main.id
}

output "nat_gateway_enabled" {
  description = "Flag to indicate if NAT Gateway is enabled"
  value       = var.enable_nat_gateway
}
