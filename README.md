Create cluster with:
kind create cluster --name flyte-local --config

Directory structure:

flyte-kind-local/
├── cluster-config.yaml
├── flyte-namespace.yaml
├── storage-minio.yaml
├── db-postgres.yaml
├── flyte-values-local.yaml
├── helm-install.sh
├── helm-upgrade.sh
└── teardown.sh

If you have problems with helm repo update:
rm -rf ~/.cache/helm
# flyte-on-kind
