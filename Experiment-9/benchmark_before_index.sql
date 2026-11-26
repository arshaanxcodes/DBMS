USE railway_db;

EXPLAIN
SELECT booking_id, pnr_number, passenger_name, train_number, journey_date, fare
FROM railway_bookings
WHERE journey_date = '2025-03-15';

EXPLAIN ANALYZE
SELECT booking_id, pnr_number, passenger_name, train_number, journey_date, fare
FROM railway_bookings
WHERE journey_date = '2025-03-15';

EXPLAIN
SELECT booking_id, pnr_number, passenger_name, coach_class, booking_status
FROM railway_bookings
WHERE train_number = '12951';

EXPLAIN ANALYZE
SELECT booking_id, pnr_number, passenger_name, coach_class, booking_status
FROM railway_bookings
WHERE train_number = '12951';

EXPLAIN
SELECT booking_id, pnr_number, train_number, coach_class, fare
FROM railway_bookings
WHERE source_station = 'NDLS'
  AND destination_station = 'SBC'
  AND journey_date = '2025-03-15';

EXPLAIN ANALYZE
SELECT booking_id, pnr_number, train_number, coach_class, fare
FROM railway_bookings
WHERE source_station = 'NDLS'
  AND destination_station = 'SBC'
  AND journey_date = '2025-03-15';

EXPLAIN
SELECT COUNT(*) AS total_confirmed_3a
FROM railway_bookings
WHERE booking_status = 'CONFIRMED'
  AND coach_class = '3A';

EXPLAIN ANALYZE
SELECT COUNT(*) AS total_confirmed_3a
FROM railway_bookings
WHERE booking_status = 'CONFIRMED'
  AND coach_class = '3A';
