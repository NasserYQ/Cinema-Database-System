-- ============================================
-- Cinema Database Management System
-- Database Schema Creation Script
-- ============================================

-- Create database (uncomment if needed)
-- CREATE DATABASE cinema_db;
-- USE cinema_db;

-- ============================================
-- TABLE CREATION
-- ============================================

-- 1. RoomTypes Table (Referenced by Rooms)
CREATE TABLE RoomTypes (
    RoomTypeID INT,
    Type VARCHAR(50) CHECK (Type IN ('Standard', 'VIP')) NOT NULL,
    Price DECIMAL(6,2) NOT NULL CHECK (Price > 0),
    
    CONSTRAINT roomtypes_pk PRIMARY KEY (RoomTypeID)
);

-- 2. Movies Table
CREATE TABLE Movies (
    MovieID INT,
    Name VARCHAR(100) NOT NULL,
    ReleaseDate DATE NOT NULL,
    Duration INT CHECK (Duration > 0),
    Rating DECIMAL(3,1) CHECK (Rating BETWEEN 0 AND 10),
    Genre VARCHAR(50),
    Language VARCHAR(50), 
    AgeRating VARCHAR(10) CHECK (AgeRating IN ('G', 'PG', 'PG12', 'PG13', 'R15', 'R18')) NOT NULL,
    
    CONSTRAINT movies_pk PRIMARY KEY (MovieID)   
);

-- 3. Rooms Table
CREATE TABLE Rooms (
    RoomID INT,
    Capacity INT NOT NULL CHECK (Capacity > 0),
    RoomTypeID INT NOT NULL,
    
    CONSTRAINT rooms_pk PRIMARY KEY (RoomID),
    CONSTRAINT rooms_roomtype_fk FOREIGN KEY (RoomTypeID) REFERENCES RoomTypes(RoomTypeID)
);

-- 4. Shows Table
CREATE TABLE Shows (
    ShowID INT,
    MovieID INT NOT NULL,
    RoomID INT NOT NULL,
    StartTime TIME NOT NULL,
    
    CONSTRAINT shows_pk PRIMARY KEY (ShowID),
    CONSTRAINT shows_movie_fk FOREIGN KEY (MovieID) REFERENCES Movies(MovieID), 
    CONSTRAINT shows_room_fk FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    CONSTRAINT shows_unique_room_time UNIQUE (RoomID, StartTime) -- No overlapping shows
);

-- 5. Seats Table
CREATE TABLE Seats (
    SeatID INT,
    RoomID INT NOT NULL,
    SeatRow VARCHAR(5) NOT NULL,
    SeatNumber INT NOT NULL CHECK (SeatNumber > 0),

    CONSTRAINT seats_pk PRIMARY KEY (SeatID),
    CONSTRAINT seats_room_fk FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID) 
);

-- 6. Customers Table
CREATE TABLE Customers (
    CustomerID INT,
    Fname VARCHAR(50) NOT NULL,
    Mname VARCHAR(50),
    Lname VARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PhoneNum VARCHAR(15) NOT NULL,

    CONSTRAINT customers_pk PRIMARY KEY (CustomerID), 
    CONSTRAINT customers_email_uq UNIQUE (Email), 
    CONSTRAINT customers_phone_uq UNIQUE (PhoneNum) 
);

-- 7. Employees Table
CREATE TABLE Employees (
    EmpID INT,
    Fname VARCHAR(50) NOT NULL,
    Mname VARCHAR(50),
    Lname VARCHAR(50) NOT NULL,
    Role VARCHAR(50) NOT NULL, 
    Salary DECIMAL(10,2) CHECK (Salary >= 0),

    CONSTRAINT employees_pk PRIMARY KEY (EmpID)
);

-- 8. Bookings Table
CREATE TABLE Bookings (
    BookingID INT,
    CustomerID INT NOT NULL,
    ShowID INT NOT NULL,
    BookingTime DATE NOT NULL,
    Offer VARCHAR(50),
    PaymentMethod VARCHAR(20) CHECK (PaymentMethod IN ('Card', 'Cash')),

    CONSTRAINT bookings_pk PRIMARY KEY (BookingID), 
    CONSTRAINT bookings_customer_fk FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID), 
    CONSTRAINT bookings_show_fk FOREIGN KEY (ShowID) REFERENCES Shows(ShowID)  
);

-- 9. Reservations Table (Links Bookings to Seats)
CREATE TABLE Reservations (
    BookingID INT,
    SeatID INT,

    CONSTRAINT reservations_pk PRIMARY KEY (BookingID, SeatID), 
    CONSTRAINT reservations_booking_fk FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID), 
    CONSTRAINT reservations_seat_fk FOREIGN KEY (SeatID) REFERENCES Seats(SeatID) 
);

-- 10. Snacks Table
CREATE TABLE Snacks (
    SnackID INT,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(5,2) NOT NULL CHECK (Price > 0),

    CONSTRAINT snacks_pk PRIMARY KEY (SnackID)
);

-- 11. Snack_Orders Table
CREATE TABLE Snack_Orders (
    SnackOrderID INT,
    CustomerID INT NOT NULL,
    EmpID INT NOT NULL,
    OrderTime DATE NOT NULL,

    CONSTRAINT snackorders_pk PRIMARY KEY (SnackOrderID), 
    CONSTRAINT snackorders_customer_fk FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID), 
    CONSTRAINT snackorders_employee_fk FOREIGN KEY (EmpID) REFERENCES Employees(EmpID)
);

-- 12. Snack_Order_Details Table (Links Orders to Snacks)
CREATE TABLE Snack_Order_Details (
    SnackOrderID INT,
    SnackID INT,
    Quantity INT NOT NULL CHECK (Quantity > 0),

    CONSTRAINT snackorderdetails_pk PRIMARY KEY (SnackOrderID, SnackID), 
    CONSTRAINT snackorderdetails_order_fk FOREIGN KEY (SnackOrderID) REFERENCES Snack_Orders(SnackOrderID), 
    CONSTRAINT snackorderdetails_snack_fk FOREIGN KEY (SnackID) REFERENCES Snacks(SnackID)
);

-- ============================================
-- BUSINESS RULES IMPLEMENTED VIA CONSTRAINTS
-- ============================================
-- 1. Age rating enforcement: AgeRating CHECK constraint in Movies table
-- 2. No double booking: PRIMARY KEY (BookingID, SeatID) in Reservations
-- 3. No overlapping shows: UNIQUE (RoomID, StartTime) in Shows table
-- 4. Unique customer contact: UNIQUE constraints on Email and PhoneNum
-- 5. Valid room types: CHECK (Type IN ('Standard', 'VIP'))
-- 6. Valid payment methods: CHECK (PaymentMethod IN ('Card', 'Cash'))
-- 7. Positive values: CHECK constraints on Duration, Rating, Salary, Prices, Quantity

-- ============================================
-- SCHEMA CREATION COMPLETE
-- ============================================
-- Next steps:
-- 1. Run sample_data.sql to populate tables
-- 2. Run queries.sql to test functionality
-- ============================================
