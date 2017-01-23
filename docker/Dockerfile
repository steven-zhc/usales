FROM openjdk:8-alpine
MAINTAINER hczhang

RUN mkdir -p /app
COPY *.war /app/usales.jar

EXPOSE 8080
WORKDIR /app
ENTRYPOINT ["java"]
CMD ["-jar", "usales.jar"]
