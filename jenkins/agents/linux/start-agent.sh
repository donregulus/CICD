#!/bin/bash
curl -sO http://172.17.0.1:8080/jnlpJars/agent.jar
java -jar agent.jar -url http://172.17.0.1:8080/ -secret 8c042ce39d6b84d59ad3853af687f9876714acdeb9226a238a0de33b307d8f42 -name "Docker-Agent-Linux" -webSocket -workDir "/home/jenkins/agent"
exit 0