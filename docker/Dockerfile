FROM openjdk:8-jre-alpine
MAINTAINER hczhang

ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

RUN mkdir -p /app
COPY *.war /app/usales.jar

EXPOSE 8080
WORKDIR /app
ENTRYPOINT ["java"]
CMD ["-jar", "usales.jar"]
