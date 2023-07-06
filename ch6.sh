# 启动 mariadb 并通过 -m,--memory 选项限制容器的最大可用内存为 256m
docker run -d --name ch6_mariadb --memory 256m --cpu-shares 1024 --cap-drop net_raw -e MYSQL_ROOT_PASSWORD=test mariadb:5.5

# 启动 wordpress 并限制 CPU 的相对权重为 512
docker run -d -P --name ch6_wordpress -m 512m --cpu-shares 512 --cap-drop net_raw --link ch6_mariadb:mysql -e WORDPRESS_DB_PASSWORD=test wordpress:5.0.0-php7.2-apache

# 启动 wordpress 并限制 CPU 的配额为 0.75
# 也就是说容器最多使用 0.75 个 CPU
docker run -d -P --name ch6_wordpress -m 512m --cpus 0.75 --cap-drop net_raw --link ch6_mariadb:mysql -e WORDPRESS_DB_PASSWORD=test wordpress:5.0.0-php7.2-apache

# 将容器限定在CPU集合0上运行
docker run -d --cpuset-cpus 0 --name ch6_stresser --rm dockerinaction/ch6_stresser
docker run -it --rm dockerinaction/ch6_htop
