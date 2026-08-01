-- =======================================
-- Airline Reservation System Project
-- =======================================

-- 1. Create Database
CREATE DATABASE Airline_Reservation_System;
USE Airline_Reservation_System;

-- 2. Create Tables
-- Table 1: Airlines
CREATE TABLE Airlines (
    airline_id INT PRIMARY KEY,
    airline_name VARCHAR(100) NOT NULL,
    airline_code VARCHAR(10) UNIQUE NOT NULL,
    headquarters VARCHAR(100),
    contact_number VARCHAR(15),
    country VARCHAR(50),
    status ENUM('Active','Inactive') DEFAULT 'Active'
);
DESC Airlines;

-- Table 2: Airports
CREATE TABLE Airports (
    airport_id INT PRIMARY KEY,
    airport_name VARCHAR(100) NOT NULL,
    airport_code CHAR(3) UNIQUE NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    terminals INT
);
DESC Airports;

-- Table 3: Flights
CREATE TABLE Flights (
    flight_id INT PRIMARY KEY,
    airline_id INT,
    flight_number VARCHAR(10) UNIQUE NOT NULL,
    departure_airport INT,
    arrival_airport INT,
    departure_time DATETIME,
    arrival_time DATETIME,
    total_seats INT,
    fare DECIMAL(10,2),
    FOREIGN KEY (airline_id) REFERENCES Airlines(airline_id),
    FOREIGN KEY (departure_airport) REFERENCES Airports(airport_id),
    FOREIGN KEY (arrival_airport) REFERENCES Airports(airport_id)
);
DESC Flights;

-- Table 4: Passengers
CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender ENUM('Male','Female','Other'),
    date_of_birth DATE,
    passport_number VARCHAR(20) UNIQUE,
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    nationality VARCHAR(50)
);
DESC Passengers;

-- Table 5: Tickets
CREATE TABLE Tickets (
    ticket_id INT PRIMARY KEY,
    passenger_id INT,
    flight_id INT,
    booking_date DATETIME,
    seat_number VARCHAR(5),
    travel_class ENUM('Economy','Business','First'),
    ticket_price DECIMAL(10,2),
    booking_status ENUM('Confirmed','Cancelled','Pending') DEFAULT 'Pending',
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);
DESC Tickets;

-- Table 6: Crew
CREATE TABLE Crew (
    crew_id INT PRIMARY KEY,
    flight_id INT,
    crew_name VARCHAR(100),
    role ENUM('Pilot','Co-Pilot','Cabin Crew'),
    experience_years INT,
    contact_number VARCHAR(15),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);
DESC Crew;

-- Table 7: Flight_Status
CREATE TABLE Flight_Status (
    status_id INT PRIMARY KEY,
    flight_id INT,
    scheduled_departure DATETIME,
    actual_departure DATETIME,
    scheduled_arrival DATETIME,
    actual_arrival DATETIME,
    flight_status ENUM(
        'Scheduled',
        'Boarding',
        'Departed',
        'Delayed',
        'Landed',
        'Cancelled'
    ),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);
DESC Flight_Status;

-- Table 8: Delays
CREATE TABLE Delays (
    delay_id INT PRIMARY KEY,
    flight_id INT,
    delay_minutes INT,
    delay_reason VARCHAR(100),
    reported_time DATETIME,
    compensation_required ENUM('Yes','No'),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);
DESC Delays;

-- Table 9: Payments
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    ticket_id INT,
    payment_date DATETIME,
    payment_method ENUM(
        'UPI',
        'Credit Card',
        'Debit Card',
        'Net Banking'
    ),
    amount DECIMAL(10,2),
    payment_status ENUM(
        'Success',
        'Failed',
        'Refunded'
    ),
    FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id)
);
DESC Payments;

-- Table 10: Baggage
CREATE TABLE Baggage (
    baggage_id INT PRIMARY KEY,
    ticket_id INT,
    weight DECIMAL(5,2),
    baggage_type ENUM(
        'Cabin',
        'Checked-in'
    ),
    extra_charge DECIMAL(10,2),
    FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id)
);
DESC Baggage;
show tables;

