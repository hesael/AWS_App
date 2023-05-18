#!/bin/bash

# Install and configure SSH server
apt-get update
apt-get install -y openssh-server

# Generate SSH keys for the desired user (replace "username" with your desired username)
mkdir -p /home/username/.ssh
chmod 700 /home/username/.ssh
ssh-keygen -t rsa -N "" -f /home/username/.ssh/id_rsa
chown -R username:username /home/username/.ssh

# Configure SSH server
sed -i 's/^PasswordAuthentication yes$/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^AllowTcpForwarding yes$/AllowTcpForwarding yes\nPubkeyAuthentication yes/' /etc/ssh/sshd_config

# Restart SSH service
service ssh restart
