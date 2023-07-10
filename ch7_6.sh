# 导出文件系统的副本
docker create --name export-test dockerinaction/ch7_packed:latest ./echo For Export
docker export --output contents.tar export-test
docker rm export-test
tar -tf contents.tar

# 导入文件系统
# 新建空文件夹
mkdir import_test
# 编写helloworld.go源码文件
package main
import "fmt"
func main() {
    fmt.Println("hello, world!")
}
# 使用容器编译代码
docker run --rm -v "$(pwd)":/usr/src/hello -w /usr/src/hello golang:1.9 go build -v
# 将程序放入压缩包中
tar -c -f static_hello.tar hello
# 导入压缩文件并创建镜像dockerinaction/ch7_statis
docker import -c "ENTRYPOINT [\"hello\"]" - dockerinaction/ch7_statis < static_hello.tar
# 运行镜像
docker run dockerinaction/ch7_statis
# 查看镜像的历史信息
docker history dockerinaction/ch7_statis
