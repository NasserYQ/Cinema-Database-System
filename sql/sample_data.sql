-- ============================================
-- Cinema Database Management System
-- Sample Data for Testing
-- ============================================
-- This file contains sample data to populate all tables
-- for testing and demonstration purposes
-- ============================================

-- Clear existing data (optional - use with caution)
-- DELETE FROM Snack_Order_Details;
-- DELETE FROM Snack_Orders;
-- DELETE FROM Reservations;
-- DELETE FROM Bookings;
-- DELETE FROM Snacks;
-- DELETE FROM Shows;
-- DELETE FROM Seats;
-- DELETE FROM Rooms;
-- DELETE FROM RoomTypes;
-- DELETE FROM Movies;
-- DELETE FROM Customers;
-- DELETE FROM Employees;

-- ============================================
-- 1. Insert Room Types
-- ============================================
INSERT INTO RoomTypes (RoomTypeID, Type, Price) VALUES
(1, 'Standard', 50.00),
(2, 'VIP', 100.00);

-- ============================================
-- 2. Insert Movies
-- ============================================
INSERT INTO Movies (MovieID, Name, ReleaseDate, Duration, Rating, Genre, Language, AgeRating) VALUES
(1, 'The Dark Knight', '2008-07-18', 152, 9.0, 'Action', 'English', 'PG13'),
(2, 'Inception', '2010-07-16', 148, 8.8, 'Sci-Fi', 'English', 'PG13'),
(3, 'Toy Story 4', '2019-06-21', 100, 7.7, 'Animation', 'English', 'G'),
(4, 'Interstellar', '2014-11-07', 169, 8.6, 'Sci-Fi', 'English', 'PG13'),
(5, 'The Lion King', '2019-07-19', 118, 6.8, 'Animation', 'English', 'PG'),
(6, 'Joker', '2019-10-04', 122, 8.4, 'Drama', 'English', 'R15');

-- ============================================
-- 3. Insert Rooms
-- ============================================
INSERT INTO Rooms (RoomID, Capacity, RoomTypeID) VALUES
(1, 100, 1),  -- Standard Room
(2, 80, 1),   -- Standard Room
(3, 50, 2);   -- VIP Room

-- ============================================
-- 4. Insert Seats (Sample for Room 1)
-- ============================================
-- Row A (seats 1-10)
INSERT INTO Seats (SeatID, RoomID, SeatRow, SeatNumber) VALUES
(1, 1, 'A', 1), (2, 1, 'A', 2), (3, 1, 'A', 3), (4, 1, 'A', 4), (5, 1, 'A', 5),
(6, 1, 'A', 6), (7, 1, 'A', 7), (8, 1, 'A', 8), (9, 1, 'A', 9), (10, 1, 'A', 10);

-- Row B (seats 1-10)
INSERT INTO Seats (SeatID, RoomID, SeatRow, SeatNumber) VALUES
(11, 1, 'B', 1), (12, 1, 'B', 2), (13, 1, 'B', 3), (14, 1, 'B', 4), (15, 1, 'B', 5),
(16, 1, 'B', 6), (17, 1, 'B', 7), (18, 1, 'B', 8), (19, 1, 'B', 9), (20, 1, 'B', 10);

-- Sample seats for Room 2
INSERT INTO Seats (SeatID, RoomID, SeatRow, SeatNumber) VALUES
(21, 2, 'A', 1), (22, 2, 'A', 2), (23, 2, 'A', 3), (24, 2, 'A', 4), (25, 2, 'A', 5),
(26, 2, 'B', 1), (27, 2, 'B', 2), (28, 2, 'B', 3), (29, 2, 'B', 4), (30, 2, 'B', 5);

-- Sample seats for Room 3 (VIP)
INSERT INTO Seats (SeatID, RoomID, SeatRow, SeatNumber) VALUES
(31, 3, 'A', 1), (32, 3, 'A', 2), (33, 3, 'A', 3), (34, 3, 'A', 4), (35, 3, 'A', 5),
(36, 3, 'B', 1), (37, 3, 'B', 2), (38, 3, 'B', 3), (39, 3, 'B', 4), (40, 3, 'B', 5);

-- ============================================
-- 5. Insert Shows
-- ============================================
INSERT INTO Shows (ShowID, MovieID, RoomID, StartTime) VALUES
(1, 1, 1, '14:00:00'),  -- Dark Knight in Room 1 at 2 PM
(2, 2, 2, '14:00:00'),  -- Inception in Room 2 at 2 PM
(3, 3, 1, '17:00:00'),  -- Toy Story in Room 1 at 5 PM
(4, 4, 3, '19:00:00'),  -- Interstellar in VIP Room at 7 PM
(5, 5, 2, '17:30:00'),  -- Lion King in Room 2 at 5:30 PM
(6, 6, 3, '22:00:00');  -- Joker in VIP Room at 10 PM

