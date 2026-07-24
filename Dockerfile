# Use Java 24 runtime
FROM eclipse-temurin:24-jdk

# Set working directory
WORKDIR /app

# Copy the JAR file
COPY target/employee-management-1.1.jar app.jar

# Expose application port
EXPOSE 8085

# Run the Spring Boot application
ENTRYPOINT ["java","-jar","app.jar"]