USE beverage_portal;

CREATE TABLE IF NOT EXISTS Admins (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    role_id INT,
    name VARCHAR(100),
    email VARCHAR(100),
    active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

CREATE TABLE IF NOT EXISTS Permissions (
    permission_id INT PRIMARY KEY AUTO_INCREMENT,
    role_id INT,
    module VARCHAR(50),
    action VARCHAR(50),
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

CREATE TABLE IF NOT EXISTS MediaAssets (
    media_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    type VARCHAR(20),
    url VARCHAR(255),
    uploaded_by INT,
    uploaded_at DATETIME,
    FOREIGN KEY (uploaded_by) REFERENCES Admins(admin_id)
);

CREATE TABLE IF NOT EXISTS ContentPosts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    content TEXT,
    channel VARCHAR(50),
    published_at DATETIME,
    published_by INT,
    FOREIGN KEY (published_by) REFERENCES Admins(admin_id)
);

CREATE TABLE IF NOT EXISTS SEOAnalytics (
    analytics_id INT PRIMARY KEY AUTO_INCREMENT,
    post_id INT,
    views INT,
    clicks INT,
    shares INT,
    updated_at DATETIME,
    FOREIGN KEY (post_id) REFERENCES ContentPosts(post_id)
);

CREATE TABLE IF NOT EXISTS Livestreams (
    stream_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    scheduled_at DATETIME,
    channel VARCHAR(50),
    host_id INT,
    FOREIGN KEY (host_id) REFERENCES Staffs(staff_id)
);
