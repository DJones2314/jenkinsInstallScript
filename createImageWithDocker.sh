#! /bin/bash
mvn clean package
docker build -t spring-boot-hello-world:latest .
docker stop $(docker ps -qa)
docker rm $(docker ps -qa)
docker rmi $(docker images -q -f dangling=true)
docker run -d -p 9000:9000 spring-boot-hello-world
