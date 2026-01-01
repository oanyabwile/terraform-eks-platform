# EKS Platform Demo (Terraform + ALB Ingress)

This project demonstrates deploying and operating a production-style containerized application on AWS EKS, exposed publicly using an AWS Application Load Balancer (ALB) via Kubernetes Ingress.

The focus is on **real-world EKS architecture**, **secure AWS IAM integration**, and **end-to-end traffic flow ownership**, not simplified demo patterns.

---

## Project Goal

The goal of this project was to design and operate an EKS workload using production-grade AWS primitives:

- No NodePort shortcuts
- No manual load balancer creation
- Secure, least-privilege IAM via IRSA
- Controller-driven AWS resource provisioning

This mirrors how EKS is typically used in real environments.

---

## Architecture

Traffic flow:

```text 
Client
↓
AWS Application Load Balancer (ALB)
↓
Kubernetes Ingress (ALB Ingress Controller)
↓
ClusterIP Service
↓
Pods (Flask application)
```

The ALB is **created dynamically** by the AWS Load Balancer Controller in response to Kubernetes Ingress resources.

---

## Tech Stack

- AWS EKS
- Terraform (modular infrastructure)
- AWS Load Balancer Controller
- IAM Roles for Service Accounts (IRSA)
- Amazon ECR
- Kubernetes (Deployment, Service, Ingress)
- Python (Flask)

---

## Application Endpoints

- `/` – Public application endpoint
- `/health` – Health check endpoint (used by Kubernetes and ALB)

---

## Deployment Flow

1. Build Docker image locally
2. Push image to Amazon ECR
3. Deploy Kubernetes manifests (Deployment, Service)
4. AWS Load Balancer Controller detects Ingress
5. ALB is provisioned dynamically via AWS APIs
6. Traffic is routed to healthy pods based on `/health` checks

---

## Key Features

- Infrastructure provisioned entirely with Terraform
- Secure AWS IAM integration using IRSA (no node role over-permissioning)
- Public ALB created automatically from Kubernetes Ingress
- Health checks integrated end-to-end (ALB → Service → Pod)
- Stateless containerized application

---

## Operational Considerations

- Kubernetes Ingress resources are declarative and require a running controller to provision AWS resources
- ALB provisioning is asynchronous and dependent on correct IAM permissions
- IRSA is required to prevent AWS controllers from inheriting node IAM roles
- Health checks must align across ALB, Service, and Pod layers
- DNS propagation may lag after successful ALB creation
- Primary debugging signals come from `kubectl describe`, controller logs, and AWS IAM errors


---

## What This Project Demonstrates

- Production-grade EKS traffic routing
- Secure AWS IAM integration patterns
- Real-world Kubernetes + AWS debugging
- Full ownership from infrastructure to application
- Understanding of Kubernetes control plane vs controllers vs AWS APIs

---

## Future Improvements

- HTTPS with ACM and TLS termination
- Horizontal Pod Autoscaler (HPA) with metrics-server
- CI/CD pipeline for automated builds and deploys
- Centralized logging and metrics (CloudWatch / Prometheus)

---


