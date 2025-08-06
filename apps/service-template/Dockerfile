# Stage 1: The Build Stage (with Maven and JDK 17)
FROM maven:3.9-eclipse-temurin-17 AS builder

# Set the working directory for the build
WORKDIR /app

# Copy the entire project context (all poms, libs, apps) into the container.
COPY . .

# --- Step 1: Build and install the shared library ---
# We must run 'install' so it becomes available in the local .m2 repo for the next step.
# We activate the 'docker-build' profile to disable the toolchains plugin.
RUN mvn -f libs/phoenix-shared/pom.xml clean install -Pdocker-build -DskipTests


# --- Step 2: Build the main application service ---
# Now that the 'phoenix-shared' dependency is in the local repo, we can package our service.
# We also use the 'docker-build' profile here.
RUN mvn -f apps/service-template/pom.xml clean package -Pdocker-build -DskipTests


# Stage 2: The Final Runtime Image
# Using a lightweight Java Runtime Environment for a smaller and more secure image.
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Copy only the final application JAR from the builder stage's target directory.
COPY --from=builder /app/apps/service-template/target/*.jar app.jar

# Expose the port your Spring Boot application runs on
EXPOSE 8080

# Define the command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]