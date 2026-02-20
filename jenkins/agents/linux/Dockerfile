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
    clang-18 \
    llvm-18 \
    llvm-18-dev \
    llvm-18-runtime \
    libclang-rt-18-dev \
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

# Install RATS checker
RUN wget https://github.com/andrew-d/rough-auditing-tool-for-security/archive/refs/heads/master.zip
RUN unzip master.zip
WORKDIR  rough-auditing-tool-for-security-master
RUN ./configure
RUN make
RUN make install

# Install python tools
RUN rm /usr/lib/python*/EXTERNALLY-MANAGED && \  
    pip3 install gcovr conan  pycobertura

# Start Agent
COPY start-agent.sh /start-agent.sh
RUN chmod +x /start-agent.sh
ENTRYPOINT ["/start-agent.sh"]