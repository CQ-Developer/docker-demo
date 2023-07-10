# 运行容器时传入环境变量
docker run --name rich-image-example -e ENV_EXAMPLE1=Rich -e ENV_EXAMPLE2=Example busybox:latest

# 提交变更给镜像
docker commit rich-image rie

# 输出 Rich Example
# 注意这里能够输出这两个环境变量
docker run --rm rie /bin/sh -c "echo \$ENV_EXAMPLE1 \$ENV_EXAMPLE2"

# 设置默认的入口点
# 设置默认命令
docker run --name rich-image-example2 --entrypoint "/bin/sh" rie -c "echo \$ENV_EXAMPLE1 \$ENV_EXAMPLE2"

# 提交镜像
docker commit rich-image-example2 rie

# 注意命令不同
# 但输出的结果相同
docker run --rm rie
