#! /bin/bash
mvn clean package
docker build -t spring-boot-hello-world:latest .
if $(docker ps -qa) | grep spring-boot-hello-world 
then 
docker stop $(docker ps -qa)
docker rm $(docker ps -qa)
fi

docker rmi $(docker images -q -f dangling=true)
docker run -d -p 9000:9000 spring-boot-hello-world