-- 3. Insert Data
INSERT INTO Airlines
(airline_id, airline_name, airline_code, headquarters, contact_number, country, status)
VALUES
(101, 'Air India', 'AI', 'New Delhi', '01123456789', 'India', 'Active'),
(102, 'IndiGo', '6E', 'Gurugram', '01244567890', 'India', 'Active'),
(103, 'Akasa Air', 'QP', 'Mumbai', '02234567891', 'India', 'Active'),
(104, 'SpiceJet', 'SG', 'Gurugram', '01245678901', 'India', 'Active'),
(105, 'Air India Express', 'IX', 'Kochi', '04842345678', 'India', 'Active'),
(106, 'Alliance Air', '9I', 'New Delhi', '01122334455', 'India', 'Active'),
(107, 'Star Air', 'S5', 'Bengaluru', '08023456789', 'India', 'Active'),
(108, 'Fly91', 'FY', 'Goa', '08322456789', 'India', 'Active'),
(109, 'Blue Dart Aviation', 'BZ', 'Chennai', '04423456789', 'India', 'Inactive'),
(110, 'TruJet', '2T', 'Hyderabad', '04023456789', 'India', 'Inactive');
SELECT * FROM Airlines;
INSERT INTO Airports
(airport_id, airport_name, airport_code, city, state, country, terminals)
VALUES
(201, 'Chhatrapati Shivaji Maharaj International Airport', 'BOM', 'Mumbai', 'Maharashtra', 'India', 2),
(202, 'Indira Gandhi International Airport', 'DEL', 'New Delhi', 'Delhi', 'India', 3),
(203, 'Kempegowda International Airport', 'BLR', 'Bengaluru', 'Karnataka', 'India', 2),
(204, 'Rajiv Gandhi International Airport', 'HYD', 'Hyderabad', 'Telangana', 'India', 1),
(205, 'Chennai International Airport', 'MAA', 'Chennai', 'Tamil Nadu', 'India', 2),
(206, 'Netaji Subhas Chandra Bose International Airport', 'CCU', 'Kolkata', 'West Bengal', 'India', 2),
(207, 'Pune Airport', 'PNQ', 'Pune', 'Maharashtra', 'India', 1),
(208, 'Sardar Vallabhbhai Patel International Airport', 'AMD', 'Ahmedabad', 'Gujarat', 'India', 2),
(209, 'Cochin International Airport', 'COK', 'Kochi', 'Kerala', 'India', 1),
(210, 'Manohar International Airport', 'GOX', 'Goa', 'Goa', 'India', 1);
SELECT * FROM Airports;
INSERT INTO Flights
(flight_id, airline_id, flight_number, departure_airport, arrival_airport,
departure_time, arrival_time, total_seats, fare)
VALUES
(301, 101, 'AI101', 201, 202, '2026-07-15 08:00:00', '2026-07-15 10:15:00', 180, 6500.00),
(302, 102, '6E205', 202, 203, '2026-07-15 09:30:00', '2026-07-15 12:00:00', 186, 5200.00),
(303, 103, 'QP310', 203, 204, '2026-07-15 11:00:00', '2026-07-15 12:30:00', 180, 4800.00),
(304, 104, 'SG415', 204, 205, '2026-07-15 13:00:00', '2026-07-15 14:20:00', 189, 4300.00),
(305, 105, 'IX520', 205, 206, '2026-07-15 15:00:00', '2026-07-15 17:20:00', 180, 5900.00),
(306, 106, '9I625', 206, 207, '2026-07-15 18:00:00', '2026-07-15 20:30:00', 72, 4500.00),
(307, 107, 'S5701', 207, 208, '2026-07-16 07:30:00', '2026-07-16 09:00:00', 76, 3900.00),
(308, 108, 'FY810', 208, 209, '2026-07-16 10:00:00', '2026-07-16 12:15:00', 180, 5400.00),
(309, 109, 'BZ915', 209, 210, '2026-07-16 14:00:00', '2026-07-16 15:30:00', 60, 3700.00),
(310, 110, '2T999', 210, 201, '2026-07-16 17:00:00', '2026-07-16 18:20:00', 72, 4100.00);
SELECT * FROM Flights;
INSERT INTO Passengers
(passenger_id, first_name, last_name, gender, date_of_birth, passport_number, phone, email, nationality)
VALUES
(401, 'Rahul', 'Sharma', 'Male', '1998-05-12', 'P1234567', '9876543210', 'rahul.sharma@gmail.com', 'Indian'),
(402, 'Priya', 'Patel', 'Female', '1999-08-25', 'P1234568', '9876543211', 'priya.patel@gmail.com', 'Indian'),
(403, 'Amit', 'Verma', 'Male', '1995-11-18', 'P1234569', '9876543212', 'amit.verma@gmail.com', 'Indian'),
(404, 'Sneha', 'Iyer', 'Female', '2000-02-10', 'P1234570', '9876543213', 'sneha.iyer@gmail.com', 'Indian'),
(405, 'Rohan', 'Kulkarni', 'Male', '1997-09-03', 'P1234571', '9876543214', 'rohan.kulkarni@gmail.com', 'Indian'),
(406, 'Ananya', 'Reddy', 'Female', '2001-01-15', 'P1234572', '9876543215', 'ananya.reddy@gmail.com', 'Indian'),
(407, 'Karan', 'Mehta', 'Male', '1996-07-22', 'P1234573', '9876543216', 'karan.mehta@gmail.com', 'Indian'),
(408, 'Neha', 'Joshi', 'Female', '1998-12-05', 'P1234574', '9876543217', 'neha.joshi@gmail.com', 'Indian'),
(409, 'Arjun', 'Nair', 'Male', '1994-04-28', 'P1234575', '9876543218', 'arjun.nair@gmail.com', 'Indian'),
(410, 'Meera', 'Singh', 'Female', '2002-06-30', 'P1234576', '9876543219', 'meera.singh@gmail.com', 'Indian');
SELECT * FROM Passengers;
INSERT INTO Tickets
(ticket_id, passenger_id, flight_id, booking_date, seat_number, travel_class, ticket_price, booking_status)
VALUES
(501, 401, 301, '2026-07-10 10:15:00', '12A', 'Economy', 6500.00, 'Confirmed'),
(502, 402, 302, '2026-07-10 11:20:00', '08C', 'Business', 5200.00, 'Confirmed'),
(503, 403, 303, '2026-07-11 09:45:00', '15F', 'Economy', 4800.00, 'Confirmed'),
(504, 404, 304, '2026-07-11 14:10:00', '03A', 'First', 4300.00, 'Confirmed'),
(505, 405, 305, '2026-07-12 08:30:00', '18D', 'Economy', 5900.00, 'Pending'),
(506, 406, 306, '2026-07-12 16:00:00', '06B', 'Business', 4500.00, 'Confirmed'),
(507, 407, 307, '2026-07-13 12:25:00', '20E', 'Economy', 3900.00, 'Cancelled'),
(508, 408, 308, '2026-07-13 18:40:00', '09A', 'Business', 5400.00, 'Confirmed'),
(509, 409, 309, '2026-07-14 09:10:00', '14C', 'Economy', 3700.00, 'Confirmed'),
(510, 410, 310, '2026-07-14 15:55:00', '02F', 'First', 4100.00, 'Pending');
SELECT * FROM Tickets;
INSERT INTO Crew
(crew_id, flight_id, crew_name, role, experience_years, contact_number)
VALUES
(601, 301, 'Captain Rajesh Kumar', 'Pilot', 15, '9810011111'),
(602, 302, 'Anita Sharma', 'Cabin Crew', 8, '9810011112'),
(603, 303, 'Captain Vikram Singh', 'Pilot', 12, '9810011113'),
(604, 304, 'Rohit Mehta', 'Co-Pilot', 7, '9810011114'),
(605, 305, 'Pooja Nair', 'Cabin Crew', 6, '9810011115'),
(606, 306, 'Captain Arjun Rao', 'Pilot', 18, '9810011116'),
(607, 307, 'Neha Kapoor', 'Cabin Crew', 5, '9810011117'),
(608, 308, 'Captain Sanjay Patel', 'Pilot', 14, '9810011118'),
(609, 309, 'Karan Joshi', 'Co-Pilot', 9, '9810011119'),
(610, 310, 'Megha Iyer', 'Cabin Crew', 4, '9810011120');
SELECT * FROM Crew;
INSERT INTO Flight_Status
(status_id, flight_id, scheduled_departure, actual_departure,
scheduled_arrival, actual_arrival, flight_status)
VALUES
(701, 301, '2026-07-15 08:00:00', '2026-07-15 08:05:00',
 '2026-07-15 10:15:00', '2026-07-15 10:20:00', 'Landed'),
