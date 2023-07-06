# 启动 mariadb 并通过 -m,--memory 选项限制容器的最大可用内存为 256m
docker run -d --name ch6_mariadb --memory 256m --cpu-shares 1024 --cap-drop net_raw -e MYSQL_ROOT_PASSWORD=test mariadb:5.5

# 启动 wordpress 并限制进程的相对权重为 512
docker run -d -P --name ch6_wordpress -m 512m --cpu-shares 512 --cap-drop net_raw --link ch6_mariadb:mysql -e WORDPRESS_DB_PASSWORD=test wordpress:5.0.0-php7.2-apache
