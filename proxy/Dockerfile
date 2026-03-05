FROM nginx:trixie-perl

# Install openssl to generate keys
RUN apt-get -y update; apt-get install -y sudo; apt-get install -y openssl

# Copy our custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy and set permissions for the certs generator script
COPY certs.sh /certs.sh
RUN chmod +x /certs.sh

# Copy the openssl configuration file
COPY openssl.cnf /openssl.cnf

# Generate self-signed certificates
RUN /certs.sh