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

# 将主机设备/dev/sda暴露到容器的/dev/xvdc位置
docker run --device /dev/sda:/dev/xvdc --rm -it ubuntu ls -Al /dev

# 启动生产者并指定IPC命名空间
docker run -d -u nobody --name ch6_ipc_producer --ipc shareable dockerinaction/ch6_ipc -producer
docker run -d -u nobody --name ch6_ipc_consumer dockerinaction/ch6_ipc -consumer
# 观察生产者和消费者的日志
docker logs ch6_ipc_producer
docker logs ch6_ipc_consumer
# 删除消费者
docker rm -fv ch6_ipc_consumer
# 创建新的消费者并重用生产者的IPC命名空间
docker run -d --name ch6_ipc_consumer --ipc container:ch6_ipc_producer dockerinaction/ch6_ipc -consumer
docker logs ch6_ipc_producer
docker logs ch6_ipc_consumer
# 清理
docker rm -fv ch6_ipc_consumer ch6_ipc_producer

# 查看镜像定义的运行时用户
docker pull busybox:1.29
docker image inspect busybox:1.29
docker image inspect -f "{{.Config.User}}" busybox:1.29
# 确定镜像的默认用户
docker run  --rm --entrypoint "" busybox:1.29 whoami
docker run  --rm --entrypoint "" busybox:1.29 id
# 获取镜像中可用的用户列表
docker run --rm busybox:1.29 awk -F: '{ print $1 }' /etc/passwd
