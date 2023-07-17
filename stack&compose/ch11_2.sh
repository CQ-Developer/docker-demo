# 使用命令创建新栈并部署舒服
# Docker栈是服务、卷、网络、密钥、配置的命令集合
# 更改YAML文件后，再次执行该命令会更新服务
docker stack deploy -c databases.yml my-databases

# 列出栈中所有的任务及其存在时间
docker stack ps --format '{{.Name}}\t{{.CurrentState}}' my-databases

# 删除服务
# 可以通过 docker service rm 命令手动删除，并不推荐
# 可以通过在 Compose 文件中删除服务，并在命令行中添加 --prune 选项实现
docker stack deploy -c databases.yml --prune my-databases
