# Project Phoenix Architecture

**Version:** 1.2  
**Date:** 2025-08-13

This document outlines the architecture for Project Phoenix, a backend-only, cloud-native microservices platform designed for real-time financial transaction simulation and fraud detection. It consolidates architectural principles, system components, technology choices, and key decisions (ADRs) made for the project.

---

## 1. Core Architectural Principles

- **Scalability:** Horizontal scaling of services to handle high-volume, low-latency financial transactions.
- **Maintainability:** Modular microservices with clear separation of concerns, backed by ADR documentation.
- **Resilience:** Service isolation with fault-tolerant patterns; failures in one service do not cascade.
- **Security:** Zero-trust principles, secure service-to-service communication, and adherence to best practices for authentication and authorization.
- **Observability:** Prometheus metrics and Tempo traces provide distributed observability; centralized logging (Loki) deferred to future iterations.
- **Cost-Effectiveness:** Leveraging open-source and managed solutions for reliability without excessive operational overhead.

---

## 2. System Architecture

Project Phoenix follows an **event-driven microservices architecture** deployed on Kubernetes (Kind for local development). Core services communicate via **Apache Kafka**, and the platform is exposed through a dedicated **Ingress Controller** for API access.

### 2.1 Request & Event Flow

1. API requests are sent to the platform (e.g., via Postman or automated integration tests).
2. Requests are routed via **ingress-nginx** to the appropriate backend service.
3. **Transaction Simulator Service** reads transaction datasets and publishes financial transactions to the Kafka `transactions` topic.
4. **Fraud Detection Service** consumes Kafka events for real-time fraud analysis.
5. Processed results are persisted in **PostgreSQL** or optionally cached in **Redis**.
6. Asynchronous tasks or cross-service notifications use Kafka topics.
7. **Observability**:
    - Metrics: Prometheus
    - Traces: Tempo
    - Logs: `kubectl logs` for now (centralized Loki deferred per ADR-003)

### 2.2 Component Responsibilities

| Component | Responsibility |
|-----------|----------------|
| **Transaction Simulator Service** | Reads transaction dataset, publishes Kafka messages simulating real-time payment streams. |
| **Fraud Detection Service** | Consumes Kafka stream, analyzes transactions, raises alerts for suspicious activity. |
| **PostgreSQL** | Primary datastore for transaction records, fraud reports, and analytics. |
| **Redis** | Optional caching for high-frequency access or ephemeral state. |
| **Kafka** | Core event streaming backbone for all transaction events. |
| **Ingress-nginx** | API gateway and HTTP routing to backend microservices. |
| **Prometheus** | Metrics collection and alerting. |
| **Tempo** | Distributed tracing across microservices. |
| **Loki** | Centralized logging deferred (ADR-003). |

---

## 3. Technology Stack

| Component | Technology | Rationale |
|-----------|-----------|-----------|
| Backend | Spring Boot / Java | JVM microservices offer high performance, type safety, and scalability. |
| Database | PostgreSQL | Reliable, ACID-compliant, supports complex queries for fraud analytics. |
| Cache | Redis | Optional in-memory caching for speed-critical operations. |
| Event Streaming | Apache Kafka | High-throughput, replayable, durable event log for transactions. |
| Ingress Controller | ingress-nginx | Stable, widely used Kubernetes ingress; resolves CRD conflicts with Consul (ADR-002). |
| Observability (Metrics) | Prometheus | Standard for cloud-native metrics collection. |
| Observability (Tracing) | Tempo | Low-overhead distributed tracing for microservice interactions. |
| Observability (Logging) | Loki (deferred) | Centralized logging deferred to unblock development (ADR-003). |
| CI/CD | GitHub Actions + Argo CD | Automated build, test, and GitOps-based deployment. |

---

## 4. Architectural Decisions 
\
All significant architectural decisions are documented in detail in the ADR log: [docs/ADRs/README.md](./docs/ADRs/README.md).

---
## 5. Deployment & DevOps

- **Containerization:** All microservices are containerized via Docker for environment consistency.
- **Kubernetes:** Services deployed on Kind (development) and scalable Kubernetes clusters (production).
- **Service Mesh:** Consul planned for zero-trust service-to-service communication (future milestone).
- **CI/CD:** GitHub Actions for build/test pipelines; Argo CD for declarative GitOps deployments.
- **Monitoring:** Prometheus + Tempo for metrics/tracing; logs via `kubectl logs` initially.

---

## 6. Future Enhancements

- **Centralized Logging:** Full Loki integration across services.
- **Advanced Fraud Analytics:** Incorporate machine learning models for anomaly detection.
- **Global Scaling:** Multi-cluster Kafka and database replication for high availability.
- **Service Mesh Security:** Full Consul integration for secure communication and observability.

---

**End of Document**
