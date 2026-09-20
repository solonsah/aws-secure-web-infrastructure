variable "project_name" {
  description = "Project name used in resource names."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "vpc_id" {
  description = "ID of the project VPC."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs used by the load balancer."
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnet IDs used by the application instances."
  type        = list(string)
}

variable "load_balancer_security_group_id" {
  description = "Security group attached to the load balancer."
  type        = string
}

variable "application_security_group_id" {
  description = "Security group attached to the application instances."
  type        = string
}

variable "application_port" {
  description = "Port on which the sample application listens."
  type        = number
  default     = 8080
}

variable "instance_type" {
  description = "EC2 instance type used by the example Auto Scaling group."
  type        = string
  default     = "t3.micro"
}

variable "minimum_capacity" {
  description = "Minimum number of application instances."
  type        = number
  default     = 2
}

variable "desired_capacity" {
  description = "Desired number of application instances."
  type        = number
  default     = 2
}

variable "maximum_capacity" {
  description = "Maximum number of application instances."
  type        = number
  default     = 4
}

variable "certificate_arn" {
  description = "Optional ACM certificate ARN supplied securely during deployment."
  type        = string
  default     = null
  nullable    = true
}