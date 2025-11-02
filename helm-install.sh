#!/bin/bash
kubectl apply -f flyte-namespace.yaml
helm repo add flyteorg https://flyteorg.github.io/flyte
helm repo update
helm install flyte flyteorg/flyte-core -n flyte -f flyte-values.yaml

