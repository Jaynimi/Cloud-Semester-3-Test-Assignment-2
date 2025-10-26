Project Bedrock — InnovateMart Inc.

This repository contains Terraform IaC, Kubernetes manifests, IAM policy, and GitHub Actions workflows to provision an EKS cluster and deploy the retail-store-sample-app with in-cluster DBs/brokers.

## Repo layout
Cloud-Semester-3-Test-Assignment-2/
├─ README.md
├─ terraform/
│ ├─ providers.tf
│ ├─ variables.tf
│ ├─ main.tf
│ ├─ outputs.tf
│ ├─ backend.tf
├─ iam/
│ └─ dev-readonly-policy.json
├─ k8s/
│ ├─ namespace.yaml
│ ├─ mysql-deployment.yaml
│ ├─ postgres-deployment.yaml
│ ├─ redis-deployment.yaml
│ ├─ rabbitmq-deployment.yaml
│ ├─ dynamodb-local-deployment.yaml
│ └─ retail-deployments.yaml
└─ .github/workflows/
├─ terraform-plan.yml
└─ terraform-apply.yml

## How to use
1. Create an S3 bucket + DynamoDB table for Terraform state (recommended).
2. Set GitHub repo secrets:
   - AWS_OIDC_ROLE_ARN — the role GitHub Actions will assume (or use AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY if you prefer).
   - AWS_REGION — e.g., us-east-1.
3. terraform init && terraform plan locally, or open a PR to see GitHub Actions plan step.
4. After apply, run:
   ```bash
   aws eks --region <region> update-kubeconfig --name <cluster-name>
   kubectl apply -f k8s/namespace.yaml
   kubectl apply -f k8s/*.yaml
   kubectl get pods -n retail