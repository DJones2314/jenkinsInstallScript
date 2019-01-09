#!/bin/bash
PROJECT="spring-boot-hello-world"
mvn clean package
INSTALL_FOLDER="${JENKINS_HOME}/${PROJECT}"

#kill PID

PID_FILE="${INSTALL_FOLDER}/PID"
OLD_PID=$(cat ${PID_FILE})
kill -9 ${OLD_PID}

#make install folder

mkdir -p ${INSTALL_FOLDER}
rm -rf ${INSTALL_FOLDER}/*

#copy JAR to install folder

cp target/hello-world*.jar ${INSTALL_FOLDER}/${PROJECT}.jar

#run the Jar file in the background

BUILD_ID=dontKillMe java -jar ${INSTALL_FOLDER}/${PROJECT}.jar 2>&1 &
echo $! > ${PID_FILE}
disown