
FROM maven:3.9-eclipse-temurin-17

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        chromium \
        chromium-driver \
        ca-certificates \
        fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY pom.xml .
RUN mvn -B dependency:go-offline

COPY src ./src

# Verify that both browser executables exist
RUN chromium --version && chromedriver --version

CMD ["mvn", "-B", "clean", "test"]
