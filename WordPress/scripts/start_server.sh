
#!/bin/bash
systemctl restart mysql.service
systemctl restart nginx.service
systemctl restart php8.3-fpm.service
