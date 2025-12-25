# EKS Platform Demo (Terraform + ALB Ingress)

This project demonstrates deploying a containerized Python application to AWS EKS using Terraform and exposing it publicly via AWS Application Load Balancer (ALB) Ingress.

## Architecture
Traffic flow:
Client → AWS ALB → Kubernetes Ingress → Service → Pods (Flask app)

## Tech Stack
- AWS EKS
- Terraform (modular infrastructure)
- AWS Load Balancer Controller (IRSA)
- Amazon ECR
- Kubernetes (Deployment, Service, Ingress)
- Python (Flask)

## Key Features
- Infrastructure provisioned entirely with Terraform
- IAM Roles for Service Accounts (IRSA) for ALB controller
- Public ALB created dynamically via Kubernetes Ingress
- Health checks integrated with ALB
- Stateless containerized application

## Application Endpoints
- `/health` – health check endpoint
- `/` – public application endpoint

## Deployment Flow
1. Build Docker image
2. Push image to Amazon ECR
3. Deploy Kubernetes manifests
4. ALB Ingress exposes service publicly

## What This Project Demonstrates
- Real-world EKS traffic routing
- Production-style AWS IAM integration
- Debugging ALB + Kubernetes networking issues
- End-to-end cloud infrastructure ownership

## Future Improvements
- HTTPS with ACM
- HPA with metrics-server
- CI/CD pipeline for automated deploys
