#!/bin/bash
helm uninstall flyte -n flyte
kubectl delete -f storage-minio.yaml
kubectl delete -f db-postgres.yaml
kubectl delete -f flyte-namespace.yaml

