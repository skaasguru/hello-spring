FROM maven:3.9-amazoncorretto-17 AS build
COPY pom.xml /app/
RUN mvn -f /app/pom.xml dependency:resolve
COPY src /app/src
RUN mvn -f /app/pom.xml package

FROM amazoncorretto:17-alpine
COPY --from=build /app/target/hello-spring-0.1.0.jar /app/hello-spring-0.1.0.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/hello-spring-0.1.0.jar"]
