USE beverage_portal;

CREATE TABLE IF NOT EXISTS Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    password_hash VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Wallets (
    wallet_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    balance DECIMAL(10,2) DEFAULT 0,
    last_updated DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE IF NOT EXISTS LoyaltyPoints (
    point_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    points INT,
    earned_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE IF NOT EXISTS Vouchers (
    voucher_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    code VARCHAR(50),
    discount DECIMAL(5,2),
    expiry_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE IF NOT EXISTS Notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    title VARCHAR(100),
    message TEXT,
    sent_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    branch_id INT,
    status VARCHAR(50),
    order_type VARCHAR(20),
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

CREATE TABLE IF NOT EXISTS OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE IF NOT EXISTS Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    method VARCHAR(50),
    amount DECIMAL(10,2),
    paid_at DATETIME,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE IF NOT EXISTS Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    rating INT,
    comment TEXT,
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE IF NOT EXISTS Chats (
    chat_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    staff_id INT,
    message TEXT,
    sent_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (staff_id) REFERENCES Staffs(staff_id)
);
