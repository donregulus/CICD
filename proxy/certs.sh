#!/bin/sh

# Path where Nginx expects the certs
CERT_DIR="/etc/letsencrypt/live/cicd.stroalgo.com"
mkdir -p $CERT_DIR

if [ ! -f "$CERT_DIR/fullchain.pem" ]; then
  echo "Creating self-signed certificates for local development..."

  # Generate a private key for your CA
  # Become My Own Certificate Authority (CA)
  openssl genrsa -out myCA.key 4096

  # Generate the root CA certificate (valid for 10 years for convenience)
  openssl req -x509 -new -nodes -key myCA.key -sha256 -days 3650 -out stroalgoCA.crt \
    -subj "/CN=Stroalgo CA"


  # Generate a private key for your Jenkins server
  openssl genrsa -out "$CERT_DIR/privkey.pem" 2048

  # Create a Certificate Signing Request (CSR)
  openssl req -new -key "$CERT_DIR/privkey.pem" -out "$CERT_DIR/csr.pem" \
    -config openssl.cnf

  # Use your CA to sign the certificate and create the final .crt file
  openssl x509 -req -in "$CERT_DIR/csr.pem" \
    -CA stroalgoCA.crt -CAkey myCA.key -CAcreateserial \
    -out "$CERT_DIR/fullchain.pem" -days 825 -sha256 \
  -extfile openssl.cnf   -extensions req_ext
fi