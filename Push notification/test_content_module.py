# test_content_module.py
from content_module import create_notification, send_notification

# Tạo thông báo mới
create_notification(1, "Cập nhật hệ thống", "Hệ thống sẽ bảo trì lúc 22h tối nay.")

# Gửi thông báo đến user
send_notification(1)
