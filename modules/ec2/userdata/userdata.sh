#!/bin/bash
sudo apt update -y && sudo apt upgrade -y
sudo apt-get -y install python3 python3-pip python3-venv 
sudo apt-get -y --no-install-recommends install libgl1-mesa-glx
sudo apt-get -y install libzbar0
sudo apt-get -y install nginx
sudo apt-get -y install git 
sudo pip3 install gunicorn flask pillow opencv-python pyzbar

# Repo hosting the app
sudo git clone https://github.com/hesael/scan_app.git /home/ubuntu/Scan_App
sudo usermod -aG ubuntu www-data
sudo chown -R ubuntu:www-data /home/ubuntu/Scan_App
export FLASK_APP=/home/ubuntu/Scan_App/myapp.py

# Create a gunicorn systemd service file
sudo echo "[Unit]
Description=Gunicorn instance to serve Scan_App
After=network.target

[Service]
User=ubuntu
Group=www-data
WorkingDirectory=/home/ubuntu/Scan_App
Environment="PATH=/usr/lib/python3.10/venv/bin"
ExecStart=/usr/local/bin/gunicorn  --workers 3 --bind 127.0.0.1:5000 -m 007 myapp:app

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/Scan_App.service

sudo systemctl enable Scan_App
sudo systemctl start Scan_App

# Create a new server block configuration in Nginx’s sites-available directory

sudo echo "server {
    listen 80;
    server_name $(curl -s http://169.254.169.254/latest/meta-data/public-hostname);

    location / {
        include proxy_params;
        proxy_pass http://unix:/home/ubuntu/Scan_App/Scan_App.sock;
    }
}" | sudo tee /etc/nginx/sites-available/myapp 

sudo ln -s /etc/nginx/sites-available/myapp /etc/nginx/sites-enabled 
# Update Nginx configuration file
sudo sed -i 's/#server_names_hash_bucket_size 64/server_names_hash_bucket_size 128/' /etc/nginx/nginx.conf
sudo systemctl daemon-reload
sudo systemctl restart nginx
sudo systemctl restart Scan_App.service 
cd /home/ubuntu/Scan_App
flask run

