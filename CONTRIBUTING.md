# Contributing Guidelines

This document provides the guidelines for contributing to Project Phoenix to ensure a consistent and high-quality development process.

## Development Workflow

1.  **Create a Branch**: All work must be done on a feature or bugfix branch, not directly on `main`. Create a branch from the `main` branch using a descriptive name.
    * *Example*: `feat/add-user-profile-service` or `fix/auth-service-validation-bug`.

2.  **Write Code**: Make all changes to the codebase within your branch.
    * Adhere to the coding standards outlined below.
    * Ensure any new code is covered by appropriate unit or integration tests.

3.  **Run Tests**: Before submitting changes, ensure all tests pass by running the following command from the root of the specific microservice being modified:
    ```bash
    mvn clean install
    ```

4.  **Format Commit Messages**: All commit messages must follow the Conventional Commits specification.
    ```
    <type>: <subject>

    [optional body]
    ```
    * **Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`.
    * **Example**:
        ```
        feat: Add health check endpoint to auth-service

        This commit introduces a /api/v1/health endpoint to the
        authentication service to allow for external monitoring.
        ```

5.  **Submit a Pull Request (PR)**: Push your branch and open a pull request against the `main` branch.
    * Provide a clear title and a brief description of the changes.
    * If the PR addresses an existing issue, link to it in the description.

## Coding Standards

* **Java**: Adhere to the [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html).
* **APIs**: All RESTful APIs must be clearly defined and follow standard conventions for HTTP verbs and status codes.
* **Logging**: All services must use structured JSON logging for effective parsing and analysis in Loki.