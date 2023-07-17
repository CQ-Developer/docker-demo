# 使用命令创建新栈并部署舒服
docker stack deploy -c databases.yml my-databases

# 在更改YAML文件后
# 再次执行该命令会更新服务
docker stack deploy -c databases.yml my-databases
