
# -------- BUILD STAGE --------
FROM maven:3.9.9-eclipse-temurin-25 AS build

WORKDIR /app

COPY pom.xml .

RUN mvn -B -q -e -DskipTests dependency:resolve

COPY src ./src

RUN mvn -B clean package -DskipTests


# -------- RUNTIME STAGE --------
FROM eclipse-temurin:25-jre

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

EXPOSE 8081

ENTRYPOINT ["java", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]
