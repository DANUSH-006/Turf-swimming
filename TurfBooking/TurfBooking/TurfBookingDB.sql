CREATE DATABASE IF NOT EXISTS turfbookingdb
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE turfbookingdb;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('user','business') NOT NULL DEFAULT 'user'
);

CREATE TABLE IF NOT EXISTS venues (
    id INT AUTO_INCREMENT PRIMARY KEY,
    owner_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    description TEXT,
    price_per_hour DECIMAL(10,2) NOT NULL DEFAULT 700.00,
    image_url VARCHAR(255) DEFAULT 'images/turf1.jpeg',
    CONSTRAINT fk_venues_owner
        FOREIGN KEY (owner_id) REFERENCES users(id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    venue_id INT NOT NULL,
    booking_date DATE NOT NULL,
    booking_time TIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_bookings_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_bookings_venue
        FOREIGN KEY (venue_id) REFERENCES venues(id)
        ON DELETE CASCADE
);

-- Upgrade older installations that were created from the previous SQL file.
ALTER TABLE venues ADD COLUMN IF NOT EXISTS price_per_hour DECIMAL(10,2) NOT NULL DEFAULT 700.00;
ALTER TABLE venues ADD COLUMN IF NOT EXISTS image_url VARCHAR(255) DEFAULT 'images/turf1.jpeg';
ALTER TABLE bookings ADD COLUMN IF NOT EXISTS booking_time TIME;

UPDATE venues SET image_url='images/turf1.jpeg' WHERE id=1 AND (image_url IS NULL OR image_url='');
UPDATE venues SET image_url='images/turf2.jpeg' WHERE id=2 AND (image_url IS NULL OR image_url='');
UPDATE venues SET image_url='images/turf3.jpeg' WHERE id=3 AND (image_url IS NULL OR image_url='');

SELECT * FROM users;
SELECT * FROM venues;
SELECT * FROM bookings;
