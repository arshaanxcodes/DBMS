USE railway_db;

CREATE INDEX idx_journey_date ON railway_bookings (journey_date);
CREATE INDEX idx_train_number ON railway_bookings (train_number);
CREATE INDEX idx_route_date ON railway_bookings (source_station, destination_station, journey_date);
CREATE INDEX idx_status_class ON railway_bookings (booking_status, coach_class);

SHOW INDEX FROM railway_bookings;
