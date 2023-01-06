  #!/bin/bash
      sudo yum install -y epel-release
      sudo yum install nginx -y
      sudo systemctl start nginx
      sudo firewall-cmd --permanent --zone=public --add-service=http
      sudo firewall-cmd --permanent --zone=public --add-service=https
      sudo firewall-cmd --reload
      sudo systemctl enable nginx
      sudo mkdir -p /var/www/yourdomain.com/public_html
      touch /var/www/yourdomain.com/public_html/index.html
      echo "Hello World" > /var/www/yourdomain.com/public_html/index.html
      sudo chmod 755 /var/www/yourdomain.com/public_html/index.html