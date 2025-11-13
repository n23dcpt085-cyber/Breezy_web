import pytest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

@pytest.fixture
def driver():
    driver = webdriver.Chrome()
    try:
        driver.get("http://localhost:3000")  # Trang chatbox
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, ".chat-box input"))
        )
        yield driver
    finally:
        driver.quit()

# Test 1: Gửi tin nhắn và hiển thị lại
def test_send_message(driver):
    input_box = driver.find_element(By.CSS_SELECTOR, ".chat-box input")
    input_box.send_keys("Cho mình trà đào")
    input_box.send_keys(Keys.ENTER)

    user_msgs = WebDriverWait(driver, 10).until(
        EC.presence_of_all_elements_located((By.CSS_SELECTOR, ".user-msg"))
    )
    assert any("trà đào" in msg.text.lower() for msg in user_msgs)

# Test 2: Bot phản hồi
def test_bot_response(driver):
    bot_msgs = WebDriverWait(driver, 10).until(
        EC.presence_of_all_elements_located((By.CSS_SELECTOR, ".bot-msg"))
    )
    assert any("xin chào" in msg.text.lower() for msg in bot_msgs)

# Test 3: DrinkCard hiển thị
def test_drinkcard_display(driver):
    input_box = driver.find_element(By.CSS_SELECTOR, ".chat-box input")
    input_box.send_keys("Cho mình trà chanh dây size M, ít đá, ít đường nha!")
    input_box.send_keys(Keys.ENTER)

    # Chờ DrinkCard hiển thị
    drinkcard = WebDriverWait(driver, 20).until(
        EC.presence_of_element_located((By.CLASS_NAME, "drink-card"))
    )
    assert drinkcard.is_displayed(), "DrinkCard không hiển thị"


# Test 4: Nút "Đặt hàng luôn"
def test_order_button(driver):
    # Chờ nút "Đặt hàng luôn" trong DrinkCard
    order_button = WebDriverWait(driver, 20).until(
        EC.presence_of_element_located((By.XPATH, "//button[contains(text(),'Đặt hàng luôn')]"))
    )
    assert order_button.is_displayed(), "Nút 'Đặt hàng luôn' không hiển thị"

