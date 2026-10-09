
FROM maven:3.9-eclipse-temurin-17

USER root

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        ca-certificates \
        gnupg \
        fonts-liberation \
    && rm -rf /var/lib/apt/lists/*

# Add Google's official Chrome repository
RUN wget -q -O /tmp/google-chrome.pub \
        https://dl.google.com/linux/linux_signing_key.pub && \
    mkdir -p /etc/apt/keyrings && \
    gpg --dearmor \
        -o /etc/apt/keyrings/google-chrome.gpg \
        /tmp/google-chrome.pub && \
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main" \
        > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends google-chrome-stable && \
    rm -rf /var/lib/apt/lists/* /tmp/google-chrome.pub

# Install the matching ChromeDriver
RUN CHROME_VERSION=$(google-chrome --product-version) && \
    CHROME_MAJOR=$(echo "$CHROME_VERSION" | cut -d. -f1) && \
    DRIVER_VERSION=$(wget -qO- \
      "https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_${CHROME_MAJOR}") && \
    wget -q -O /tmp/chromedriver.zip \
      "https://storage.googleapis.com/chrome-for-testing-public/${DRIVER_VERSION}/linux64/chromedriver-linux64.zip" && \
    apt-get update && \
    apt-get install -y --no-install-recommends unzip && \
    unzip /tmp/chromedriver.zip -d /tmp/chromedriver && \
    install -m 0755 /tmp/chromedriver/chromedriver-linux64/chromedriver /usr/local/bin/chromedriver && \
    rm -rf /tmp/chromedriver /tmp/chromedriver.zip /var/lib/apt/lists/*

WORKDIR /app

COPY pom.xml .
RUN mvn -B dependency:go-offline

COPY src ./src

# Verify browser and driver
RUN google-chrome --version && chromedriver --version

CMD ["mvn", "-B", "clean", "test"]
