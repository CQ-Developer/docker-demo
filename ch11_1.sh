# 启用服务的抽象概念
docker swarm init

# 在本地主机的80端口上启动服务
docker service create --publish 8080:80 --name hello-world dockerinaction/ch11_service_hw:v1

# 访问服务
curl http://localhost:8080

# 停止正在运行的容器
docker rm -f hello-world.1.xxxx

# 列出正在运行的服务
docker service ls

# 列出与服务关联的容器的状态
docker service ps hello-world

# 查看服务的当前期望状态的定义
docker service inspect hello-world

# 复制模式用于告诉swarm集群如何运行服务的副本
# 目前有两种模式：已复制模式(默认)和全局模式
# 通知swarm集群运行hello-world服务的3个副本
docker service scale hello-world=3

# 列出容器
docker ps
docker service ps hello-world

# 缩减服务规模会先删除编号较高的容器
docker service scale hello-world=2

# 更新hello-world服务
docker service update --image dockerinaction/ch11_service_hw:v2 --update-order stop-first --update-parallelism 1 --update-delay 30s hello-world

# 使用一个无法启动的容器
docker service update --image dockerinaction/ch11_service_hw:start-failure hello-world

# 手动回滚服务
docker service update --rollback hello-world

# 告诉集群部署失败自动回滚
# 告诉集群失败的条件：只要有1/3的服务处于运行状态即可
docker service update --update-failure-action rollback --update-max-failure-ratio 0.6 --image dockerinaction/ch11_service_hw:start-failure hello-world

# 使用不带健康检查的版本
docker service update --update-failure-action rollback --image dockerinaction/ch11_service_hw:no-health hello-world
# 查看运行状态
docker ps

# 从命令行向服务添加用于运行状况检查的元数据并更新服务
docker service update --health-cmd /bin/httpping --health-interval 10s hello-world
# 查看运行状态
docker ps

# 禁用运行状况检查
docker service update --no-healthcheck hello-world

# 删除服务
docker service rm hello-world
