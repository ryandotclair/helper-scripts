# Get a cert
sudo certbot certonly --manual -d '<domain.com>' -d '*.<domain.com>' --preferred-challenges dns-01 --email <email> --agree-tos --text --manual-public-ip-logging-ok --renew-by-default --rsa-key-size 4096 --key-type rsa

# Renew a cert
sudo certbot renew  --work-dir <path/to/certbot/wd> --config-dir <path/to/certbot/cfg> --logs-dir <path/to/certbot/logs>