# 构建镜像
docker build -t dockerinaction/mailer-base:0.6 -f mailer-base.df .
# 查看镜像的元数据
docker inspect dockerinaction/mailer-base:0.6

# 构建镜像
docker build -t dockerinaction/mailer-logging -f mailer-logging.df .
# 运行容器
docker run -d --name logging-mailer dockerinaction/mailer-logging
