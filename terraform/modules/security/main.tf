resource "aws_security_group" "load_balancer" {
  name        = "${var.project_name}-${var.environment}-alb-sg"
  description = "Controls HTTPS traffic to the public application load balancer."
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-${var.environment}-alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "load_balancer_https" {
  for_each = toset(var.allowed_https_cidrs)

  security_group_id = aws_security_group.load_balancer.id
  description       = "Permit HTTPS from an approved IPv4 network."
  cidr_ipv4         = each.value
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_security_group" "application" {
  name        = "${var.project_name}-${var.environment}-app-sg"
  description = "Controls traffic to private application instances."
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-${var.environment}-app-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "application_from_load_balancer" {
  security_group_id            = aws_security_group.application.id
  description                  = "Permit application traffic only from the load balancer."
  referenced_security_group_id = aws_security_group.load_balancer.id
  from_port                    = var.application_port
  to_port                      = var.application_port
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "load_balancer_to_application" {
  security_group_id            = aws_security_group.load_balancer.id
  description                  = "Permit the load balancer to reach the application tier."
  referenced_security_group_id = aws_security_group.application.id
  from_port                    = var.application_port
  to_port                      = var.application_port
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "application_https" {
  security_group_id = aws_security_group.application.id
  description       = "Permit outbound HTTPS for controlled service access."
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}