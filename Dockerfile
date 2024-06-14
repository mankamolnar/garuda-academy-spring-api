# cat Dockerfile
FROM mysql:latest

RUN chown -R mysql:root /var/lib/mysql/

#ARG MYSQL_DATABASE
#ARG MYSQL_USER
#ARG MYSQL_PASSWORD
#ARG MYSQL_ROOT_PASSWORD

ENV MYSQL_DATABASE=$MYSQL_DATABASE
ENV MYSQL_USER=$MYSQL_USER
ENV MYSQL_PASSWORD=$MYSQL_PASSWORD
ENV MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD

EXPOSE 3306

# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the Gradle wrapper script and the build.gradle file
COPY gradlew build.gradle settings.gradle /app/
COPY gradle /app/gradle

# give gradlew permission to run!
RUN chmod +x gradlew

# Download the dependencies before copying the entire project to take advantage of Docker's caching
RUN ./gradlew dependencies

# Copy the rest of the application code
COPY . /app

# give gradlew permission to run!
RUN chmod +x gradlew

# Build the application
RUN ./gradlew build

# Expose the port the app runs on
EXPOSE 8080

# Set the entry point to run the application
CMD ["java", "-jar", "build/libs/api-0.0.1-SNAPSHOT.jar"]