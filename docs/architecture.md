# Architecture

## Overview

This project models a highly available AWS web tier using Terraform. Resources are distributed across two Availability Zones. The load balancer occupies public subnets, while application instances run in private subnets without public IP addresses.

## Traffic Flow

```mermaid
flowchart TB
    Client["Internet client"]
    IGW["Internet Gateway"]
    ALB["Application Load Balancer<br/>HTTPS 443"]
    SG1["Load-balancer security group"]
    TG["Target group<br/>HTTP 8080"]
    SG2["Application security group"]
    ASG["Auto Scaling group<br/>Private instances"]

    Client --> IGW
    IGW --> ALB
    SG1 --- ALB
    ALB --> TG
    TG --> ASG
    SG2 --- ASG

    A client sends an HTTPS request on TCP port 443.
The internet gateway provides connectivity to the public subnets.
The Application Load Balancer receives the request.
The load balancer forwards traffic to the target group on TCP port 8080.
The application security group accepts port 8080 only from the load-balancer security group.
The Auto Scaling group maintains application instances across two private subnets.
Network Layout
Component	Availability Zone 1	Availability Zone 2
Public subnet	10.20.10.0/24	10.20.20.0/24
Private application subnet	10.20.110.0/24	10.20.120.0/24
Load balancer	Enabled	Enabled
Application instances	Auto Scaling	Auto Scaling

The parent VPC uses the fictional private range 10.20.0.0/16.

Design Decisions
Private application instances

Application instances do not receive public IP addresses. They are reached only through the load balancer.

No inbound SSH
The security module contains no inbound TCP port 22 rule. A production design should use an approved management method such as AWS Systems Manager Session Manager with the required IAM role and VPC endpoints.

HTTPS entry point

The architecture reserves TCP port 443 for the public entry point. The HTTPS listener is created only when an approved ACM certificate ARN is supplied securely during deployment.

Cost-aware private routing

The example does not create a NAT Gateway. This prevents accidental hourly and data-processing charges during portfolio development. Production outbound connectivity would require an approved design using redundant NAT Gateways, VPC endpoints, or centralized egress.

High availability

Public and private subnets span two Availability Zones. The Application Load Balancer and Auto Scaling group use both zones to reduce dependence on a single zone.

Current Limitations
The project has not been deployed to a live AWS account.
No remote Terraform backend is configured.
No NAT Gateway or VPC endpoints are configured.
No Web Application Firewall is configured.
No load-balancer access-log destination is configured.
No DNS record or Route 53 hosted zone is configured.
No database tier is included.
No production certificate is stored in the repository.

These omissions are documented intentionally rather than represented as completed production features.