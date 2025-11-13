USE beverage_portal;

CREATE TABLE IF NOT EXISTS Branches (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    address TEXT,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6)
);

CREATE TABLE IF NOT EXISTS Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10,2),
    image_url VARCHAR(255),
    available BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS Inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT,
    product_id INT,
    quantity INT,
    unit VARCHAR(20),
    last_updated DATETIME,
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE IF NOT EXISTS Promotions (
    promotion_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT,
    title VARCHAR(100),
    description TEXT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

CREATE TABLE IF NOT EXISTS Reports (
    report_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT,
    date DATE,
    total_orders INT,
    revenue DECIMAL(12,2),
    top_products TEXT,
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

CREATE TABLE IF NOT EXISTS Roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Staffs (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT,
    role_id INT,
    name VARCHAR(100),
    email VARCHAR(100),
    active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id),
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);