(702, 302, '2026-07-15 09:30:00', '2026-07-15 10:00:00',
 '2026-07-15 12:00:00', '2026-07-15 12:30:00', 'Delayed'),
(703, 303, '2026-07-15 11:00:00', NULL,
 '2026-07-15 12:30:00', NULL, 'Boarding'),
(704, 304, '2026-07-15 13:00:00', NULL,
 '2026-07-15 14:20:00', NULL, 'Scheduled'),
(705, 305, '2026-07-15 15:00:00', NULL,
 '2026-07-15 17:20:00', NULL, 'Cancelled'),
(706, 306, '2026-07-15 18:00:00', '2026-07-15 18:00:00',
 '2026-07-15 20:30:00', '2026-07-15 20:25:00', 'Landed'),
(707, 307, '2026-07-16 07:30:00', '2026-07-16 07:45:00',
 '2026-07-16 09:00:00', '2026-07-16 09:20:00', 'Delayed'),
(708, 308, '2026-07-16 10:00:00', '2026-07-16 10:00:00',
 '2026-07-16 12:15:00', NULL, 'Departed'),
(709, 309, '2026-07-16 14:00:00', NULL,
 '2026-07-16 15:30:00', NULL, 'Boarding'),
(710, 310, '2026-07-16 17:00:00', NULL,
 '2026-07-16 18:20:00', NULL, 'Scheduled');
 SELECT * FROM Flight_Status;
 INSERT INTO Delays
