# ─────────────────────────────────────────────
# STAGE 1: Build
# ─────────────────────────────────────────────
FROM eclipse-temurin:21-jdk-alpine AS builder

WORKDIR /app

COPY .mvn/ .mvn/
COPY mvnw pom.xml ./

# Dar permisos de ejecución al wrapper
RUN chmod +x mvnw

RUN ./mvnw dependency:go-offline -B

COPY src/ src/
RUN ./mvnw package -DskipTests -B

# ─────────────────────────────────────────────
# STAGE 2: Runtime
# ─────────────────────────────────────────────
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

RUN addgroup -S farmacia && adduser -S farmacia -G farmacia
RUN mkdir -p /app/logs && chown farmacia:farmacia /app/logs

COPY --from=builder /app/target/*.jar app.jar

USER farmacia

EXPOSE 8080

ENTRYPOINT ["java", \
  "-Djava.security.egd=file:/dev/./urandom", \
  "-jar", "app.jar"]