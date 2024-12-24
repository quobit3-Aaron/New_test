# 使用基础镜像
FROM python:3.10-slim

# 设置工作目录
WORKDIR /app

# 安装必要的软件，包括 SSH 服务和 Python 的依赖
RUN apt-get update && apt-get install -y openssh-server \
    && mkdir /var/run/sshd \
    && ssh-keygen -A

# 生成 SSH 主机密钥（如果没有会导致 SSH 服务无法启动）
RUN ssh-keygen -A

# 创建 SSH 用户（testuser）并设置密码（testpassword）
RUN useradd -rm -d /home/testuser -s /bin/bash testuser \
    && echo "testuser:testpassword" | chpasswd \
    && mkdir -p /home/testuser/.ssh \
    && chown -R testuser:testuser /home/testuser/.ssh

# 复制应用代码到容器中
COPY app.py /app/app.py

# 复制 Python 依赖文件并安装
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# 暴露端口：22（SSH）和 5000（Python 应用）
EXPOSE 22 5000

# 使用 supervisord 启动多个服务
RUN pip install supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 运行 supervisord 来管理 SSH 和 Python 应用
CMD ["/usr/bin/supervisord"]
