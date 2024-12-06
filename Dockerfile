FROM gradle:jdk17 as builder
WORKDIR /app
COPY . /app/.
RUN gradle clean bootJar -x test

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar /app/*.jar
EXPOSE 80
ENTRYPOINT ["java", "-jar", "/app/*.jar"]
