
-- Người dùng
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    password_hash VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Ví điện tử
CREATE TABLE Wallets (
    wallet_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    balance DECIMAL(10,2) DEFAULT 0,
    last_updated DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Tích điểm
CREATE TABLE LoyaltyPoints (
    point_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    points INT,
    earned_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Voucher
CREATE TABLE Vouchers (
    voucher_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    code VARCHAR(50),
    discount DECIMAL(5,2),
    expiry_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Thông báo
CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    title VARCHAR(100),
    message TEXT,
    sent_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Chi nhánh
CREATE TABLE Branches (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    address TEXT,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6)
);

-- Vai trò
CREATE TABLE Roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50)
);

-- Nhân viên
CREATE TABLE Staffs (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT,
    role_id INT,
    name VARCHAR(100),
    email VARCHAR(100),
    active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id),
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

-- Quyền truy cập
CREATE TABLE Permissions (
    permission_id INT PRIMARY KEY AUTO_INCREMENT,
    role_id INT,
    module VARCHAR(50),
    action VARCHAR(50),
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

-- Sản phẩm
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10,2),
    image_url VARCHAR(255),
    available BOOLEAN DEFAULT TRUE
);

-- Tồn kho
CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT,
    product_id INT,
    quantity INT,
    unit VARCHAR(20),
    last_updated DATETIME,
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Đơn hàng
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    branch_id INT,
    status VARCHAR(50),
    order_type VARCHAR(20),
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

-- Chi tiết đơn hàng
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Thanh toán
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    method VARCHAR(50),
    amount DECIMAL(10,2),
    paid_at DATETIME,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Đánh giá
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product_id INT,
    rating INT,
    comment TEXT,
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Chat
CREATE TABLE Chats (
    chat_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    staff_id INT,
    message TEXT,
    sent_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (staff_id) REFERENCES Staffs(staff_id)
);