(delay_id, flight_id, delay_minutes, delay_reason, reported_time, compensation_required)
VALUES
(801, 302, 30, 'Bad Weather', '2026-07-15 09:45:00', 'No'),
(802, 307, 15, 'Air Traffic Congestion', '2026-07-16 07:35:00', 'No'),
(803, 305, 120, 'Technical Issue', '2026-07-15 14:30:00', 'Yes'),
(804, 301, 5, 'Late Boarding', '2026-07-15 08:02:00', 'No'),
(805, 306, 10, 'Crew Availability', '2026-07-15 17:50:00', 'No');
SELECT * FROM Delays;
INSERT INTO Payments
(payment_id, ticket_id, payment_date, payment_method, amount, payment_status)
VALUES
(901, 501, '2026-07-10 10:20:00', 'UPI', 6500.00, 'Success'),
(902, 502, '2026-07-10 11:25:00', 'Credit Card', 5200.00, 'Success'),
(903, 503, '2026-07-11 09:50:00', 'Debit Card', 4800.00, 'Success'),
(904, 504, '2026-07-11 14:15:00', 'Net Banking', 4300.00, 'Success'),
(905, 505, '2026-07-12 08:35:00', 'UPI', 5900.00, 'Failed'),
(906, 506, '2026-07-12 16:05:00', 'Credit Card', 4500.00, 'Success'),
(907, 507, '2026-07-13 12:30:00', 'Debit Card', 3900.00, 'Refunded'),
(908, 508, '2026-07-13 18:45:00', 'UPI', 5400.00, 'Success'),
(909, 509, '2026-07-14 09:15:00', 'Net Banking', 3700.00, 'Success'),
(910, 510, '2026-07-14 16:00:00', 'Credit Card', 4100.00, 'Failed');
SELECT * FROM Payments;
INSERT INTO Baggage
(baggage_id, ticket_id, weight, baggage_type, extra_charge)
VALUES
(1001, 501, 7.50, 'Cabin', 0.00),
(1002, 502, 22.00, 'Checked-in', 500.00),
(1003, 503, 6.80, 'Cabin', 0.00),
(1004, 504, 28.50, 'Checked-in', 1000.00),
(1005, 505, 19.00, 'Checked-in', 0.00),
(1006, 506, 7.20, 'Cabin', 0.00),
(1007, 507, 25.00, 'Checked-in', 800.00),
(1008, 508, 6.50, 'Cabin', 0.00),
(1009, 509, 21.50, 'Checked-in', 300.00),
(1010, 510, 7.00, 'Cabin', 0.00);
SELECT * FROM Baggage;

-- 4. Basic Queries
-- SELECT - Display all airline details.
SELECT * FROM Airlines;

-- Display the airline name and headquarters.
SELECT airline_name, headquarters FROM Airlines;

-- WHERE - Show all active airlines.
SELECT * FROM Airlines WHERE status = 'Active';

