
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

# Find the actual executable names and verify versions
RUN command -v chromium || command -v chromium-browser || command -v google-chrome
RUN command -v chromedriver && chromedriver --version

CMD ["mvn", "-B", "clean", "test"]
