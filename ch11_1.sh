# 启用服务的抽象概念
docker swarm init
# 在本地主机的80端口上启动服务
docker service create --publish 8080:80 --name hello-world dockerinaction/ch11_service_hw:v1
# 访问服务
curl http://localhost:8080
# 停止正在运行的容器
docker rm -f container-name
# 列出正在运行的服务
docker service ls
# 列出与服务关联的容器的状态
docker service ps hello-world
# 查看服务的当前期望状态的定义
docker service inspect hello-world
