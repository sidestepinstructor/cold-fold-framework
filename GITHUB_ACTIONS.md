# GitHub Actions CI/CD Setup for Cold Fold Engine

## Workflows

### 1. Build and Push (`build.yml`)
- **Trigger:** Push to `main`/`develop`, PRs, and semantic version tags (`v*`)
- **Actions:**
  - Multi-platform builds (linux/amd64, linux/arm64)
  - Automatic Docker Hub push with semantic tagging
  - Trivy vulnerability scanning
  - GitHub Advanced Security integration

### 2. Test (`test.yml`)
- **Trigger:** Push to `main`/`develop`, PRs
- **Actions:**
  - Python unit tests with pytest
  - Code coverage reporting
  - Redis service for integration tests
  - Codecov integration

### 3. Deploy (`deploy.yml`)
- **Trigger:** Successful build + manual workflow_dispatch
- **Actions:**
  - Automated staging deployment
  - Manual production deployment (requires approval)
  - SSH deployment to remote servers
  - Slack notifications

## Required GitHub Secrets

Set these in **Settings → Secrets and variables → Actions**:

### Docker Hub
- `DOCKER_USERNAME`: Your Docker Hub username
- `DOCKER_PASSWORD`: Docker Hub access token (not password)

### Deployment (Optional)
- `DEPLOY_KEY`: SSH private key for deployment servers
- `STAGING_HOST`: Staging server hostname/IP
- `STAGING_USER`: Staging server SSH user
- `PROD_HOST`: Production server hostname/IP
- `PROD_USER`: Production server SSH user
- `SLACK_WEBHOOK`: Slack webhook URL for notifications

## Quick Start

1. Push to GitHub:
   ```bash
   git remote add origin https://github.com/YOUR_USER/cold-fold-framework.git
   git branch -M main
   git push -u origin main
   ```

2. Set secrets in GitHub Settings

3. Tag a release to trigger builds:
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

## Image Tags Generated

For commit `abc123def` on `main` branch:
- `docker.io/USERNAME/cold-fold-engine:main`
- `docker.io/USERNAME/cold-fold-engine:main-abc123d`
- `docker.io/USERNAME/cold-fold-engine:latest` (if main branch)

For tag `v1.2.3`:
- `docker.io/USERNAME/cold-fold-engine:1.2.3`
- `docker.io/USERNAME/cold-fold-engine:1.2`
- `docker.io/USERNAME/cold-fold-engine:latest`

## Build Cache

GitHub Actions cache is automatically stored and reused across runs, speeding up subsequent builds by ~40%.

## Vulnerability Scanning

Trivy scans your image after each build and uploads results to GitHub Security tab.
