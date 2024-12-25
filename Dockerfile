FROM python:3.10-slim

WORKDIR /app

# 安装必要的软件并清理缓存
RUN apt-get update && apt-get install -y openssh-server \
    && mkdir /var/run/sshd \
    && ssh-keygen -A \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 复制 sshd_config 文件到容器
COPY config/sshd_config /etc/ssh/sshd_config

# 创建 SSH 用户
ARG SSH_PASSWORD=testpassword
RUN useradd -rm -d /home/testuser -s /bin/bash testuser \
    && echo "testuser:${SSH_PASSWORD}" | chpasswd \
    && mkdir -p /home/testuser/.ssh \
    && chown -R testuser:testuser /home/testuser/.ssh

RUN useradd -rm -d /home/dev1 -s /bin/bash dev1 \
    && echo "dev1:dev1password" | chpasswd \
    && mkdir -p /home/dev1/.ssh \
    && chown -R dev1:dev1 /home/dev1/.ssh

RUN useradd -rm -d /home/dev2 -s /bin/bash dev2 \
    && echo "dev2:dev2password" | chpasswd \
    && mkdir -p /home/dev2/.ssh \
    && chown -R dev2:dev2 /home/dev2/.ssh

# 复制应用代码和依赖文件
COPY app.py /app/app.py
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# 安装 supervisord 并复制配置文件
RUN pip install supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 暴露端口
EXPOSE 22 5000

# 健康检查
HEALTHCHECK --interval=30s CMD curl -f http://localhost:5000/ || exit 1

# 启动 SSH 服务
CMD ["/usr/sbin/sshd", "-D"]
