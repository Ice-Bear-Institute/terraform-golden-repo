# Terraform Golden Repository

A golden repository template for infrastructure deployment using Terraform, Helm, and ArgoCD. This repository provides a standardized structure and configuration for deploying infrastructure across multiple environments.

## 🏗️ Repository Structure

```
├── terraform/                 # Terraform configurations
│   ├── dev/                   # Development environment
│   ├── qa/                    # QA environment  
│   ├── stage/                 # Staging environment
│   └── gamma/                 # Gamma environment
├── helm/                      # Helm charts
│   └── charts/
│       ├── app-chart/         # Main application chart
│       └── common-chart/      # Shared components
├── argocd/                    # ArgoCD applications
│   ├── applications/          # Individual app manifests
│   └── app-of-apps/          # App of Apps pattern
├── .github/hooks/            # Git hooks
└── setup.sh                 # Repository setup script
```

## 🚀 Quick Start

1. **Clone this repository** for your project:
   ```bash
   git clone https://github.com/Ice-Bear-Institute/terraform-golden-repo.git your-project-name
   cd your-project-name
   ```

2. **Run the setup script**:
   ```bash
   ./setup.sh
   ```

3. **Customize backend configurations**:
   - Replace `REPO_NAME` in all `terraform/*/backend.tf` files
   - Use a unique name for your project (e.g., `my-awesome-project`)

4. **Configure your environments**:
   - Update variables in `terraform/*/variables.tf`
   - Modify resources in `terraform/*/main.tf` as needed

## 📁 Terraform Environments

Each environment (`dev`, `qa`, `stage`, `gamma`) contains:

- **`backend.tf`**: S3 backend configuration (⚠️ **MUST be customized**)
- **`main.tf`**: Main Terraform configuration
- **`variables.tf`**: Environment-specific variables
- **`outputs.tf`**: Terraform outputs

### Backend Configuration

**🚨 IMPORTANT**: You must replace `REPO_NAME` in all `backend.tf` files before committing:

```hcl
terraform {
  backend "s3" {
    bucket = "terraform-state-YOUR-PROJECT-NAME"  # Change this!
    key    = "dev/terraform.tfstate"
    region = "us-west-2"
    
    dynamodb_table = "terraform-locks-YOUR-PROJECT-NAME"  # Change this!
    encrypt        = true
  }
}
```

The pre-commit hook will prevent commits if this isn't done.

## ⚓ Helm Charts

The `helm/` directory contains Kubernetes deployment configurations:

- **`charts/app-chart/`**: Main application Helm chart
- **`charts/common-chart/`**: Shared components and templates

### Usage

```bash
# Install chart for development
helm install myapp ./helm/charts/app-chart -f helm/charts/app-chart/values-dev.yaml

# Upgrade existing deployment
helm upgrade myapp ./helm/charts/app-chart -f helm/charts/app-chart/values-dev.yaml
```

## 🔄 ArgoCD GitOps

ArgoCD configurations for GitOps deployments:

- **`applications/`**: Individual ArgoCD Application manifests
- **`app-of-apps/`**: Bootstrap configuration for managing multiple apps

### Deployment

```bash
# Bootstrap all applications
kubectl apply -f argocd/app-of-apps/bootstrap.yaml

# Or deploy individual applications
kubectl apply -f argocd/applications/
```

## 🔒 Pre-commit Hooks

The repository includes a pre-commit hook that:

- ✅ Validates that `backend.tf` files have been customized
- ❌ Prevents commits with uncustomized `REPO_NAME` placeholders
- 🔍 Ensures each deployment uses unique S3/DynamoDB resources

## 🛠️ Development Workflow

1. **Make changes** to Terraform, Helm, or ArgoCD configurations
2. **Test locally** using appropriate tools:
   ```bash
   # Terraform
   cd terraform/dev
   terraform plan
   
   # Helm
   helm template ./helm/charts/app-chart
   
   # ArgoCD
   argocd app diff myapp
   ```
3. **Commit changes** - pre-commit hook will validate configurations
4. **Deploy** using your preferred method (CI/CD, manual, etc.)

## 📚 Best Practices

- **Environment Isolation**: Each environment has its own state file and configuration
- **Backend Security**: Always use unique S3 buckets and DynamoDB tables per project
- **Versioning**: Tag releases and use semantic versioning for Helm charts  
- **Secrets Management**: Never commit secrets; use tools like AWS Secrets Manager
- **Documentation**: Keep environment-specific documentation up to date

## 🤝 Contributing

1. Fork this repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**⚠️ Remember**: Always customize the `backend.tf` files before your first commit!
