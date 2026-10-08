FROM selenium/standalone-chrome:latest

USER root


WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src ./src

CMD ["mvn", "clean", "test"]
