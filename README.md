# Project Phoenix: The Phoenix Financial Engine

> **Project Purpose Note:** This project serves as a comprehensive, production-grade demonstration of the skills and technologies required to build a modern, cloud-native application. It showcases expertise in microservices architecture, event-driven systems with Kafka, CI/CD, and end-to-end observability.

## Vision

The Phoenix platform is the core financial engine for a modern fintech company, designed to protect the business and its customers by identifying fraudulent transactions in real-time. This project serves as a production-grade blueprint for a scalable, observable, and resilient microservices architecture.

## Core Business Problem

In the fast-paced world of financial technology, the ability to analyze and react to millions of payment events in real-time is critical. This platform is designed to address this challenge by providing a sophisticated, behind-the-scenes risk management system that analyzes every transaction as it occurs, ensuring business integrity and customer trust.

## Key Features

* **Real-Time Transaction Simulation**: A dedicated service reads from a large financial dataset (`fraud.csv`) and publishes a continuous stream of transaction events to a Kafka topic, mimicking a live payment network.
* **Stream-Based Fraud Analysis**: A core service consumes the transaction stream from Kafka in real-time, applying business rules to detect and flag potentially fraudulent activity.
* **High Observability Platform**: The system is fully instrumented from day one. Every request and process is traceable and measurable, with logs, metrics, and traces correlated in a central Grafana dashboard.
* **Business Intelligence Dashboard**: A custom Grafana dashboard provides immediate, actionable insight into the business flow, visualizing key metrics like transaction rates and a live feed of high-value transaction alerts.

## Technology Stack

The technology stack was chosen to build a modern, cloud-native application foundation based on mature, industry-standard tools.

| Component           | Selected Technology              | Justification                                                                                                |
| ------------------- | -------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| Language / Runtime  | Java 11 (LTS)                    | A mature ecosystem with strong typing and high performance suitable for enterprise applications.             |
| Containerization    | Docker                           | The universal standard for packaging applications, ensuring consistency across environments.       |
| Orchestration       | Kubernetes (k8s)                 | The de facto standard for container orchestration, providing automated scaling and self-healing.         |
| Event Streaming     | Apache Kafka                     | The industry-standard platform for building real-time, high-throughput data pipelines.             |
| API Gateway         | ingress-nginx                    | The de facto standard, community-managed Ingress controller for Kubernetes.                        |
| Service Discovery   | HashiCorp Consul                 | A lightweight and reliable tool for service discovery and dynamic configuration.                 |
| Observability       | Grafana, Prometheus, Loki, Tempo | A powerful, integrated stack for visualizing metrics, logs, and traces.                          |

## Getting Started

The entire platform and its dependencies can be provisioned locally on a Docker Desktop environment.

A detailed, step-by-step guide for setup and deployment is available in the [LOCAL_SETUP.md](LOCAL_SETUP.md) file.

## Project Documentation

* **[ARCHITECTURE.md](ARCHITECTURE.md)**: For a deep dive into the system architecture, design principles, and component responsibilities.
* **[PROJECT_PLAN.md](PROJECT_PLAN.md)**: For a detailed breakdown of the development roadmap and task list.
* **[docs/ADRs/README.md](docs/ADRs/README.md)**: For a log of key architectural decisions made during the project's lifecycle.
