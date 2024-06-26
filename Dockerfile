FROM openjdk:11-jdk-slim

ARG SPRING_DATASOURCE_URL
ARG SPRING_DATASOURCE_PASSWORD
ARG SPRING_DATASOURCE_USERNAME

ENV SPRING_DATASOURCE_PASSWORD=$SPRING_DATASOURCE_PASSWORD
ENV SPRING_DATASOURCE_URL=$SPRING_DATASOURCE_URL
ENV SPRING_DATASOURCE_USERNAME=$SPRING_DATASOURCE_USERNAME

COPY . .
RUN chmod +x gradlew
RUN ./gradlew clean build

EXPOSE 8080
ENTRYPOINT java -jar "build/libs/api-0.0.1-SNAPSHOT.jar"
