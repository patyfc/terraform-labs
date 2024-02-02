#!/bin/bash
sudo apt update -y 
sudo apt install -y nginx
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` 
INSTANCE_ID=`curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/instance-id`

echo "Ola. Sou servidor, instance ID' $INSTANCE_ID 'e estou na AZ' ${AZ}'." > /var/www/html/index.html