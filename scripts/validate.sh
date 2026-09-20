#!/usr/bin/env bash

set -euo pipefail

REPOSITORY_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TERRAFORM_DIRECTORY="${REPOSITORY_ROOT}/terraform"

if ! command -v terraform >/dev/null 2>&1; then
  echo "ERROR: Terraform is not installed or is not available in PATH." >&2
  exit 1
fi

echo "Terraform version:"
terraform version

echo "Checking Terraform formatting..."
terraform -chdir="${TERRAFORM_DIRECTORY}" fmt -check -recursive

echo "Initializing Terraform without a backend..."
terraform -chdir="${TERRAFORM_DIRECTORY}" init \
  -backend=false \
  -input=false \
  -no-color

echo "Validating Terraform configuration..."
terraform -chdir="${TERRAFORM_DIRECTORY}" validate -no-color

echo "Terraform validation completed successfully."