# CDEC Terraform (Dev)

Simple VPC + EKS project for learning.

## Folder layout

```text
modules/vpc/     → VPC, 2 public subnets, Internet Gateway
modules/eks/     → EKS cluster + node group
environments/dev/ → runs both modules together
```

## Run on your laptop

```bash
cd environments/dev
cp backend.hcl.example backend.hcl
# edit bucket and table names in backend.hcl

terraform init -backend-config=backend.hcl
terraform plan
terraform apply
```

## Jenkins

Use the root `Jenkinsfile` (Pipeline from SCM → script path: `Jenkinsfile`).

Stages: **Checkout → Init → Validate → Plan → Apply** (Apply only when `ACTION=apply`).

Copy `backend.hcl` to `environments/dev/` on the Jenkins server before the first run.

## Flow

```text
VPC module  →  vpc_id, subnet_ids
       ↓
EKS module  →  uses those values automatically in main.tf
```
