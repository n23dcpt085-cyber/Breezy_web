# Breezy Admin - Test Suite: Tạo Thông báo Mới

## Mô tả
Test suite kiểm thử chức năng "Tạo thông báo mới" với modal popup trong Breezy Admin Dashboard sử dụng Selenium WebDriver.

## Test Cases (10 cases)

### Nhóm 1: Modal Operations (3 cases)
- **TC01**: Mở modal "Tạo thông báo mới"
- **TC02**: Đóng modal bằng nút X
- **TC03**: Đóng modal bằng nút Hủy

### Nhóm 2: Input & Validation (3 cases)
- **TC04**: Nhập tiêu đề và kiểm tra character counter
- **TC05**: Nhập nội dung và kiểm tra character counter
- **TC07**: Validation khi bỏ trống trường

### Nhóm 3: Features (4 cases)
- **TC06**: Thêm emoji vào tiêu đề
- **TC08**: Tạo thông báo hoàn chỉnh
- **TC09**: Kiểm tra preview real-time
- **TC10**: Kiểm tra phone preview UI elements

## Cài đặt

### 1. Đảm bảo có đầy đủ files
```
breezy-testing/
├── notifications.html  (đã cập nhật với modal)
├── style.css          (đã cập nhật với modal styles)
├── script.js          (đã cập nhật với modal logic)
├── tests/
│   ├── __init__.py
│   └── test_breezy_create_notification.py
├── conftest.py
├── requirements.txt
└── README_CREATE_NOTIFICATION.md
```

### 2. Cài đặt dependencies
```bash
pip install selenium pytest webdriver-manager
```

### 3. Khởi động server
```bash
python -m http.server 8000
```

## Chạy Tests

### Chạy tất cả tests
```bash
pytest tests/test_breezy_create_notification.py -v -s
```

### Chạy nhóm tests cụ thể
```bash
# Modal operations
pytest tests/test_breezy_create_notification.py -k "modal" -v

# Input validation
pytest tests/test_breezy_create_notification.py -k "input or validation" -v

# Features
pytest tests/test_breezy_create_notification.py -k "emoji or preview or phone" -v
```

### Chạy 1 test cụ thể
```bash
pytest tests/test_breezy_create_notification.py::test_create_complete_notification -v -s
```

## Kết quả mong đợi
```
tests/test_breezy_create_notification.py::test_open_create_notification_modal PASSED       [ 10%]
tests/test_breezy_create_notification.py::test_close_modal_with_x_button PASSED           [ 20%]
tests/test_breezy_create_notification.py::test_close_modal_with_cancel_button PASSED      [ 30%]
tests/test_breezy_create_notification.py::test_title_input_with_character_counter PASSED  [ 40%]
tests/test_breezy_create_notification.py::test_content_input_with_character_counter PASSED[ 50%]
tests/test_breezy_create_notification.py::test_add_emoji_to_title PASSED                  [ 60%]
tests/test_breezy_create_notification.py::test_validation_empty_fields PASSED             [ 70%]
tests/test_breezy_create_notification.py::test_create_complete_notification PASSED        [ 80%]
tests/test_breezy_create_notification.py::test_realtime_preview_update PASSED             [ 90%]
tests/test_breezy_create_notification.py::test_phone_preview_elements PASSED              [100%]

=================== 10 passed in 25.43s ===================
```

## Test Details

### TC01: Mở modal
- Verify button "Tạo thông báo mới" clickable
- Modal xuất hiện với class "show"
- Header text đúng

### TC02 & TC03: Đóng modal
- Click nút X hoặc Hủy
- Modal biến mất (không có class "show")

### TC04 & TC05: Character Counter
- Input text vào title/content
- Counter hiển thị đúng số ký tự
- Preview cập nhật real-time

### TC06: Emoji
- Click emoji button
- Emoji xuất hiện trong input
- Preview cập nhật

### TC07: Validation
- Bỏ trống fields
- Click "Tiếp tục"
- Alert validation hiển thị

### TC08: Tạo thông báo
- Điền đầy đủ thông tin
- Click "Tiếp tục"
- Alert success hiển thị

### TC09: Real-time Preview
- Type từng ký tự
- Preview cập nhật ngay lập tức

### TC10: Phone Preview
- Phone frame visible
- Notch visible
- App icon = "B"
- 3 step dots, 1 active

## Locators

| Element | Locator | Type |
|---------|---------|------|
| Create button | `.create-btn` | Class |
| Modal | `#createNotificationModal` | ID |
| Close button | `.modal-close` | Class |
| Cancel button | `#cancelBtn` | ID |
| Title input | `#notificationTitle` | ID |
| Content textarea | `#notificationContent` | ID |
| Title counter | `#titleCount` | ID |
| Content counter | `#contentCount` | ID |
| Emoji buttons | `.emoji-btn` | Class |
| Next button | `#nextStepBtn` | ID |
| Preview title | `#previewTitle` | ID |
| Preview text | `#previewText` | ID |
| Phone frame | `.phone-frame` | Class |
| App icon | `.app-icon` | Class |
| Step dots | `.dot` | Class |

## Troubleshooting

### Modal không hiển thị
```python
# Tăng thời gian chờ
time.sleep(1)
```

### Preview không cập nhật
```python
# Force trigger input event
driver.execute_script("arguments[0].dispatchEvent(new Event('input'));", element)
```

### Alert không xuất hiện
```python
# Tăng timeout
WebDriverWait(driver, 10).until(EC.alert_is_present())
```

## Screenshots

Để chụp màn hình:
```python
driver.save_screenshot('screenshots/tc01_modal_opened.png')
```

## Notes

- Modal sử dụng animation, cần delay sau khi open/close
- Character counter cập nhật real-time
- Preview phone có responsive design
- Emoji buttons có visual feedback
- Form validation chặt chẽ

---

**Module**: Tạo Thông báo Mới  
**Total Tests**: 10  
**Pass Rate Target**: 100%  
**Browser**: Chrome (ChromeDriver auto-download)