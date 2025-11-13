"""
Selenium Test Suite for Breezy Admin Dashboard
Module: Quản lý Nội dung & Thông báo
"""
import os
import time
import pytest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.alert import Alert
from webdriver_manager.chrome import ChromeDriverManager

BASE = os.environ.get("BASE_URL", "http://localhost:8000")

@pytest.fixture(scope="module")
def driver():
    """Setup Chrome WebDriver"""
    options = webdriver.ChromeOptions()
    # Comment out next line to see browser
    # options.add_argument("--headless=new")
    driver = webdriver.Chrome(
        service=Service(ChromeDriverManager().install()),
        options=options
    )
    driver.maximize_window()
    driver.implicitly_wait(10)
    yield driver
    driver.quit()


# ==================== TEST CASES ====================

# TC01: Gửi thông báo nhanh thành công
def test_send_notification_success(driver):
    """
    TC01: Test sending quick notification successfully
    Steps:
        1. Navigate to notifications page
        2. Fill in title
        3. Fill in content
        4. Select audience
        5. Click send button
    Expected: Success alert displayed and form cleared
    """
    print("\n[TC01] Testing send notification success...")
    driver.get(f"{BASE}/notifications.html")
    
    # Fill form
    title_input = driver.find_element(By.CSS_SELECTOR, ".quick-panel input[type='text']")
    title_input.clear()
    title_input.send_keys("Test Notification")
    
    content_textarea = driver.find_element(By.CSS_SELECTOR, ".quick-panel textarea")
    content_textarea.clear()
    content_textarea.send_keys("This is a test notification content")
    
    # Select audience
    audience_select = driver.find_element(By.CSS_SELECTOR, ".quick-panel select")
    audience_select.click()
    
    # Click send button
    send_btn = driver.find_element(By.CLASS_NAME, "send-btn")
    send_btn.click()
    
    # Wait for alert
    time.sleep(0.5)
    alert = Alert(driver)
    alert_text = alert.text
    assert "thành công" in alert_text or "successful" in alert_text.lower()
    alert.accept()
    
    print("✓ PASSED: Notification sent successfully")


# TC02: Gửi thông báo với trường bỏ trống
def test_send_notification_empty_fields(driver):
    """
    TC02: Test validation when fields are empty
    Steps:
        1. Navigate to page
        2. Leave title and content empty
        3. Click send button
    Expected: Warning alert displayed
    """
    print("\n[TC02] Testing empty fields validation...")
    driver.get(f"{BASE}/notifications.html")
    
    # Clear fields if any
    title_input = driver.find_element(By.CSS_SELECTOR, ".quick-panel input[type='text']")
    title_input.clear()
    
    content_textarea = driver.find_element(By.CSS_SELECTOR, ".quick-panel textarea")
    content_textarea.clear()
    
    # Click send
    send_btn = driver.find_element(By.CLASS_NAME, "send-btn")
    send_btn.click()
    
    # Wait for alert
    time.sleep(0.5)
    alert = Alert(driver)
    alert_text = alert.text
    assert "Vui lòng" in alert_text or "required" in alert_text.lower()
    alert.accept()
    
    print("✓ PASSED: Validation works for empty fields")


# TC03: Sử dụng template "Chào buổi sáng"
def test_use_template_morning(driver):
    """
    TC03: Test using "Chào buổi sáng" template
    Steps:
        1. Find "Chào buổi sáng" template
        2. Click "Sử dụng" button
    Expected: Form filled with template content
    """
    print("\n[TC03] Testing morning template...")
    driver.get(f"{BASE}/notifications.html")
    
    # Find and click template
    templates = driver.find_elements(By.CSS_SELECTOR, ".templates li")
    for template in templates:
        if "Chào buổi sáng" in template.text:
            use_btn = template.find_element(By.CLASS_NAME, "use-btn")
            use_btn.click()
            break
    
    # Wait for alert
    time.sleep(0.5)
    alert = Alert(driver)
    assert "Template" in alert.text or "áp dụng" in alert.text
    alert.accept()
    
    # Verify form is filled
    title_input = driver.find_element(By.CSS_SELECTOR, ".quick-panel input[type='text']")
    assert "Chào buổi sáng" in title_input.get_attribute("value")
    
    print("✓ PASSED: Morning template applied successfully")


# TC04: Sử dụng template "Khuyến mãi đặc biệt"
def test_use_template_promotion(driver):
    """
    TC04: Test using "Khuyến mãi đặc biệt" template
    """
    print("\n[TC04] Testing promotion template...")
    driver.get(f"{BASE}/notifications.html")
    
    templates = driver.find_elements(By.CSS_SELECTOR, ".templates li")
    for template in templates:
        if "Khuyến mãi" in template.text:
            use_btn = template.find_element(By.CLASS_NAME, "use-btn")
            use_btn.click()
            break
    
    time.sleep(0.5)
    alert = Alert(driver)
    alert.accept()
    
    title_input = driver.find_element(By.CSS_SELECTOR, ".quick-panel input[type='text']")
    assert "Flash Sale" in title_input.get_attribute("value")
    
    print("✓ PASSED: Promotion template applied successfully")


# TC05: Sử dụng template "Yêu cầu đánh giá" - FIXED
def test_use_template_review(driver):
    """
    TC05: Test using "Yêu cầu đánh giá" template
    """
    print("\n[TC05] Testing review template...")
    driver.get(f"{BASE}/notifications.html")
    
    # Scroll to templates section first
    templates_section = driver.find_element(By.CLASS_NAME, "templates-section")
    driver.execute_script("arguments[0].scrollIntoView({behavior: 'smooth', block: 'center'});", templates_section)
    time.sleep(0.5)
    
    templates = driver.find_elements(By.CSS_SELECTOR, ".templates li")
    for template in templates:
        if "đánh giá" in template.text:
            # Use JavaScript click to avoid interception
            use_btn = template.find_element(By.CLASS_NAME, "use-btn")
            driver.execute_script("arguments[0].scrollIntoView({block: 'center'});", use_btn)
            time.sleep(0.3)
            driver.execute_script("arguments[0].click();", use_btn)
            break
    
    time.sleep(0.5)
    alert = Alert(driver)
    alert.accept()
    
    title_input = driver.find_element(By.CSS_SELECTOR, ".quick-panel input[type='text']")
    assert "Đánh giá" in title_input.get_attribute("value")
    
    print("✓ PASSED: Review template applied successfully")


# TC06: Sử dụng template "Cửa hàng mới" - FIXED
def test_use_template_new_store(driver):
    """
    TC06: Test using "Cửa hàng mới" template
    """
    print("\n[TC06] Testing new store template...")
    driver.get(f"{BASE}/notifications.html")
    
    # Scroll to templates section first
    templates_section = driver.find_element(By.CLASS_NAME, "templates-section")
    driver.execute_script("arguments[0].scrollIntoView({behavior: 'smooth', block: 'center'});", templates_section)
    time.sleep(0.5)
    
    templates = driver.find_elements(By.CSS_SELECTOR, ".templates li")
    for template in templates:
        if "Cửa hàng" in template.text:
            # Use JavaScript click to avoid interception
            use_btn = template.find_element(By.CLASS_NAME, "use-btn