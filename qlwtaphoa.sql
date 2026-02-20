SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `auth_project`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `auth_project`;

-- Accounts
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `role` VARCHAR(50) NOT NULL DEFAULT 'user', -- admin | user
  `remember_token` VARCHAR(100) DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- password reset tokens
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` VARCHAR(255) NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Seed (password: 123456)
INSERT INTO `accounts` (`name`, `email`, `password`, `role`, `created_at`, `updated_at`) VALUES
('Admin', 'admin@local.test', '$2y$10$kxmGnDWKoIUCyU5erFJxPeB.tO6ZUPdg3ImdZWUBSz3czt2FqXDa2', 'admin', NOW(), NOW()),
('User',  'user@local.test',  '$2y$10$kxmGnDWKoIUCyU5erFJxPeB.tO6ZUPdg3ImdZWUBSz3czt2FqXDa2', 'user',  NOW(), NOW());

COMMIT;
