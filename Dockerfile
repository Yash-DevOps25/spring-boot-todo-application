# Use a Maven image with JDK 17
FROM maven:3.8.7-openjdk-17 AS builder

# Set working directory
WORKDIR /app

# Copy only the pom.xml and resolve dependencies (this allows caching)
COPY pom.xml .
RUN mvn dependency:resolve

# Now copy the source code and build the project
COPY src ./src
RUN mvn clean package -DskipTests

# Use a lightweight Java image to run the application
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
