
# save_to_onedrive.py
import onedrive_sdk
import time

def save_to_onedrive(file_path, one_drive_folder):
    # ���� OneDrive �ͻ���
    client = onedrive_sdk.get_default_client(
        client_id='your-client-id',
        scopes=['wl.signin', 'wl.offline_access', 'onedrive.readwrite']
    )
    
    # ʹ��ˢ�����ƽ��������֤
    client.auth_provider.authenticate(code='your-refresh-token')

    # �ϴ��ļ��� OneDrive
    with open(file_path, 'rb') as file:
        client.item(drive='me', path=one_drive_folder).children[file_path].upload(file)

def test_save_to_onedrive():
    # ����һ�������ļ�����֤����
    test_file_path = "/app/output.txt"
    
    # ģ��� ACI ���������ɵ��ļ�
    with open(test_file_path, "w") as f:
        f.write("Testing OneDrive integration\n")
        f.write(f"Timestamp: {time.time()}\n")
    
    # �ϴ����ļ��� OneDrive
    save_to_onedrive(test_file_path, '/results-folder')

# ִ�� OneDrive ����
test_save_to_onedrive()
