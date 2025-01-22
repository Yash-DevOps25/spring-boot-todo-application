# Use OpenJDK 17 as the base image
FROM openjdk:17-jdk-slim AS builder

# Install Maven
RUN apt-get update && apt-get install -y maven

# Set working directory
WORKDIR /app

# Copy your Maven project files
COPY . .

# Build the project using Maven
RUN mvn clean package

# Use a lighter base image for the final image
FROM openjdk:17-jdk-slim

# Copy the built jar file from the builder image
COPY --from=builder /app/target/your-app.jar /app/your-app.jar

# Set the entrypoint for the application
ENTRYPOINT ["java", "-jar", "/app/your-app.jar"]
