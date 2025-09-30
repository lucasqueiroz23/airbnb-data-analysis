CREATE SCHEMA IF NOT EXISTS silver;
DROP TABLE IF EXISTS silver.listings;
CREATE TABLE silver.listings (
    id BIGINT PRIMARY KEY NOT NULL, 
    host_id BIGINT NOT NULL,
    name TEXT,
    host_identity_verified BOOLEAN,
    host_name VARCHAR(255),
    neighbourhood_group VARCHAR(255),
    neighbourhood VARCHAR(255),
    lat NUMERIC(10, 7),
    long NUMERIC(10, 7), 
    instant_bookable BOOLEAN,
    cancellation_policy VARCHAR(100),
    room_type VARCHAR(100),
    construction_year INTEGER,
    price NUMERIC(10, 2),
    service_fee NUMERIC(10, 2),
    minimum_nights INTEGER,
    number_of_reviews INTEGER,
    last_review DATE,
    reviews_per_month NUMERIC(5, 2),
    review_rate_number NUMERIC(10, 2),
    calculated_host_listings_count INTEGER,
    availability_365 INTEGER,
    house_rules TEXT,
    has_house_rules BOOLEAN
);

