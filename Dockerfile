# Stage 1: Build WAR using Maven
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Deploy to Tomcat
FROM tomcat:9.0-jdk17-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]


# FROM tomcat:9.0-jdk17-temurin

# # Optional: Remove default ROOT app so your app becomes the main one
# RUN rm -rf /usr/local/tomcat/webapps/*

# # Copy WAR from target folder into Tomcat
# COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# EXPOSE 8080

# CMD ["catalina.sh", "run"]
