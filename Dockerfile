FROM maven:3.8.2-jdk-8-slim AS build
WORKDIR /home/app
COPY . /home/app
RUN mvn -f pom.xml clean package

FROM openjdk:8-jdk-alpine
VOLUME /tmp
EXPOSE 8000
COPY --from=build /*.jar app.jar
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]
