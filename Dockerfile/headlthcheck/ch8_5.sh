# 构建镜像
docker build -t dockerinaction/healthcheck .

# 运行容器并检查健康状况
docker run --name healthcheck_ex -d dockerinaction/healthcheck

# 在容器启动时指定健康检查命令
# 在命令中指定的健康检查命令将覆盖镜像定义中的健康检查命令
docker run --name=healthcheck_ex -d --health-cmd='nc -vz -w 2 localhost 80 || exit 1' nginx:1.13-alpine
