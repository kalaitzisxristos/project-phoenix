#!/bin/bash

set -euo pipefail

# === Config ===
CLUSTER_NAME="phoenix-cluster"
CONSUL_VALUES="consul-values.yaml"

# === 1. Create/Reset Kind Cluster ===
echo -e "\n🚀\n🚀 Deleting any existing Kind cluster...\n🚀"
kind delete cluster --name "$CLUSTER_NAME"

echo -e "\n🚀\n🚀 Creating Kind cluster...\n🚀"
kind create cluster --name "$CLUSTER_NAME" --config infra/clusters/kind-config.yaml

# === 2. Add and Update Helm Repositories ===
echo -e "\n📦\n📦 Adding Helm repos...\n📦"
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# === 3. Install Ingress Controller ===
echo -e "\n🌐\n🌐 Installing ingress-nginx...\n🌐"
helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace

# === 4. Install Prometheus Stack ===
echo -e "\n📊\n📊 Installing Prometheus stack...\n📊"
helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace prometheus \
  --create-namespace \
  --timeout 15m

# === 5. Install Consul (CRDs included) ===
echo -e "\n🧭\n🧭 Installing Consul (with Gateway CRDs)...\n🧭"
helm install consul hashicorp/consul \
  --version 1.4.1 \
  -f "$CONSUL_VALUES" \
  --namespace consul \
  --create-namespace \
  --wait \
  --set syncCatalog.enabled=true

# === 6. Install Tempo ===
echo -e "\n🕓\n🕓 Installing Tempo (tracing backend)...\n🕓"
# This installs the Tempo backend for collecting traces.
# The UI for Tempo is accessed via Grafana (http://localhost:3000).
helm install tempo grafana/tempo \
  --namespace tempo \
  --create-namespace

# === 7. Install Kafka ===
echo -e "\n📬\n📬 Installing Kafka...\n📬"
helm install kafka bitnami/kafka \
  --namespace kafka \
  --create-namespace

# === 8. Build and Load Service Docker Image ===
echo -e "\n🔧\n🔧 Building service-template image...\n🔧"
(cd libs/phoenix-shared && mvn clean install)

echo -e "\n🐳\n🐳 Building Docker image for service-template...\n🐳"
docker build -t service-template:1.0 -f apps/service-template/Dockerfile .

echo -e "\n📦\n📦 Loading image into Kind...\n📦"
kind load docker-image service-template:1.0 --name "$CLUSTER_NAME"

# === 9. Apply Kubernetes Manifests ===
echo -e "\n🚢\n🚢 Deploying service-template to cluster...\n🚢"
kubectl apply -f infra/manifests/service-template/

# === 10. Verify Everything ===
echo -e "\n🔍\n🔍 Getting Helm releases...\n🔍"
helm list -A

echo -e "\n🔍\n🔍 Getting all pods...\n🔍"
kubectl get pods -A

echo -e "\n🔍\n🔍 Getting all services...\n🔍"
kubectl get svc -A

echo -e "\n🔍\n🔍 Getting relevant CRDs...\n🔍"
kubectl get crds | grep -E 'consul|gateway'

echo -e "\n✅\n✅ Setup complete.\n✅"

