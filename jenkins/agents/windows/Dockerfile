# Use a base image with the necessary tools
FROM ubuntu:24.04

USER root
ENV HOME /home/jenkins/agent

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    mingw-w64 \
    git \
    curl \
    openjdk-17-jdk \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set up the mingw-w64 environment
ENV CC=x86_64-w64-mingw32-gcc \
    CXX=x86_64-w64-mingw32-g++ \
    AR=x86_64-w64-mingw32-ar \
    RANLIB=x86_64-w64-mingw32-ranlib

COPY start-agent.sh /start-agent.sh
RUN chmod +x /start-agent.sh
ENTRYPOINT ["/start-agent.sh"]
# # Default command
# CMD ["bash"]