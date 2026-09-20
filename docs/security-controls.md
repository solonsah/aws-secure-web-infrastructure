# Security Controls

## Purpose

This document identifies security controls implemented in the Terraform configuration and additional controls required before production use.

## Implemented in Code

| Control | Implementation |
|---|---|
| Network isolation | Application instances are placed in private subnets |
| Public IP prevention | Public-IP assignment is disabled on all subnets |
| Restricted application ingress | Application port 8080 accepts traffic only from the load-balancer security group |
| HTTPS-only public ingress | The load-balancer security group permits inbound TCP port 443 |
| No inbound SSH | No inbound TCP port 22 rule is defined |
| Metadata protection | EC2 Instance Metadata Service Version 2 tokens are required |
| Storage encryption | EC2 root EBS volumes are encrypted |
| Header protection | The load balancer drops invalid HTTP headers |
| Availability | Subnets and application capacity span two Availability Zones |
| Health monitoring | The target group performs HTTP health checks |
| Controlled replacement | Auto Scaling uses rolling instance refresh |
| Secret exclusion | Terraform variables, state files, credentials, and local working files are ignored by Git |
| Provider integrity | Provider selections and checksums are recorded in `.terraform.lock.hcl` |

## Deployment-Time Requirements

The following must be completed through an approved process before deployment:

- Supply an approved ACM certificate without committing its ARN to the repository
- Configure a secure remote Terraform backend with encryption and state locking
- Use short-lived AWS credentials or workload identity
- Review Terraform plans before approval
- Configure least-privilege deployment permissions
- Enable load-balancer access logging
- Configure CloudTrail and appropriate AWS Config rules
- Configure CloudWatch metrics, alarms, and log retention
- Establish backup, incident-response, and rollback procedures
- Review the design with security and application owners
- Estimate and approve AWS costs

## Recommended Production Enhancements

- AWS WAF for application-layer filtering
- AWS Shield protections appropriate to the workload
- VPC endpoints for private AWS service access
- Redundant outbound connectivity if internet egress is required
- Systems Manager Session Manager for controlled administration
- IAM instance profiles with least-privilege policies
- Centralized logging and security monitoring
- Amazon GuardDuty and Security Hub
- Route 53 records and certificate-renewal monitoring
- Automated vulnerability and policy scanning
- Separate AWS accounts and Terraform state per environment

## Credential Handling

Never commit:

- AWS access-key IDs
- AWS secret-access keys
- AWS session tokens
- Passwords or private keys
- Terraform state files
- Real account numbers or certificate ARNs
- Employer names, internal domains, hostnames, or network ranges
- Customer, employee, or production data

## Validation Scope

`terraform validate` checks configuration structure and provider compatibility. It does not prove that:

- The infrastructure has been deployed
- Runtime security controls are operating
- The application is healthy
- The architecture meets a specific compliance framework
- AWS permissions or quotas are sufficient
- The design is production-ready

Those conclusions require deployment testing, evidence collection, security review, and operational acceptance.