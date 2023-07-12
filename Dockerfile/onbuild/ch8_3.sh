# 观察镜像构建的过程
docker build -t dockerinaction/ch8_onbuild -f base.df .
docker build -t dockerinaction/ch8_onbuild_down -f downstream.df .
