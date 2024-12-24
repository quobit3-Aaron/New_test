
# save_to_onedrive.py
import onedrive_sdk
import time

def save_to_onedrive(file_path, one_drive_folder):
    # 设置 OneDrive 客户端
    client = onedrive_sdk.get_default_client(
        client_id='your-client-id',
        scopes=['wl.signin', 'wl.offline_access', 'onedrive.readwrite']
    )
    
    # 使用刷新令牌进行身份验证
    client.auth_provider.authenticate(code='your-refresh-token')

    # 上传文件到 OneDrive
    with open(file_path, 'rb') as file:
        client.item(drive='me', path=one_drive_folder).children[file_path].upload(file)

def test_save_to_onedrive():
    # 创建一个测试文件来验证功能
    test_file_path = "/app/output.txt"
    
    # 模拟从 ACI 容器中生成的文件
    with open(test_file_path, "w") as f:
        f.write("Testing OneDrive integration\n")
        f.write(f"Timestamp: {time.time()}\n")
    
    # 上传该文件到 OneDrive
    save_to_onedrive(test_file_path, '/results-folder')

# 执行 OneDrive 测试
test_save_to_onedrive()
