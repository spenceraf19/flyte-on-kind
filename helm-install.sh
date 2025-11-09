#!/bin/bash
# 0. Label control plane
kubectl label node flyte-control-plane ingress-ready=true

# 1. Create namespace
kubectl apply -f flyte-namespace.yaml

# 2. Add Flyte Helm repo
helm repo add flyteorg https://flyteorg.github.io/flyte
helm repo update

# 3. Apply Minio manifest
kubectl apply -f storage-minio.yaml

# 4. Apply Postgres manifest
kubectl apply -f db-postgres.yaml

# 5. Deploy ingress-nginx controller (must run before applying any ingress!)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.0/deploy/static/provider/kind/deploy.yaml

# Optional: wait for ingress-nginx controller to be ready
kubectl wait --namespace ingress-nginx \
  --for=condition=Ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s

# 6. Install Flyte with custom values file
helm install flyte flyteorg/flyte-core -n flyte -f flyte-values.yaml

# 7. Apply ingress resources for Minio, flyteadmin, flyteconsole
kubectl apply -f minio-ingress.yaml
kubectl apply -f flyteadmin-ingress.yaml
kubectl apply -f flyteconsole-ingress.yaml

# (optionally, apply ingress resources for FlyteConsole/FlyteAdmin if created)
# kubectl apply -f flyteconsole-ingress.yaml
# kubectl apply -f flyteadmin-ingress.yaml

echo "Setup complete! Don't forget to add '127.0.0.1 minio.local.flyte.local' to your /etc/hosts file."
