#!/bin/bash

# This function is called when the script is exited (e.g., via Ctrl+C).
# It finds and terminates all background port-forward jobs.
cleanup() {
    echo -e "\nShutting down all port-forward tunnels..."
    kill $(jobs -p)
}

# The 'trap' command registers the 'cleanup' function to run on exit.
trap cleanup EXIT

echo "🚀 Starting port-forwards for all UI services..."
echo "--------------------------------------------------"

# Start each port-forward command in the background using '&'

echo "Forwarding Consul UI               -> http://localhost:8500"
kubectl port-forward -n consul svc/consul-ui 8500:80 &

echo "Forwarding Prometheus UI         -> http://localhost:9090"
kubectl port-forward -n prometheus svc/prometheus-kube-prometheus-prometheus 9090:9090 &

echo "Forwarding Grafana UI              -> http://localhost:3000"
kubectl port-forward -n prometheus svc/prometheus-grafana 3000:80 &

echo "Forwarding Alertmanager UI       -> http://localhost:9093"
kubectl port-forward -n prometheus svc/prometheus-kube-prometheus-alertmanager 9093:9093 &

echo "--------------------------------------------------"
echo "✅ All tunnels are active."
echo "   Press Ctrl+C in this terminal to shut them all down."

# The 'wait' command pauses the script here, keeping it running.
# The script will only exit when you interrupt it.
wait