-- ORDER BY (Ascending) - Display passengers sorted by first name.
SELECT * FROM Passengers ORDER BY first_name ASC;

-- ORDER BY (Descending) - Show flights with the highest fare first.
SELECT * FROM Flights ORDER BY fare DESC;

-- LIMIT - Show the first 5 passengers.
SELECT * FROM Passengers LIMIT 5;

-- DISTINCT - Show all unique travel classes.
SELECT DISTINCT travel_class FROM Tickets;

-- LIKE - Find passengers whose first name starts with 'A'.
SELECT * FROM Passengers WHERE first_name LIKE 'A%';

-- BETWEEN - Show flights with fares between ₹4000 and ₹6000.
SELECT * FROM Flights WHERE fare BETWEEN 4000 AND 6000;

-- IN - Show flights that are delayed and cancelled.
SELECT * FROM Flight_Status WHERE flight_status IN ('Delayed', 'Cancelled');

-- 5. Aggregate Functions
-- COUNT() - How many passengers are there?
SELECT COUNT(*) AS total_passengers FROM Passengers;

-- SUM() - Calculate the total revenue from successful payments.
SELECT SUM(amount) AS total_revenue FROM Payments WHERE payment_status = 'Success';

-- AVG() - Find the average ticket price.
SELECT AVG(ticket_price) AS average_ticket_price FROM Tickets;

-- MIN() - Find the cheapest flight.
SELECT MIN(fare) AS lowest_fare FROM Flights;

-- MAX() - Find the most expensive flight.
SELECT MAX(fare) AS highest_fare FROM Flights;

-- Count passengers by gender.
SELECT gender,
COUNT(*) AS total_passengers FROM Passengers GROUP BY gender;

-- Find revenue by payment method.
SELECT payment_method,
SUM(amount) AS total_revenue FROM Payments WHERE payment_status = 'Success' GROUP BY payment_method;

-- HAVING - Show travel classes with more than 2 bookings.
SELECT travel_class,
COUNT(*) AS total_bookings FROM Tickets GROUP BY travel_class HAVING COUNT(*) > 2;

-- 6. Window Functions
-- Assign a unique rank to passengers based on ticket price.(ROW_NUMBER())
SELECT
    CONCAT(p.first_name,' ',p.last_name) AS passenger_name,
    t.ticket_price,
    ROW_NUMBER() OVER(ORDER BY t.ticket_price DESC) AS Row_No
FROM Passengers p
INNER JOIN Tickets t
ON p.passenger_id=t.passenger_id;

-- Rank flights according to fare.(RANK())
SELECT
    flight_number,
    fare,
    RANK() OVER(ORDER BY fare DESC) AS Flight_Rank
FROM Flights;

-- Rank passengers according to ticket price.(DENSE_RANK())
SELECT
    CONCAT(p.first_name,' ',p.last_name) AS passenger_name,
    t.ticket_price,
    DENSE_RANK() OVER(ORDER BY t.ticket_price DESC) AS Passenger_Dense_Rank
FROM Passengers p
INNER JOIN Tickets t
ON p.passenger_id=t.passenger_id;

-- 7. JOINS
-- 1. Display passenger booking details with airline and flight information.(INNER JOIN)
SELECT
    p.passenger_id,
    CONCAT(p.first_name, ' ', p.last_name) AS passenger_name,
    a.airline_name,
    f.flight_number,
    t.seat_number,
    t.travel_class
FROM Passengers p
INNER JOIN Tickets t
    ON p.passenger_id = t.passenger_id
INNER JOIN Flights f
    ON t.flight_id = f.flight_id
INNER JOIN Airlines a
    ON f.airline_id = a.airline_id;

-- 2. Show departure and arrival airports for every flight.(JOIN)
SELECT
    f.flight_number,
    dep.airport_name AS departure_airport,
    arr.airport_name AS arrival_airport
FROM Flights f
JOIN Airports dep
ON f.departure_airport = dep.airport_id
JOIN Airports arr
ON f.arrival_airport = arr.airport_id;
    
-- 3. Display payment details of each passenger.(LEFT JOIN)
SELECT
    CONCAT(p.first_name, ' ', p.last_name) AS passenger_name,
    pay.payment_method,
    pay.amount,
    pay.payment_status
