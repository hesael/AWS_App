#!/bin/bash
apt-get update
apt-get install -y nginx
service nginx start
#Create a working folder
sudo mkdir /tmp/test_build
sudo cd /tmp/test_build
#Download AWS CLI
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/test_build/awscliv2.zip"
sudo unzip /tmp/test_build/awscliv2.zip
sudo /aws/install
sudo rm -rf /aws
#Download and install the SSM Agent
sudo dnf install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
# Update Nginx configuration file
sudo sed -i 's/#server_names_hash_bucket_size 64/server_names_hash_bucket_size 128/' /etc/nginx/nginx.conf
sudo systemctl daemon-reload
sudo systemctl restart nginx