CREATE DATABASE IF NOT EXISTS railway_db;
USE railway_db;

DROP TABLE IF EXISTS railway_bookings;

CREATE TABLE railway_bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    pnr_number VARCHAR(12) NOT NULL,
    passenger_name VARCHAR(100) NOT NULL,
    train_number VARCHAR(10) NOT NULL,
    source_station VARCHAR(10) NOT NULL,
    destination_station VARCHAR(10) NOT NULL,
    journey_date DATE NOT NULL,
    coach_class VARCHAR(10) NOT NULL,
    booking_status VARCHAR(20) NOT NULL,
    fare DECIMAL(8,2) NOT NULL,
    booked_at DATETIME NOT NULL
) ENGINE=InnoDB;
