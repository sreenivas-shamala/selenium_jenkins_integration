
FROM maven:3.9-eclipse-temurin-17

RUN apt-get update && apt-get install -y --no-install-recommends \
    chromium chromium-driver \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn -B dependency:go-offline

CMD ["mvn", "-B", "clean", "test"]
