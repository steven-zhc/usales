FROM openjdk:8-alpine
MAINTAINER hczhang

RUN mkdir /app
COPY usales-0.1.war /app

EXPOSE 8080
WORKDIR /app
ENTRYPOINT ["java"]
CMD ["-jar", "usales-0.1.war"]


