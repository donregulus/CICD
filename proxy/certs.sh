#!/bin/bash

# List of certificates to generate (path, url, serviceName)
declare -a certs=(
    "/etc/openssl/live/jenkins.cicd.stroalgo.com jenkins.cicd.stroalgo.com jenkins"
    "/etc/openssl/live/nexus.cicd.stroalgo.com nexus.cicd.stroalgo.com nexus"
    "/etc/openssl/live/sonar.cicd.stroalgo.com sonar.cicd.stroalgo.com sonar"
)

# Generate a private key for your CA
# Become My Own Certificate Authority (CA)
openssl genrsa -out stroalgoCA.key 4096

# Generate the root CA certificate (valid for 10 years for convenience)
openssl req -x509 -new -nodes -key stroalgoCA.key -sha256 -days 3650 -out stroalgoCA.crt \
  -subj "/CN=Stroalgo CA"

for cert in "${certs[@]}"
do
    read -r  cert_path cert_domain service_name<<< "$cert"
    
    if [ ! -f "$cert_path/fullchain.pem" ]; then
        echo "Creating self-signed certificates for $cert_domain"   
        
        # Create directory if it doesn't exist
        echo "Creating directory $cert_path for $cert_domain"
        mkdir -p "$cert_path"

        # Generate a private key for the domain
        openssl genrsa -out "$cert_path/privkey.pem" 2048

        # Create a Certificate Signing Request (CSR)
        openssl req -new -key "$cert_path/privkey.pem" -out "$cert_path/csr.pem" \
           -config openssl.cnf -subj "/CN=$cert_domain"

        # Use your CA to sign the certificate and create the final .crt file
        openssl x509 -req -in "$cert_path/csr.pem" \
            -CA stroalgoCA.crt -CAkey stroalgoCA.key -CAcreateserial \
            -out "$cert_path/fullchain.pem" -days 825 \
            -subj "/CN=$cert_domain" \
            -extfile <(cat openssl.cnf; printf "\nDNS.1=$cert_domain\nDNS.2=$service_name") \
            -extensions req_ext
    fi
done