FROM Passengers p
INNER JOIN Tickets t
    ON p.passenger_id = t.passenger_id
LEFT JOIN Payments pay
    ON t.ticket_id = pay.ticket_id;
    
-- 4. Display delayed flights with airline name and delay reason.(RIGHT JOIN)
SELECT
    a.airline_name,
    f.flight_number,
    d.delay_minutes,
    d.delay_reason
FROM Delays d
RIGHT JOIN Flights f
    ON d.flight_id = f.flight_id
INNER JOIN Airlines a
    ON f.airline_id = a.airline_id;
    
-- 5. Which airline earned the highest revenue?(INNER JOIN + GROUP BY)
SELECT
    a.airline_name,
    SUM(pay.amount) AS total_revenue
FROM Airlines a
INNER JOIN Flights f
ON a.airline_id = f.airline_id
INNER JOIN Tickets t
ON f.flight_id = t.flight_id
INNER JOIN Payments pay
ON t.ticket_id = pay.ticket_id
WHERE pay.payment_status = 'Success'
GROUP BY a.airline_name
ORDER BY total_revenue DESC;

-- 8. SUBQUERIES
-- 1. Find passengers who paid more than the average payment amount.
SELECT *
FROM Passengers
WHERE passenger_id IN (
    SELECT t.passenger_id
    FROM Tickets t
    JOIN Payments p
        ON t.ticket_id = p.ticket_id
    WHERE p.amount > (
        SELECT AVG(amount)
        FROM Payments
    )
);

-- 2. Find the flight with the highest fare.
SELECT *
FROM Flights
WHERE fare = (
    SELECT MAX(fare)
    FROM Flights
);

-- 3. Find passengers whose baggage weight is greater than the average baggage weight.
SELECT
    CONCAT(p.first_name," ",p.last_name) as passenger_name
FROM Passengers p
JOIN Tickets t
    ON p.passenger_id = t.passenger_id
JOIN Baggage b
    ON t.ticket_id = b.ticket_id
WHERE b.weight > (
    SELECT AVG(weight)
    FROM Baggage
);

-- 4. Which airline has the highest-priced flight?
SELECT airline_name
FROM Airlines
WHERE airline_id = (
    SELECT airline_id
    FROM Flights
    WHERE fare = (
        SELECT MAX(fare)
        FROM Flights
    )
);

-- 5. Find passengers whose ticket price is greater than the average ticket price.
SELECT
    CONCAT(p.first_name," ",p.last_name) as passenger_name,
    t.ticket_price
FROM Passengers p
JOIN Tickets t
    ON p.passenger_id = t.passenger_id
WHERE t.ticket_price > (
    SELECT AVG(ticket_price)
    FROM Tickets
);

-- 9. VIEWS
-- View 1: Create a view to display complete passenger booking details.
CREATE VIEW Passenger_Booking_Details AS
SELECT
    CONCAT(p.first_name, ' ', p.last_name) AS passenger_name,
    a.airline_name,
    f.flight_number,
    t.travel_class,
    t.booking_status
FROM Passengers p
INNER JOIN Tickets t
    ON p.passenger_id = t.passenger_id
INNER JOIN Flights f
    ON t.flight_id = f.flight_id
INNER JOIN Airlines a
    ON f.airline_id = a.airline_id;

SELECT * FROM Passenger_Booking_Details;

-- View 2: Create a view to display the total successful revenue generated by each airline.
CREATE VIEW Airline_Revenue_Report AS
SELECT
    a.airline_name,
    SUM(pay.amount) AS total_revenue
FROM Airlines a
INNER JOIN Flights f
ON a.airline_id = f.airline_id
INNER JOIN Tickets t
ON f.flight_id = t.flight_id
INNER JOIN Payments pay
ON t.ticket_id = pay.ticket_id
WHERE pay.payment_status = 'Success'
GROUP BY a.airline_name;

SELECT * FROM Airline_Revenue_Report;

-- View 3: Create a view to display delayed flights with airline name and delay reason.
CREATE VIEW Flight_Delay_Report AS
SELECT
    a.airline_name,
    f.flight_number,
    d.delay_minutes,
    d.delay_reason
FROM Delays d
INNER JOIN Flights f
ON d.flight_id = f.flight_id
INNER JOIN Airlines a
ON f.airline_id = a.airline_id;

SELECT * FROM Flight_Delay_Report;