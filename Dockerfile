# Dockerfile
FROM openjdk:17-jdk-slim
VOLUME /tmp
COPY target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]

FROM jenkins/jenkins:lts

USER root

# Install docker CLI inside the container
RUN apt-get update && apt-get install -y docker.io


USER jenkins