-- ============================================
-- 6. Insert Customers
-- ============================================
INSERT INTO Customers (CustomerID, Fname, Mname, Lname, BirthDate, Email, PhoneNum) VALUES
(1, 'Ahmed', 'Mohammed', 'Ali', '1995-05-15', 'ahmed.ali@email.com', '0501234567'),
(2, 'Sara', 'Abdullah', 'Hassan', '1998-08-22', 'sara.hassan@email.com', '0509876543'),
(3, 'Omar', 'Khalid', 'Ibrahim', '2000-03-10', 'omar.ibrahim@email.com', '0551122334'),
(4, 'Fatima', 'Salem', 'Ahmed', '1997-12-05', 'fatima.ahmed@email.com', '0556677889'),
(5, 'Khalid', 'Nasser', 'Mohammed', '1999-07-18', 'khalid.mohammed@email.com', '0544332211');

-- ============================================
-- 7. Insert Employees
-- ============================================
INSERT INTO Employees (EmpID, Fname, Mname, Lname, Role, Salary) VALUES
(1, 'Mohammed', 'Ali', 'Hassan', 'Manager', 8000.00),
(2, 'Aisha', 'Abdullah', 'Salem', 'Cashier', 4000.00),
(3, 'Yousef', 'Ibrahim', 'Khalid', 'Cinema Operator', 4500.00),
(4, 'Nora', 'Mohammed', 'Ali', 'Cashier', 4000.00),
(5, 'Saad', 'Hassan', 'Ahmed', 'Maintenance', 3500.00);

-- ============================================
-- 8. Insert Bookings
-- ============================================
INSERT INTO Bookings (BookingID, CustomerID, ShowID, BookingTime, Offer, PaymentMethod) VALUES
(1, 1, 1, '2024-02-01', NULL, 'Card'),
(2, 2, 2, '2024-02-01', 'Student Discount', 'Cash'),
(3, 3, 4, '2024-02-02', NULL, 'Card'),
(4, 4, 3, '2024-02-02', 'Family Package', 'Card'),
(5, 5, 5, '2024-02-03', NULL, 'Cash');

-- ============================================
-- 9. Insert Reservations (Seat Assignments)
-- ============================================
INSERT INTO Reservations (BookingID, SeatID) VALUES
-- Booking 1: Customer 1, Show 1 (Dark Knight), Seats A1, A2
(1, 1), (1, 2),
-- Booking 2: Customer 2, Show 2 (Inception), Seats A1, A2
(2, 21), (2, 22),
-- Booking 3: Customer 3, Show 4 (Interstellar VIP), Seats A1, A2
(3, 31), (3, 32),
-- Booking 4: Customer 4, Show 3 (Toy Story), Seats B1, B2, B3, B4
(4, 11), (4, 12), (4, 13), (4, 14),
-- Booking 5: Customer 5, Show 5 (Lion King), Seats A3, A4
(5, 23), (5, 24);

-- ============================================
-- 10. Insert Snacks
-- ============================================
INSERT INTO Snacks (SnackID, Name, Price) VALUES
(1, 'Small Popcorn', 15.00),
(2, 'Medium Popcorn', 20.00),
(3, 'Large Popcorn', 25.00),
(4, 'Soft Drink', 10.00),
(5, 'Nachos', 18.00),
(6, 'Candy Bar', 8.00),
(7, 'Hot Dog', 22.00),
(8, 'Ice Cream', 12.00);

-- ============================================
-- 11. Insert Snack Orders
-- ============================================
INSERT INTO Snack_Orders (SnackOrderID, CustomerID, EmpID, OrderTime) VALUES
(1, 1, 2, '2024-02-01'),
(2, 2, 4, '2024-02-01'),
(3, 3, 2, '2024-02-02'),
(4, 4, 4, '2024-02-02'),
(5, 5, 2, '2024-02-03');

-- ============================================
-- 12. Insert Snack Order Details
-- ============================================
INSERT INTO Snack_Order_Details (SnackOrderID, SnackID, Quantity) VALUES
-- Order 1: 2 Medium Popcorn, 2 Soft Drinks
(1, 2, 2), (1, 4, 2),
-- Order 2: 1 Large Popcorn, 1 Soft Drink, 1 Candy
(2, 3, 1), (2, 4, 1), (2, 6, 1),
-- Order 3: 2 Nachos, 2 Soft Drinks
(3, 5, 2), (3, 4, 2),
-- Order 4: 4 Small Popcorn, 4 Soft Drinks (Family package)
(4, 1, 4), (4, 4, 4),
-- Order 5: 2 Hot Dogs, 2 Ice Creams
(5, 7, 2), (5, 8, 2);

-- ============================================
-- DATA INSERTION COMPLETE
-- ============================================
-- You can now run queries.sql to test the database
-- ============================================
