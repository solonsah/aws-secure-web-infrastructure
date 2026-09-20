# Sample Output

This directory is reserved for sanitized examples of Terraform formatting, validation, and planning output.

No live AWS account numbers, resource identifiers, public IP addresses, DNS names, credentials, Terraform state, employer information, or customer data may be stored here.

The current project has passed:

```text
terraform -chdir=terraform fmt -check -recursive
terraform -chdir=terraform validate

Static validation does not mean the infrastructure has been deployed or tested in a live AWS environment.
