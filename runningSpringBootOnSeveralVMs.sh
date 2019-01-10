#!/bin/bash
PROJECT="spring-boot-hello-world"
INSTALL_FOLDER="${JENKINS_HOME}/${PROJECT}"

mvn clean package

ssh jenkins@10.0.0.7 "mkdir -p ~/${PROJECT};"

scp target/hello-world.jar jenkins@10.0.0.7:~/${PROJECT}

ssh jenkins@10.0.0.7 << -EOF-
    PROJECT="spring-boot-hello-world"
      INSTALL_FOLDER="/home/jenkins/spring-boot-hello-world"
      PID_FILE="/home/jenkins/spring-boot-hello-world/PID"
    OLD_PID=$(cat ${PID_FILE})
    kill -9 ${OLD_PID}
    cp /home/jenkins/spring-boot-hello-world/hello-world.jar /home/jenkins/runnable
    rm -rf /home/jenkins/spring-boot-hello-world/*
    chmod +x /home/jenkins/runnable/hello-world.jar
    java -jar /home/jenkins/runnable/hello-world.jar 2>&1 &
    echo $! > ${PID_FILE}
    disown
-EOF-