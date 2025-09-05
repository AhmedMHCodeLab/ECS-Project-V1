# ECS Project V1

A secure, containerized Threat Composer application deployed with ECS Fargate, Route 53 DNS, and HTTPS.

## Structure

- `/app` - React app (or chosen frontend)
- `/infra` - Terraform code, split into modules
- `/cicd` - Pipeline config (GitHub Actions, CodePipeline, etc.)
- `/docs` - Architecture diagram, setup guides, decisions

## Features

- **ECS Fargate** - Serverless container orchestration
- **HTTPS Support** - ACM certificate for secure connections
- **DNS Management** - Route 53 for custom domain
- **CI/CD Pipeline** - GitHub Actions for deployment

## Quick Start

1. Update `infra/terraform.tfvars` with your domain settings
2. Run `terraform apply` in the `infra` directory
3. Access the application at https://tm.yourdomain.com

Refer to `Plan.md` for more details.
