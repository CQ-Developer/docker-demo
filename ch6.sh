# 启动数据库并通过-m或--memory选项限制容器的内存为256m
docker run -d --name ch6_mariadb --memory 256m --cpu-shares 1024 --cap-drop net_raw -e MYSQL_ROOT_PASSWORD=test mariadb:5.5
