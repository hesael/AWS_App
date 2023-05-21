#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y nginx
sudo systemctl start nginx
#Create a working folder
sudo mkdir /tmp/ssm
sudo cd /tmp/ssm
#Download AWS CLI
sudo wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
sudo sudo dpkg -i amazon-ssm-agent.deb
sudo systemctl status amazon-ssm-agent
sudo status amazon-ssm-agent
sudo rm -rf /tmp/ssm
# Update Nginx configuration file
sudo sed -i 's/#server_names_hash_bucket_size 64/server_names_hash_bucket_size 128/' /etc/nginx/nginx.conf
sudo systemctl daemon-reload
sudo systemctl restart nginx
sudo systemctl enable amazon-ssm-agent


apt-get install -y openssh-server

# Configure SSH server
sudo sed -i 's/^PasswordAuthentication yes$/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^AllowTcpForwarding yes$/AllowTcpForwarding yes\nPubkeyAuthentication yes/' /etc/ssh/sshd_config

# Restart SSH service
sudo systemctl restart sshd.service 