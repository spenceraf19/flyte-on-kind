#!/bin/bash
kubectl apply -f flyte-namespace.yaml
helm repo add flyteorg https://flyteorg.github.io/flyte
helm repo update
kubectl apply -f storage-minio.yaml
kubectl apply -f db-postgres.yaml
helm install flyte flyteorg/flyte-core -n flyte -f flyte-values.yaml

