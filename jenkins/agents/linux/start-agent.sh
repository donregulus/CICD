#!/bin/bash
curl -sO http://172.17.0.1:8080/jnlpJars/agent.jar
java -jar agent.jar -url http://172.17.0.1:8080/ -secret 1f34693f9d1e9da4698863e4364155329f36bd0eb28a5a007aed7e0f81e6f1eb -name "Docker-Agent-Linux" -webSocket -workDir "/home/jenkins/agent"
exit 0