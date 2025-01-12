FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /app
COPY . .
RUN ./gradlew clean build --exclude-task test

FROM eclipse-temurin:17-jre-alpine

RUN addgroup -g 1000 kyosk \
        && adduser -u 1000 -G kyosk -s /bin/sh -D kyosk

USER 1000:1000
WORKDIR /app
COPY --chown=1000:1000 --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]