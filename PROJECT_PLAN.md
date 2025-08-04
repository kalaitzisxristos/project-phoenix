# Project Phoenix: Plan & Roadmap

## 1. Project Goal

The primary goal is to build the "Phoenix Financial Engine," a modern, cloud-native financial engine designed to protect a fintech business by identifying fraudulent transactions in real-time. This project will result in a trusted, performance-validated platform that serves as a tangible demonstration of a scalable, observable, and resilient microservices architecture.

## 2. Project Directory Structure

To ensure a clean separation of concerns, the project will adhere to the following directory structure:
```
/project-phoenix
├── .github/
│   └── workflows/                # GitHub Actions for CI/CD
├── apps/                         # Contains all microservice source code
│   ├── service-template/         # The template for all new services
│   ├── authentication-service/   # Handles system/user authentication
│   ├── simulator-transactions/   # Reads and publishes transaction data
│   └── fraud-detection-service/  # Consumes and analyzes transactions
├── data/                         # Holds the dataset for the simulator
│   └── fraud.csv                 #
├── infra/                        # All infrastructure-as-code
│   ├── clusters/                 # Local cluster definitions
│   └── manifests/                # Kubernetes manifests for all components
└── scripts/                      # Helper scripts
```
## 3. Phased Deliverables

The project is broken down into three main deliverables, with a total estimated duration of 90 hours.

### Deliverable 1: Foundation & Tooling (First 30 Hours)

**Goal**: Set up a complete, production-grade local development environment and deploy the foundational infrastructure for the Phoenix platform.

* **Task 1.1: Environment Setup & Tooling**
    * **Estimate**: 2 Hours
    * **Description**: Install all necessary command-line tools (kubectl, Helm, Kind) for managing Kubernetes locally.
* **Task 1.2: Setup Local Kubernetes Cluster (Port-Remapped)**
    * **Estimate**: 2 Hours
    * **Description**: Provision a local Kubernetes cluster using Kind, with remapped ports (80->8088, 443->8443) to avoid conflicts with existing services on the host machine.
* **Task 1.3: Deploy Foundational Platforms (Gateway & Service Discovery)**
    * **Estimate**: 3 Hours
    * **Description**: Deploy ingress-nginx (API Gateway) and HashiCorp Consul (Service Discovery) into the Kubernetes cluster using their official Helm charts.
* **Task 1.4: Deploy the Observability Stack & Kafka**
    * **Estimate**: 6 Hours
    * **Description**: Deploy Grafana, Prometheus, Loki, Tempo, and a Kafka cluster into Kubernetes to power the platform's observability and transaction stream capabilities.
* **Task 1.5: Create the Microservice Template**
    * **Estimate**: 8 Hours
    * **Description**: Create a reusable Spring Boot project template that includes pre-configured clients for Kafka, observability (Micrometer, Loki), and service discovery (Consul), along with a multi-stage Dockerfile for producing lean images.
* **Task 1.6: Build & Deploy Authentication Service**
    * **Estimate**: 9 Hours
    * **Description**: Create and deploy the first microservice from the template to validate that the entire platform's plumbing is working end-to-end. This service will eventually secure access to fraud analytics dashboards and APIs.

### Deliverable 2: The Core Business Logic (Next 30 Hours)

**Goal**: Implement the core business function of the platform: simulating and processing a high-volume stream of financial transactions.

* **Task 2.1: Implement the Transaction Simulator Service**
    * **Estimate**: 15 Hours
    * **Description**: Create a service that reads from the provided fraud dataset, creates a structured JSON message for each row, and publishes it to a Kafka topic to simulate a live payment stream. The service will include a configurable delay and will loop indefinitely to provide a continuous stream.
* **Task 2.2: Create the Fraud Detection Service (Stub)**
    * **Estimate**: 10 Hours
    * **Description**: Create the heart of the Phoenix engine: a service that subscribes to the Kafka transaction topic, deserializes the messages, and applies a basic business rule (e.g., flag transactions over a certain amount).
* **Task 2.3: Build the Business Intelligence Dashboard**
    * **Estimate**: 5 Hours
    * **Description**: Create a dedicated Grafana dashboard titled "Phoenix - Real-Time Transaction Monitoring" to visualize the platform's value. Panels will include transaction rates, a live feed of high-value transaction alerts, and combined system logs.

### Deliverable 3: Automation & Hardening (Final 30 Hours)

**Goal**: Mature the platform by implementing CI/CD automation, a zero-trust security model, and persistent storage, making it truly production-ready.

* **Task 3.1: Implement CI with GitHub Actions**
    * **Estimate**: 8 Hours
    * **Description**: Create a `ci-pipeline.yml` workflow to automate the testing (`mvn clean install`) and containerization (`docker build`) process for all microservices, triggered on every push to the main branch.
* **Task 3.2: Implement Pull-Based GitOps with Argo CD**
    * **Estimate**: 10 Hours
    * **Description**: Deploy Argo CD into the cluster to manage the platform's state declaratively. Argo CD will monitor the `infra/manifests` path in the Git repository and automatically apply any changes, creating a secure, pull-based GitOps workflow.
* **Task 3.3: Establish Zero-Trust Network with a Service Mesh**
    * **Estimate**: 8 Hours
    * **Description**: Enable the Consul Connect service mesh to provide automatic mutual TLS (mTLS) encryption for all internal service-to-service communication. This will implement a "zero-trust" network where no service can communicate with another unless explicitly permitted via a Consul `ServiceIntention`.
* **Task 3.4: Deploy State Stores & Basic Persistence**
    * **Estimate**: 4 Hours
    * **Description**: Deploy a PostgreSQL instance using a Helm chart and update the fraud-detection service to connect to it. When a high-value transaction is detected, it will be saved to a `detected_fraud` table in the database for durable storage.