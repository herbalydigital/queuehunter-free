# Certificates

Place only the customer-approved trusted CA certificates needed for LDAPS or broker TLS in this folder. Do not copy test certificates from the QueueHunter development environment. Set the matching container path in `.env`, for example `LDAP_CA_CERT=/run/certs/ldap-ca.crt`.
