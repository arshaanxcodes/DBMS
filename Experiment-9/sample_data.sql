USE railway_db;

SET SESSION cte_max_recursion_depth = 10000;

INSERT INTO railway_bookings (
    pnr_number,
    passenger_name,
    train_number,
    source_station,
    destination_station,
    journey_date,
    coach_class,
    booking_status,
    fare,
    booked_at
)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 6000
)
SELECT
    CONCAT('PNR', LPAD(400000000 + n, 9, '0')),
    CONCAT('Passenger_', n),
    ELT((n % 8) + 1, '12951', '12002', '22436', '12627', '12301', '12839', '12123', '12423'),
    ELT((n % 6) + 1, 'NDLS', 'BCT', 'SBC', 'LKO', 'HWH', 'MAS'),
    ELT(((n + 2) % 6) + 1, 'NDLS', 'BCT', 'SBC', 'LKO', 'HWH', 'MAS'),
    DATE_ADD('2025-01-01', INTERVAL (n % 180) DAY),
    ELT((n % 5) + 1, '1A', '2A', '3A', 'SL', 'CC'),
    ELT((n % 4) + 1, 'CONFIRMED', 'RAC', 'WL', 'CANCELLED'),
    ROUND(450.00 + (n % 25) * 150.00, 2),
    DATE_ADD('2024-12-01 08:00:00', INTERVAL n MINUTE)
FROM seq;

SELECT COUNT(*) AS total_bookings FROM railway_bookings;
