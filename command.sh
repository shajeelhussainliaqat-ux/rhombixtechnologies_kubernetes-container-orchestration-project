#!/usr/bin/env bash
set -euo pipefail

# Apply the Kubernetes manifests and show their status.
# Run this script from the directory containing deployment.yaml and service.yaml.

if ! command -v kubectl >/dev/null 2>&1; then
  echo "ERROR: kubectl is not installed or not on PATH."
  exit 1
fi

if [[ ! -f deployment.yaml || ! -f service.yaml ]]; then
  echo "ERROR: deployment.yaml and/or service.yaml not found."
  echo "Run this script from the project directory."
  exit 1
fi

echo "== Current Kubernetes context =="
kubectl config current-context

echo
echo "== Cluster nodes =="
kubectl get nodes

echo
read -r -p "Apply deployment.yaml and service.yaml to this cluster? [y/N] " answer
case "$answer" in
  [yY]|[yY][eE][sS])
    kubectl apply -f deployment.yaml
    kubectl apply -f service.yaml
    ;;
  *)
    echo "Cancelled. No manifests were applied."
    exit 0
    ;;
esac

echo
echo "== Deployment status =="
kubectl rollout status deployment/kubernetes-demo
kubectl get deployments
kubectl get pods
kubectl get services

echo
echo "To open the app, run in a terminal:"
echo "kubectl port-forward service/kubernetes-demo 8080:80"
echo "Then visit http://localhost:8080"
