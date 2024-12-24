
# 使用基础镜像
FROM python:3.10-slim

# 设置工作目录
WORKDIR /app

# 复制应用文件到容器中
COPY app.py /app/app.py

# 安装必要的依赖
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# 指定运行的命令
CMD ["python", "app.py"]
