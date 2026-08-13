FROM nginx:1.31.3-alpine3.24-slim

# Install openssl to generate keys and libcap2-bin for setcap
RUN apt-get -y update; apt-get install -y sudo; apt-get install -y openssl libcap2-bin

# Copy our custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy and set permissions for the certs generator script
COPY certs.sh /certs.sh
RUN chmod +x /certs.sh

# Copy the openssl configuration file
COPY openssl.cnf /openssl.cnf

# Generate self-signed certificates (as root during build)
RUN ["/bin/bash", "-c","/certs.sh"]

# Set ownership of certificate directories to nginx user (uid 101)
RUN chown -R nginx:nginx /etc/openssl/live

# Set ownership of nginx runtime directories to nginx user
RUN chown -R nginx:nginx /var/cache/nginx /var/log/nginx /etc/nginx/conf.d \
    && mkdir -p /var/run/nginx \
    && chown -R nginx:nginx /var/run/nginx

# Grant CAP_NET_BIND_SERVICE to nginx binary to allow binding to ports 80 and 443 as non-root
RUN setcap 'cap_net_bind_service=+ep' /usr/sbin/nginx

# Switch to non-root user
USER nginx