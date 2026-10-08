FROM selenium/standalone-chrome:latest

USER root

RUN apt-get update && apt-get install -y maven && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src ./src

CMD ["mvn", "clean", "test"]
