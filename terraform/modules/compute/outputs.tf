output "load_balancer_dns_name" {
  description = "DNS name assigned to the application load balancer."
  value       = aws_lb.application.dns_name
}

output "load_balancer_arn" {
  description = "ARN of the application load balancer."
  value       = aws_lb.application.arn
}

output "target_group_arn" {
  description = "ARN of the application target group."
  value       = aws_lb_target_group.application.arn
}

output "autoscaling_group_name" {
  description = "Name of the application Auto Scaling group."
  value       = aws_autoscaling_group.application.name
}

output "https_listener_configured" {
  description = "Indicates whether an HTTPS listener was configured."
  value       = var.certificate_arn != null
}