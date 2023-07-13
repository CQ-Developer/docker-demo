FROM nginx:1.13-alpine
HEALTHCHECK --interval=5s --retries=2 CMD nc -vz -w 2 localhost 80 || exit 1

# 状态码
# 0 成功：容器监控并可用
# 1 不健康：容器无法正常工作
# 2 保留的：这个退出状态码未启用
