
#!/bin/bash
#chmod -R 777 /var/www/html/WordPress
sudo chown -R www-data:www-data /var/www/html/WordPress
sudo tee "/etc/nginx/sites-available/default" > /dev/null <<'EOF'
server {
    listen 80;
    server_name _;
    root /var/www/html/WordPress;

    index index.php index.html index.htm;

    location / {
        try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.3-fpm.sock; #check php version
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF