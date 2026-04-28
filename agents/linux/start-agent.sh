#!/bin/bash
# Connect to Jenkins via internal Docker network (not external DNS)
curl -sO http://jenkins:8080/jnlpJars/agent.jar && java -jar agent.jar -url http://jenkins:8080/ -secret 59ff96ff5a96fbb4943662aad15b5fd2298a7822b53884dfda3e0b22fa9989a0 -name "Docker-Agent-Linux" -webSocket -workDir "/home/jenkins_home"
exit 0