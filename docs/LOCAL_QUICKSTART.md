# Local Environment Quickstart Guide

This guide contains the daily-use commands to start, stop, and manage the Project Phoenix local Kubernetes environment. For one-time setup instructions, see the [LOCAL\_SETUP.md](https://www.google.com/search?q=../LOCAL_SETUP.md) file.

-----
## Helper script (wiping everything)
You can find automated the deletion of existing cluster and creating a new one by running the following commands from the root directory
```bash
./scripts/setup-cluster-local.sh
```

## Cluster Management (Start/Stop/Status)

All commands are intended to be run from the project's root directory.

```bash
# Task 1.2: Start the local Kubernetes cluster.
# This command reads the configuration file to create the control-plane and worker nodes.
# The cluster name 'phoenix-cluster' is specified inside the YAML file.
kind create cluster --config infra/clusters/kind-config.yaml

# Check the status of your newly created cluster.
kubectl cluster-info --context kind-phoenix-cluster

# Stop and completely delete the local Kubernetes cluster.
# This is a destructive action that removes all cluster containers.
kind delete cluster --name phoenix-cluster
```

## Reference: Foundational Service Deployments

These are the Helm commands used to deploy the core infrastructure services.

```bash
# Task 1.3: Install ingress-nginx to act as the API Gateway / Ingress Controller.
helm install ingress-nginx ingress-nginx/ingress-nginx --namespace ingress-nginx --create-namespace

# Task 1.3: Install HashiCorp Consul for service discovery.
helm install consul hashicorp/consul --namespace consul --create-namespace --set server.replicas=3 --set ui.enabled=true

# Task 1.4: Add necessary Helm repositories.
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Task 1.4: Install Prometheus & Grafana for metrics and visualization.
helm install prometheus prometheus-community/kube-prometheus-stack --namespace prometheus --create-namespace

# Task 1.4: Install Tempo for distributed tracing.
helm install tempo grafana/tempo --namespace tempo --create-namespace

# Task 1.4: Install Kafka for event streaming.
helm install kafka bitnami/kafka --namespace kafka --create-namespace
```