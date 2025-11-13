# Nextcloud ArgoCD GitOps Repo

This repo deploys Nextcloud with PostgreSQL via ArgoCD using HelmRelease manifests.

- `base/`: Base Kubernetes manifests and HelmRelease definitions.
- `overlays/`: Environment-specific patches (dev/prod).
- `apps/`: ArgoCD Application manifests.
# nextcloud-argocd
