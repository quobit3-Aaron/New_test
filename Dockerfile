
# ʹ�û�������
FROM python:3.10-slim

# ���ù���Ŀ¼
WORKDIR /app

# ����Ӧ���ļ���������
COPY app.py /app/app.py

# ��װ��Ҫ������
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# ָ�����е�����
CMD ["python", "app.py"]
