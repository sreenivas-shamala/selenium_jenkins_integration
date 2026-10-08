FROM selenium/standalone-chrome:latest

USER root


WORKDIR /app

COPY pom.xml .



COPY src ./src

CMD ["mvn", "clean", "test"]