-- Khuyến mãi
CREATE TABLE Promotions (
    promotion_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT,
    title VARCHAR(100),
    description TEXT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

-- Báo cáo
CREATE TABLE Reports (
    report_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT,
    date DATE,
    total_orders INT,
    revenue DECIMAL(12,2),
    top_products TEXT,
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

-- Quản trị viên
CREATE TABLE Admins (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    role_id INT,
    name VARCHAR(100),
    email VARCHAR(100),
    active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

-- Nội dung truyền thông số
CREATE TABLE MediaAssets (
    media_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    type VARCHAR(20), -- image, video, clip
    url VARCHAR(255),
    uploaded_by INT,
    uploaded_at DATETIME,
    FOREIGN KEY (uploaded_by) REFERENCES Admins(admin_id)
);

CREATE TABLE ContentPosts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    content TEXT,
    channel VARCHAR(50), -- Web, Facebook, Zalo, TikTok, YouTube
    published_at DATETIME,
    published_by INT,
    FOREIGN KEY (published_by) REFERENCES Admins(admin_id)
);

CREATE TABLE SEOAnalytics (
    analytics_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT,
    views INT,
    clicks INT,
    shares INT,
    updated_at DATETIME,
    FOREIGN KEY (post_id) REFERENCES ContentPosts(post_id)
);

CREATE TABLE Livestreams (
    stream_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    scheduled_at DATETIME,
    channel VARCHAR(50),
    host_id INT,
    FOREIGN KEY (host_id) REFERENCES Staffs(staff_id)
);

-- Roles
INSERT INTO Roles (role_name) VALUES
('Admin'), ('Manager'), ('Nhân viên');

-- Users
INSERT INTO Users (name, email, phone, password_hash) VALUES
('Nguyễn Văn A', 'nguyenvana@example.com', '0900000001', 'hash1'),
('Trần Thị B', 'tranthib@example.com', '0900000002', 'hash2'),
('Lê Văn C', 'levanc@example.com', '0900000003', 'hash3'),
('Phạm Thị D', 'phamthid@example.com', '0900000004', 'hash4'),
('Hoàng Văn E', 'hoangvane@example.com', '0900000005', 'hash5'),
('Đỗ Thị F', 'dothif@example.com', '0900000006', 'hash6'),
('Vũ Văn G', 'vuvang@example.com', '0900000007', 'hash7'),
('Ngô Thị H', 'ngothih@example.com', '0900000008', 'hash8'),
('Bùi Văn I', 'buivani@example.com', '0900000009', 'hash9'),
('Đặng Thị J', 'dangthij@example.com', '0900000010', 'hash10'),
('Trịnh Văn K', 'trinhvank@example.com', '0900000011', 'hash11'),
('Mai Thị L', 'maithil@example.com', '0900000012', 'hash12'),
('Tô Văn M', 'tovanm@example.com', '0900000013', 'hash13'),
('Lý Thị N', 'lythin@example.com', '0900000014', 'hash14'),
('Châu Văn O', 'chauvano@example.com', '0900000015', 'hash15'),
('Hồ Thị P', 'hothip@example.com', '0900000016', 'hash16'),
('Tăng Văn Q', 'tangvanq@example.com', '0900000017', 'hash17'),
('Quách Thị R', 'quachthir@example.com', '0900000018', 'hash18'),
('Hà Văn S', 'havans@example.com', '0900000019', 'hash19'),
('Lương Thị T', 'luongthit@example.com', '0900000020', 'hash20');


-- Wallets
INSERT INTO Wallets (user_id, balance) VALUES
(1, 500000), (2, 150000), (3, 0), (4, 200000), (5, 100000);

-- LoyaltyPoints
INSERT INTO LoyaltyPoints (user_id, points, earned_at) VALUES
(1, 100, NOW()), (2, 50, NOW()), (3, 75, NOW());

-- Vouchers
INSERT INTO Vouchers (user_id, code, discount, expiry_date) VALUES
(1, 'WELCOME10', 10.00, '2025-12-31'),
(2, 'SAVE20', 20.00, '2025-11-30');

-- Notifications
INSERT INTO Notifications (user_id, title, message) VALUES
(1, 'Chào mừng bạn!', 'Cảm ơn bạn đã đăng ký tài khoản.'),
(2, 'Khuyến mãi mới', 'Bạn có voucher giảm 20%.');

-- Branches
INSERT INTO Branches (name, address, latitude, longitude) VALUES
('Chi nhánh Quận 1', '123 Lê Lợi, Q1, TP.HCM', 10.7769, 106.7009),
('Chi nhánh Quận 3', '456 Võ Văn Tần, Q3, TP.HCM', 10.7798, 106.6823),
('Chi nhánh Hà Nội', '789 Tràng Tiền, Hoàn Kiếm, HN', 21.0285, 105.8542),
('Chi nhánh Đà Nẵng', '321 Bạch Đằng, Hải Châu, ĐN', 16.0678, 108.2208),
('Chi nhánh Cần Thơ', '654 Nguyễn Trãi, Ninh Kiều, CT', 10.0342, 105.7875);

-- Staffs
INSERT INTO Staffs (branch_id, role_id, name, email) VALUES
(1, 3, 'Nguyễn Nhân Viên 1', 'nhanvien1@example.com'),
(1, 3, 'Nguyễn Nhân Viên 2', 'nhanvien2@example.com'),
(2, 3, 'Nguyễn Nhân Viên 3', 'nhanvien3@example.com'),
(2, 3, 'Nguyễn Nhân Viên 4', 'nhanvien4@example.com'),
(3, 3, 'Nguyễn Nhân Viên 5', 'nhanvien5@example.com'),
(3, 3, 'Nguyễn Nhân Viên 6', 'nhanvien6@example.com'),
(4, 3, 'Nguyễn Nhân Viên 7', 'nhanvien7@example.com'),
(4, 3, 'Nguyễn Nhân Viên 8', 'nhanvien8@example.com'),
(5, 3, 'Nguyễn Nhân Viên 9', 'nhanvien9@example.com'),
(5, 3, 'Nguyễn Nhân Viên 10', 'nhanvien10@example.com');

-- Admins
INSERT INTO Admins (role_id, name, email) VALUES
(1, 'Super Admin', 'admin@system.com');

-- Permissions
INSERT INTO Permissions (role_id, module, action) VALUES
(1, 'Users', 'Read'), (1, 'Users', 'Update'),
(2, 'Orders', 'Read'), (3, 'Orders', 'Update');

-- Products
INSERT INTO Products (name, description, price, image_url) VALUES
('Trà sữa truyền thống', 'Vị trà sữa cổ điển', 30000, 'https://example.com/ts1.jpg'),
('Trà sữa matcha', 'Vị matcha Nhật Bản', 35000, 'https://example.com/ts2.jpg'),
('Trà sữa thái xanh', 'Trà sữa vị thái xanh mát lạnh', 32000, 'https://example.com/ts_thai.jpg'),
('Trà sữa hồng trà', 'Trà sữa hồng trà đậm vị', 30000, 'https://example.com/ts_hongtra.jpg'),
('Trà sữa socola', 'Trà sữa vị socola ngọt ngào', 35000, 'https://example.com/ts_choco.jpg'),
('Trà sữa khoai môn', 'Trà sữa khoai môn béo ngậy', 36000, 'https://example.com/ts_khoaimon.jpg'),
('Trà sữa dâu', 'Trà sữa vị dâu tây thơm ngon', 34000, 'https://example.com/ts_dau.jpg'),
('Trà sữa bạc hà', 'Trà sữa vị bạc hà mát lạnh', 33000, 'https://example.com/ts_bacha.jpg'),
('Trà sữa caramel', 'Trà sữa vị caramel ngọt dịu', 37000, 'https://example.com/ts_caramel.jpg'),
('Trà sữa phô mai', 'Trà sữa kết hợp phô mai béo', 38000, 'https://example.com/ts_phomai.jpg'),
('Trà sữa sầu riêng', 'Trà sữa vị sầu riêng đặc trưng', 39000, 'https://example.com/ts_saurieng.jpg'),
('Trà sữa việt quất', 'Trà sữa vị việt quất chua ngọt', 35000, 'https://example.com/ts_vietquat.jpg'),
('Cà phê sữa đá', 'Cà phê pha phin', 25000, 'https://example.com/cf1.jpg'),
('Cà phê đen đá', 'Cà phê đen nguyên chất', 20000, 'https://example.com/cf_den.jpg'),
('Cà phê muối', 'Cà phê kết hợp muối biển', 28000, 'https://example.com/cf_muoi.jpg'),
('Cà phê trứng', 'Cà phê truyền thống với lớp kem trứng', 30000, 'https://example.com/cf_trung.jpg'),
('Cà phê caramel', 'Cà phê vị caramel ngọt dịu', 29000, 'https://example.com/cf_caramel.jpg'),
('Sinh tố dâu', 'Sinh tố dâu tây tươi mát', 35000, 'https://example.com/st_dau.jpg'),
('Sinh tố bơ', 'Sinh tố bơ béo ngậy', 36000, 'https://example.com/st_bo.jpg'),
('Sinh tố mãng cầu', 'Sinh tố mãng cầu chua ngọt', 34000, 'https://example.com/st_mangcau.jpg'),
('Sinh tố xoài', 'Xoài tươi xay nhuyễn', 40000, 'https://example.com/st1.jpg'),
('Nước ép dứa', 'Nước ép dứa tươi nguyên chất', 30000, 'https://example.com/ne_dua.jpg'),
('Nước ép cà rốt', 'Nước ép cà rốt bổ dưỡng', 28000, 'https://example.com/ne_carot.jpg'),
('Nước ép cam', 'Cam tươi nguyên chất', 30000, 'https://example.com/ne1.jpg'),
('Trà đào cam sả', 'Trà đào thơm mát', 35000, 'https://example.com/td1.jpg'),
('Soda việt quất', 'Soda mát lạnh', 32000, 'https://example.com/sd1.jpg'),
('Soda chanh dây', 'Soda vị chanh dây mát lạnh', 32000, 'https://example.com/sd_chanhday.jpg');

INSERT INTO Products (name, description, price, image_url) VALUES
('Bánh mì gà', 'Bánh mì kẹp gà nướng', 45000, 'https://example.com/bm1.jpg'),
('Bánh mì thịt nguội', 'Bánh mì kẹp thịt nguội và rau sống', 40000, 'https://example.com/bm_thitnguoi.jpg'),
('Bánh mì bò nướng', 'Bánh mì kẹp bò nướng thơm ngon', 45000, 'https://example.com/bm_bonuong.jpg'),
('Bánh mì xíu mại', 'Bánh mì kèm xíu mại nóng hổi', 42000, 'https://example.com/bm_xiumai.jpg'),
('Bánh mì trứng ốp la', 'Bánh mì kèm trứng chiên', 38000, 'https://example.com/bm_opla.jpg'),
('Khoai tây chiên', 'Khoai tây chiên giòn rụm', 30000, 'https://example.com/khoaitay.jpg'),
('Xúc xích nướng', 'Xúc xích nướng thơm lừng', 35000, 'https://example.com/xucxich.jpg'),
('Gà viên chiên', 'Gà viên chiên giòn', 40000, 'https://example.com/gavien.jpg'),
('Phô mai que', 'Phô mai que kéo sợi', 32000, 'https://example.com/phomaique.jpg'),
('Bánh tráng trộn', 'Bánh tráng trộn cay mặn ngọt', 30000, 'https://example.com/bttron.jpg'),
('Bánh tráng nướng', 'Bánh tráng nướng giòn tan', 35000, 'https://example.com/btnuong.jpg');

INSERT INTO Products (name, description, price, image_url) VALUES
('Bánh ngọt socola', 'Bánh mềm vị socola', 28000, 'https://example.com/bn1.jpg'),
('Bánh flan', 'Bánh flan mềm mịn', 25000, 'https://example.com/flan.jpg'),
('Bánh bông lan trứng muối', 'Bánh bông lan vị trứng muối', 30000, 'https://example.com/bbltm.jpg'),
('Bánh mousse dâu', 'Bánh mousse vị dâu tây', 32000, 'https://example.com/mousse_dau.jpg'),
('Bánh mousse socola', 'Bánh mousse vị socola', 33000, 'https://example.com/mousse_choco.jpg'),
('Bánh tiramisu', 'Bánh tiramisu Ý truyền thống', 35000, 'https://example.com/tiramisu.jpg'),
('Bánh kem matcha', 'Bánh kem vị matcha Nhật', 34000, 'https://example.com/kem_matcha.jpg'),
('Bánh kem dừa', 'Bánh kem vị dừa thơm béo', 33000, 'https://example.com/kem_dua.jpg'),
('Kem socola', 'Kem lạnh vị socola', 30000, 'https://example.com/kem_choco.jpg'),
('Kem vani', 'Kem lạnh vị vani', 30000, 'https://example.com/km1.jpg'),
('Kem dâu', 'Kem lạnh vị dâu tây', 30000, 'https://example.com/kem_dau.jpg'),
('Kem sầu riêng', 'Kem lạnh vị sầu riêng', 32000, 'https://example.com/kem_saurieng.jpg');



-- Inventory
-- Tồn kho cho Chi nhánh Quận 1
INSERT INTO Inventory (branch_id, product_id, quantity, unit) VALUES
(1, 1, 120, 'ly'),
(1, 2, 100, 'ly'),
(1, 3, 80, 'ly'),
(1, 4, 60, 'ly'),
(1, 5, 90, 'ly'),
(1, 6, 70, 'ly'),
(1, 7, 50, 'ly'),
(1, 8, 40, 'ổ'),
(1, 9, 30, 'cái'),
(1, 10, 100, 'ly');

-- Tồn kho cho Chi nhánh Quận 3
INSERT INTO Inventory (branch_id, product_id, quantity, unit) VALUES
(2, 11, 110, 'ly'),
(2, 12, 90, 'ly'),
(2, 13, 70, 'ly'),
(2, 14, 60, 'ly'),
(2, 15, 80, 'ly'),
(2, 16, 50, 'ly'),
(2, 17, 40, 'ly'),
(2, 18, 30, 'ly'),
(2, 19, 20, 'ly'),
(2, 20, 100, 'ly');

-- Tồn kho cho Chi nhánh Hà Nội
INSERT INTO Inventory (branch_id, product_id, quantity, unit) VALUES
(3, 21, 100, 'ổ'),
(3, 22, 90, 'ổ'),
(3, 23, 80, 'ổ'),
(3, 24, 70, 'ổ'),
(3, 25, 60, 'phần'),
(3, 26, 50, 'cây'),
(3, 27, 40, 'viên'),
(3, 28, 30, 'cây'),
(3, 29, 20, 'phần'),
(3, 30, 100, 'cái');

-- Tồn kho cho Chi nhánh Đà Nẵng
INSERT INTO Inventory (branch_id, product_id, quantity, unit) VALUES
(4, 31, 100, 'cái'),
(4, 32, 90, 'cái'),
(4, 33, 80, 'cái'),
(4, 34, 70, 'cái'),
(4, 35, 60, 'cái'),
(4, 36, 50, 'cái'),
(4, 37, 40, 'cái'),
(4, 38, 30, 'ly'),
(4, 39, 20, 'ly'),
(4, 40, 100, 'ly');

-- Tồn kho cho Chi nhánh Cần Thơ
INSERT INTO Inventory (branch_id, product_id, quantity, unit) VALUES
(5, 41, 100, 'ly'),
(5, 42, 90, 'ly'),
(5, 43, 80, 'ly'),
(5, 44, 70, 'ly'),
(5, 45, 60, 'ly'),
(5, 46, 50, 'ly'),
(5, 47, 40, 'ly'),
(5, 48, 30, 'ly'),
(5, 49, 20, 'ly'),
(5, 50, 100, 'ly');


-- Orders
INSERT INTO Orders (user_id, branch_id, status, order_type) VALUES
(1, 1, 'Đã thanh toán', 'Online'),
(2, 1, 'Đang xử lý', 'Tại quầy'),
(3, 2, 'Đã giao', 'Online'),
(4, 2, 'Đã hủy', 'Online'),
(5, 3, 'Đã thanh toán', 'Tại quầy');

-- OrderDetails
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES
(1, 1, 2, 60000), (1, 3, 1, 25000),
(2, 2, 1, 35000), (3, 4, 2, 80000),
(4, 5, 1, 30000), (5, 6, 1, 35000);

-- Payments
INSERT INTO Payments (order_id, method, amount) VALUES
(1, 'Ví điện tử', 85000),
(2, 'Tiền mặt', 35000),
(3, 'Thẻ ngân hàng', 80000);

-- Reviews
INSERT INTO Reviews (user_id, product_id, rating, comment) VALUES
(1, 1, 5, 'Ngon tuyệt vời!'),
(2, 2, 4, 'Matcha thơm, nhưng hơi ngọt.'),
(3, 3, 5, 'Cà phê đậm đà.');

-- Chats
INSERT INTO Chats (user_id, staff_id, message) VALUES
(1, 2, 'Mình muốn hỏi về đơn hàng hôm qua.'),
(2, 3, 'Voucher của mình hết hạn rồi thì sao?');

-- Promotions
INSERT INTO Promotions (branch_id, title, description, start_date, end_date) VALUES
(1, 'Mua 1 tặng 1', 'Áp dụng cho trà sữa truyền thống', '2025-10-01', '2025-10-15');

-- Reports
INSERT INTO Reports (branch_id, date, total_orders, revenue, top_products) VALUES
(1, '2025-10-30', 120, 3500000, 'Trà sữa truyền thống, Cà phê sữa đá');

-- MediaAssets
INSERT INTO MediaAssets (title, type, url, uploaded_by) VALUES
('Banner khuyến mãi', 'image', 'https://example.com/banner.jpg', 1);

-- ContentPosts
INSERT INTO ContentPosts (title, content, channel, published_by) VALUES
('Ưu đãi tháng 10', 'Tháng 10 rực rỡ với nhiều ưu đãi hấp dẫn!', 'Facebook', 1);

-- SEOAnalytics
INSERT INTO SEOAnalytics (post_id, views, clicks, shares) VALUES
(1, 1200, 300, 45);

-- Livestreams
INSERT INTO Livestreams (title, scheduled_at, channel, host_id) VALUES
('Livestream giới thiệu sản phẩm mới', '2025-11-05 19:00:00