# 🧪 AI ChatBox Frontend Testing

Dự án này sử dụng **Selenium** để kiểm thử giao diện người dùng của một hệ thống chatbot AI đặt đồ uống. Mục tiêu là đảm bảo các chức năng như gửi tin nhắn, phản hồi từ bot, hiển thị `DrinkCard`, và các nút hành động đều hoạt động đúng.

## 📦 Cấu trúc thư mục
testing_AICHATBOX/ 
├── tests/
│ └── chatbox_test.py
├── README.md
└── requirements.txt

## 🚀 Cách chạy test

1. Khởi động ứng dụng React của bạn tại `http://localhost:3000`
2. Mở terminal và chạy:

python tests/chatbox_test.py
✅ Test hoàn tất: ChatBox hoạt động đúng và DrinkCard hiển thị!
✅ Các chức năng được kiểm thử
Gửi tin nhắn từ người dùng

Hiển thị tin nhắn trong khung chat

Phản hồi từ bot

Hiển thị DrinkCard đúng vị trí

Kiểm tra nút “Đặt hàng luôn” hoạt động

📌 Yêu cầu hệ thống
Python 3.7+

Google Chrome

ChromeDriver phù hợp với phiên bản Chrome