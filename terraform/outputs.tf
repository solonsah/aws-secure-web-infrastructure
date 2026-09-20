output "vpc_id" {
  description = "ID of the project VPC."
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public load-balancer subnets."
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private application subnets."
  value       = module.networking.private_subnet_ids
}

output "load_balancer_dns_name" {
  description = "DNS name assigned to the application load balancer."
  value       = module.compute.load_balancer_dns_name
}

output "autoscaling_group_name" {
  description = "Name of the application Auto Scaling group."
  value       = module.compute.autoscaling_group_name
}

output "https_listener_configured" {
  description = "Indicates whether an ACM certificate was supplied for HTTPS."
  value       = module.compute.https_listener_configured
}