
# 使用基础镜像
FROM python:3.10-slim

# 设置工作目录
WORKDIR /app

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

# 复制应用文件到容器中
COPY app.py /app/app.py

# 安装必要的依赖
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# 暴露端口 22
EXPOSE 22

# 启动 SSH 服务
CMD ["/usr/sbin/sshd", "-D"]
# 指定运行的命令
CMD ["python", "app.py"]
