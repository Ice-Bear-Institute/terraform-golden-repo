#!/bin/bash

# Setup script for the golden repository
# This script helps configure the repository for first use

set -e

echo "🚀 Setting up terraform-golden-repo..."

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Error: This script must be run from the root of a git repository"
    exit 1
fi

# Install pre-commit hook
echo "📋 Installing pre-commit hook..."
if [ -f ".github/hooks/pre-commit" ]; then
    mkdir -p .git/hooks
    cp .github/hooks/pre-commit .git/hooks/pre-commit
    chmod +x .git/hooks/pre-commit
    echo "✓ Pre-commit hook installed"
else
    echo "❌ Error: Pre-commit hook not found at .github/hooks/pre-commit"
    exit 1
fi

# Check for REPO_NAME placeholder
echo "🔍 Checking for uncustomized backend files..."
uncustomized_files=$(find terraform/ -name "backend.tf" -exec grep -l "REPO_NAME" {} \; 2>/dev/null || true)

if [ -n "$uncustomized_files" ]; then
    echo "⚠️  WARNING: Found uncustomized backend.tf files:"
    echo "$uncustomized_files" | sed 's/^/  - /'
    echo ""
    echo "Please replace 'REPO_NAME' with your actual repository name."
    echo "Example: terraform-state-my-project"
    echo ""
    echo "The pre-commit hook will prevent commits until this is fixed."
else
    echo "✓ All backend.tf files are properly customized"
fi

echo ""
echo "🎉 Setup complete! Your golden repository is ready to use."
echo ""
echo "Next steps:"
echo "1. Customize backend.tf files if not already done"
echo "2. Review and modify Terraform configurations for your needs"
echo "3. Update Helm chart values"
echo "4. Configure ArgoCD applications"
echo ""
echo "For more information, see README.md"