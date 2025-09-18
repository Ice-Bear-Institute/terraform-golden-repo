# ArgoCD Applications

This directory contains ArgoCD application manifests for GitOps deployment.

## Structure

- `applications/`: Individual ArgoCD application manifests
- `app-of-apps/`: App of Apps pattern for managing multiple applications

## Usage

1. Apply the app-of-apps manifest to bootstrap all applications:
   ```bash
   kubectl apply -f app-of-apps/bootstrap.yaml
   ```

2. Or deploy individual applications:
   ```bash
   kubectl apply -f applications/
   ```

## Configuration

- Update repository URLs and paths in the application manifests
- Modify target namespaces and clusters as needed
- Configure sync policies and health checks