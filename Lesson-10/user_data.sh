#!/bin/bash
yum update -y
yum install httpd.x86_64 -y
systemctl start httpd.service
systemctl enable httpd.service
echo "Hello World from $(hostname -f)" > /var/www/html/index.html