# Secure AWS Web Infrastructure

A modular Terraform project that models a secure and highly available web application architecture on Amazon Web Services.

> This repository is a portfolio and learning project. It uses fictional names, private example networks, and no production credentials or employer infrastructure.

## Project Objectives

- Define repeatable AWS infrastructure using Terraform
- Distribute application resources across two Availability Zones
- Place application instances in private subnets
- Expose the application through an HTTPS Application Load Balancer
- Prevent direct inbound SSH access
- Require EC2 Instance Metadata Service Version 2
- Encrypt EC2 root volumes
- Provide Auto Scaling and load-balancer health checks
- Validate Terraform automatically before changes are merged
- Avoid deploying unnecessary chargeable resources during development

## Architecture

```mermaid
flowchart TB
    Internet["Internet clients"]
    ALB["HTTPS Application Load Balancer<br/>Public subnets"]
    ASG["Auto Scaling application tier<br/>Private subnets"]
    TG["Application target group<br/>Port 8080"]
    VPC["AWS VPC across two Availability Zones"]

    Internet -->|HTTPS 443| ALB
    ALB -->|HTTP 8080| TG
    TG --> ASG
    VPC --- ALB
    VPC --- ASG

    
## Repositoru Structure

    .
├── diagrams/
├── docs/
│   ├── architecture.md
│   └── security-controls.md
├── sample-output/
├── scripts/
│   └── validate.sh
└── terraform/
    ├── modules/
    │   ├── compute/
    │   ├── networking/
    │   └── security/
    ├── main.tf
    ├── outputs.tf
    ├── providers.tf
    ├── terraform.tfvars.example
    ├── variables.tf
    └── versions.tf

    Security Controls
Application instances receive no public IP addresses
No inbound SSH security-group rule is defined
Public ingress is limited to HTTPS on TCP port 443
Application ingress is permitted only from the load-balancer security group
EC2 Instance Metadata Service Version 2 is required
EBS root volumes are encrypted
Invalid HTTP headers are dropped at the load balancer
Private subnets have no default internet route in the example configuration
Terraform state, variable files, credentials, and local working directories are excluded from Git

See Security Controls for details.

Cost-Aware Design

The example intentionally excludes a NAT Gateway because NAT Gateways incur hourly and data-processing charges. A production implementation may add redundant NAT Gateways, VPC endpoints, centralized egress, or another approved outbound-access design.

The configuration must not be deployed without reviewing expected AWS costs.

Validation

From the repository root:
terraform -chdir=terraform fmt -check -recursive
terraform -chdir=terraform init -backend=false
terraform -chdir=terraform validate

Validation checks formatting and Terraform configuration integrity. It does not prove that the architecture has been deployed or tested in a live AWS account.

Deployment Safety

Do not run terraform apply until all of the following are complete:

AWS account and Region are confirmed.
Required approvals are documented.
Estimated costs are reviewed.
Remote state and state locking are configured.
An approved ACM certificate is supplied securely.
Logging, monitoring, backup, and rollback requirements are defined.
The execution plan is reviewed.

Never commit AWS access keys, secret keys, session tokens, account numbers, certificate ARNs, production IP addresses, Terraform state, or employer information.

Technologies
Terraform
Amazon VPC
Amazon EC2
EC2 Auto Scaling
Application Load Balancer
AWS Security Groups
Amazon EBS
GitHub Actions

Project Status

Terraform formatting and static configuration validation are implemented. This repository does not claim that the infrastructure has been deployed to a production AWS account.

License

This project is licensed under the MIT License.
