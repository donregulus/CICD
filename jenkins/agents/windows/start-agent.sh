#!/bin/bash
curl -sO http://172.17.0.1:8080/jnlpJars/agent.jar
java -jar agent.jar -url http://172.17.0.1:8080/ -secret 6eb092631e70cddee8b9906627cc6a4b8af3a7ef5d181aca79e93198e10ad240 -name "Docker-Agent-Windows" -webSocket -workDir "/home/jenkins/agent"
exit 0