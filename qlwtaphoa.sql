CREATE DATABASE IF NOT EXISTS qlwtaphoa;
USE qlwtaphoa;

-- =========================
-- 1. BẢNG USERS
-- =========================
CREATE TABLE users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin','staff') NOT NULL DEFAULT 'staff',
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL
);

-- =========================
-- 2. BẢNG PASSWORD RESET
-- =========================
CREATE TABLE password_reset_tokens (
    email VARCHAR(255) NOT NULL,
    token VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NULL DEFAULT NULL,
    PRIMARY KEY (email)
);

-- =========================
-- 3. BẢNG SESSIONS
-- =========================
CREATE TABLE sessions (
    id VARCHAR(255) NOT NULL PRIMARY KEY,
    user_id BIGINT UNSIGNED NULL,
    ip_address VARCHAR(45) NULL,
    user_agent TEXT NULL,
    payload LONGTEXT NOT NULL,
    last_activity INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- =========================
-- 4. TÀI KHOẢN MẪU
-- =========================
-- Mật khẩu: 123456 (đã hash bcrypt)
INSERT INTO users (name, email, password, role, created_at, updated_at) VALUES
('Admin', 'admin@qltaphoa.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9VjA36TObgGJE0E7E5WZ7K', 'admin', NOW(), NOW()),
('NhanVien', 'staff@qltaphoa.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9VjA36TObgGJE0E7E5WZ7K', 'staff', NOW(), NOW());