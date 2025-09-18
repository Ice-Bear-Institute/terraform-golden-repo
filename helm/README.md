# Helm Charts

This directory contains Helm charts for the application deployment.

## Structure

- `charts/`: Directory containing Helm chart templates
  - `app-chart/`: Main application chart
  - `common-chart/`: Common/shared chart components

## Usage

1. Customize the chart values in `values.yaml` for each environment
2. Deploy using:
   ```bash
   helm install <release-name> ./charts/app-chart -f values-<env>.yaml
   ```

## Chart Development

- Follow Helm best practices
- Use semantic versioning for chart versions
- Document all configurable values