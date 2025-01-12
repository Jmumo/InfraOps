## Use a more specific OpenJDK image with minimal setup
#FROM openjdk:17-jdk-slim
#
## Set working directory
#WORKDIR /app
#
## Copy build artifacts
#COPY build/libs/*.jar app.jar
#
## Expose the port
#EXPOSE 8080
#
## Command to run the application
#ENTRYPOINT ["java", "-jar", "app.jar"]


# Gradle build stage








# Gradle build stage
#FROM gradle:7.6-jdk17-alpine AS build




FROM openjdk:17-jdk-slim

# Set working directory and copy the source code
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src

# Install Gradle if not available
RUN apk add --no-cache gradle

# Run the Gradle build
RUN gradle build --no-daemon

# Final stage
FROM openjdk:17-jdk-slim

# Expose port
EXPOSE 8080

# Create the application directory
RUN mkdir /app

# Copy the built JAR from the Gradle build stage
COPY build/libs/*.jar app.jar

# Entry point to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]




