# Use a Maven image with OpenJDK 17
FROM maven:3.8.4-openjdk-17-slim AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and the source code
COPY pom.xml .
COPY src ./src

# Build the application (this will create the target/ directory with the JAR)
RUN mvn clean package

# Create the final image for running the application
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the builder image
COPY --from=builder /app/target/*.jar /app/your-app.jar

# Set the entrypoint for the application
ENTRYPOINT ["java", "-jar", "/app/your-app.jar"]

# Expose port 8080 (if your application runs on this port)
EXPOSE 8080
