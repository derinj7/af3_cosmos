-- Snowflake Setup Script for dbt Snowflake Demo Project
-- This script creates the necessary database structure and sample data
-- to run the dbt models in this project.

-- =================================================================
-- DATABASE AND SCHEMA SETUP
-- =================================================================

-- Create the database
CREATE DATABASE IF NOT EXISTS SAMPLE_DB;

-- Create the schema for raw data
CREATE SCHEMA IF NOT EXISTS SAMPLE_DB.RAW;

-- Create the schema for analytics/dbt models
CREATE SCHEMA IF NOT EXISTS SAMPLE_DB.ANALYTICS;

-- Use the database
USE DATABASE SAMPLE_DB;

-- =================================================================
-- SOURCE DATA SETUP
-- =================================================================

-- Use the RAW schema for source data
USE SCHEMA RAW;

-- Create the orders table in RAW schema
CREATE TABLE IF NOT EXISTS SAMPLE_DB.RAW.orders (
    order_id INTEGER,
    customer_id INTEGER,
    order_amount DECIMAL(12,2),
    order_date DATE
);

-- Insert sample orders data
INSERT INTO SAMPLE_DB.RAW.orders (order_id, customer_id, order_amount, order_date) VALUES
(1, 101, 25.50, '2024-01-15'),
(2, 102, 67.25, '2024-01-16'),
(3, 103, 45.00, '2024-01-17'),
(4, 101, 32.75, '2024-01-18'),
(5, 104, 89.99, '2024-01-19'),
(6, 102, 156.50, '2024-01-20'),
(7, 105, 23.99, '2024-01-21'),
(8, 103, 78.25, '2024-01-22'),
(9, 106, 41.50, '2024-01-23'),
(10, 104, 92.00, '2024-01-24');

-- Create customers table in RAW schema (optional - for future use)
CREATE TABLE IF NOT EXISTS SAMPLE_DB.RAW.customers (
    customer_id INTEGER IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    date_of_birth DATE,
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    country VARCHAR(100) DEFAULT 'USA',
    customer_status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP(),
    updated_at TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Insert sample customer data
INSERT INTO SAMPLE_DB.RAW.customers (
    first_name, 
    last_name, 
    email, 
    phone, 
    date_of_birth,
    address_line1, 
    city, 
    state, 
    postal_code,
    country,
    customer_status
) VALUES
    ('John', 'Doe', 'john.doe@email.com', '555-0101', '1985-03-15', '123 Main St', 'San Francisco', 'CA', '94105', 'USA', 'ACTIVE'),
    ('Jane', 'Smith', 'jane.smith@email.com', '555-0102', '1990-07-22', '456 Oak Ave', 'Los Angeles', 'CA', '90001', 'USA', 'ACTIVE'),
    ('Robert', 'Johnson', 'robert.j@email.com', '555-0103', '1978-11-30', '789 Pine Rd', 'Seattle', 'WA', '98101', 'USA', 'ACTIVE'),
    ('Maria', 'Garcia', 'maria.garcia@email.com', '555-0104', '1992-05-18', '321 Elm St', 'Austin', 'TX', '78701', 'USA', 'ACTIVE'),
    ('David', 'Brown', 'david.brown@email.com', '555-0105', '1988-09-10', '654 Maple Dr', 'Denver', 'CO', '80201', 'USA', 'INACTIVE'),
    ('Sarah', 'Wilson', 'sarah.w@email.com', '555-0106', '1995-12-25', '987 Cedar Ln', 'Portland', 'OR', '97201', 'USA', 'ACTIVE'),
    ('Michael', 'Taylor', 'michael.taylor@email.com', '555-0107', '1982-04-08', '147 Birch Blvd', 'Chicago', 'IL', '60601', 'USA', 'ACTIVE'),
    ('Lisa', 'Anderson', 'lisa.anderson@email.com', '555-0108', '1991-08-14', '258 Spruce Way', 'Boston', 'MA', '02101', 'USA', 'ACTIVE'),
    ('James', 'Thomas', 'james.t@email.com', '555-0109', '1986-02-28', '369 Willow St', 'Phoenix', 'AZ', '85001', 'USA', 'ACTIVE'),
    ('Emma', 'Martinez', 'emma.martinez@email.com', '555-0110', '1993-10-05', '741 Ash Ave', 'Miami', 'FL', '33101', 'USA', 'ACTIVE');

-- =================================================================
-- VERIFICATION QUERIES
-- =================================================================

-- Check source data in RAW schema
SELECT * FROM SAMPLE_DB.RAW.orders;
SELECT * FROM SAMPLE_DB.RAW.customers;

-- =================================================================
-- POST-DBT RUN VERIFICATION QUERIES
-- =================================================================
-- After running dbt, use these queries to verify the analytics tables

-- SELECT * FROM SAMPLE_DB.ANALYTICS.stg_orders;
-- SELECT * FROM SAMPLE_DB.ANALYTICS.fct_orders;
-- SELECT * FROM SAMPLE_DB.ANALYTICS.my_first_dbt_model;
-- SELECT * FROM SAMPLE_DB.ANALYTICS.my_second_dbt_model;
