# Phoenix Service Template Guide

## 1. Overview

This directory contains the Spring Boot template for all new microservices within the Project Phoenix ecosystem. It is pre-configured with all the necessary dependencies and boilerplate to ensure that new services are production-ready, observable, and integrate seamlessly with the platform's infrastructure from day one.

---

## 2. Core Features

This template provides the following features out-of-the-box, based on its `pom.xml`:

* **RESTful API Ready**: Includes `spring-boot-starter-web` to expose REST endpoints.
* **Service Discovery**: Uses `spring-cloud-starter-consul-discovery` to automatically register with the platform's HashiCorp Consul instance, making it immediately discoverable by other services.
* **Event-Driven Integration**: Comes with `spring-kafka` for easy production and consumption of messages from the Apache Kafka cluster.
* **Shared Library**: Includes the `phoenix-shared` library to provide access to common DTOs and utility classes.

---

## 3. Full Observability Stack

The template is fully instrumented to integrate with the project's observability platform.

* **Metrics**: Exposes a Prometheus-compatible endpoint at `/actuator/prometheus` via Micrometer. No extra configuration is needed for Prometheus to begin scraping metrics.
* **Distributed Tracing**: Includes `zipkin-reporter-brave`, allowing the service's request traces to be captured and visualized in Tempo.
* **Structured Logging**: Comes with `loki-logback-appender`. **Note**: Although the central Loki instance is deferred (see ADR-003), this logger ensures all log output is in a structured JSON format, making the service ready for log aggregation without future code changes.

---

## 4. Developer Experience

The template is designed for an efficient development workflow:

* **Lombok**: Pre-configured to reduce boilerplate code for data objects.
* **DevTools**: `spring-boot-devtools` is enabled for hot-reloading during local development.
* **Consistent JDK**: The `maven-toolchains-plugin` is configured to enforce the use of **Java 17**, ensuring consistency across all developer environments and CI/CD.

---

## 5. How to Use

* **To Build**: From this directory, run `mvn clean install`.
* **To Run Locally**: Use `mvn spring-boot:run`. The service will start and attempt to connect to the local infrastructure (Consul, Kafka).
* **To Create a New Service**: Copy this entire directory (`service-template`) to a new directory within the `apps/` folder (e.g., `apps/new-service`) and update the `pom.xml` with the new service's `artifactId` and `name`.