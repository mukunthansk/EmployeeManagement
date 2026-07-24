FROM eclipse-temurin:24-jdk

WORKDIR /app

COPY target/employee-management-1.0.jar app.jar

EXPOSE 8085

ENTRYPOINT ["java","-jar","app.jar"]
