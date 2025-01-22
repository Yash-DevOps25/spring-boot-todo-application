# Use the Maven 3.9.0 with OpenJDK 17 image as base
FROM apache maven:3.8.7-openjdk-17 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and the source code
COPY pom.xml /app/
COPY src /app/src

# Build the application (this will create the target/ directory with the JAR)
RUN mvn clean package

# List the files in the target directory to verify the JAR file's existence
RUN ls -alh /app/target/

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
