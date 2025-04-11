FROM ubuntu:24.04
LABEL Description="Build environment"

USER root
ENV HOME /home/jenkins


SHELL ["/bin/bash", "-c"]

# Install tools
RUN apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    build-essential \
    clang \ 
    cmake \
    gdb \
    git\  
    wget \ 
    graphviz \
    doxygen \
    unzip \
    cppcheck \
    clang-tools \
    libexpat1 \
    libexpat1-dev \  
    python3 \
    python3-pip \    
    clang-tidy \
    curl \
    openjdk-17-jdk \
    vim \    
    valgrind && \  
    rm -rf /var/lib/apt/lists/*  &&\
    apt-get clean 

# Install sonar scanner
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-6.1.0.4477-linux-x64.zip 
RUN unzip sonar-scanner-cli-6.1.0.4477-linux-x64.zip 
RUN mv sonar-scanner-6.1.0.4477-linux-x64 /opt/sonar-scanner

# Install RATS checker
RUN wget https://github.com/andrew-d/rough-auditing-tool-for-security/archive/refs/heads/master.zip
RUN unzip master.zip
WORKDIR  rough-auditing-tool-for-security-master
RUN ./configure
RUN make
RUN make install

# Install python tools
RUN rm /usr/lib/python*/EXTERNALLY-MANAGED && \  
    pip3 install gcovr conan

# Start Agent
COPY start-agent.sh /start-agent.sh
RUN chmod +x /start-agent.sh
ENTRYPOINT ["/start-agent.sh"]