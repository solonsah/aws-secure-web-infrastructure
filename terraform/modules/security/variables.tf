variable "project_name" {
  description = "Project name used in resource names."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where security groups are created."
  type        = string
}

variable "application_port" {
  description = "Port used by the web application."
  type        = number
  default     = 8080

  validation {
    condition     = var.application_port >= 1 && var.application_port <= 65535
    error_message = "The application port must be between 1 and 65535."
  }
}

variable "allowed_https_cidrs" {
  description = "IPv4 networks permitted to reach the HTTPS load balancer."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}