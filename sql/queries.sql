-- ============================================
-- Cinema Database Management System
-- Sample Queries
-- ============================================
-- This file contains pre-built queries for common
-- cinema management operations
-- ============================================

-- ============================================
-- QUERY 1: List of Available Movies and Showtimes
-- ============================================
-- Description: Display all available movies along with their 
-- genre, age rating, showtime, and the room they are scheduled in.

SELECT 
    M.Name AS MovieName,
    M.Genre,
    M.AgeRating,
    S.StartTime AS Showtime,
    R.RoomID,
    RT.Type AS RoomType
FROM Movies M
JOIN Shows S ON M.MovieID = S.MovieID
JOIN Rooms R ON S.RoomID = R.RoomID
JOIN RoomTypes RT ON R.RoomTypeID = RT.RoomTypeID
ORDER BY S.StartTime;


-- ============================================
-- QUERY 2: Seat Selection Status for Each Show
-- ============================================
-- Description: Display all seats for each show, indicating 
-- whether each seat is available or already reserved.

SELECT 
    S.ShowID,
    SE.RoomID,
    SE.SeatID,
    SE.SeatRow,
    SE.SeatNumber,
    CASE 
        WHEN R.SeatID IS NOT NULL THEN 'Reserved'
        ELSE 'Available'
    END AS SeatStatus
FROM Shows S
JOIN Rooms RO ON S.RoomID = RO.RoomID
JOIN Seats SE ON SE.RoomID = RO.RoomID
LEFT JOIN Reservations R 
    ON R.SeatID = SE.SeatID AND R.BookingID IN (
        SELECT BookingID 
        FROM Bookings 
        WHERE ShowID = S.ShowID
    )
ORDER BY S.ShowID, SE.SeatRow, SE.SeatNumber;


-- ============================================
-- QUERY 3: Booking Confirmation Details
-- ============================================
-- Description: Show a customer's booking confirmation, including 
-- the movie name, showtime, seat, room type, and total cost.

SELECT 
    C.CustomerID,
    CONCAT(C.Fname, ' ', C.Lname) AS CustomerName,
    M.Name AS MovieName,
    S.StartTime AS Showtime,
    SE.SeatRow,
    SE.SeatNumber,
    RT.Type AS RoomType,
    RT.Price AS TicketPrice,
    B.PaymentMethod,
    B.Offer
FROM Bookings B
JOIN Customers C ON B.CustomerID = C.CustomerID
JOIN Shows S ON B.ShowID = S.ShowID
JOIN Movies M ON S.MovieID = M.MovieID
JOIN Rooms R ON S.RoomID = R.RoomID
JOIN RoomTypes RT ON R.RoomTypeID = RT.RoomTypeID
JOIN Reservations RS ON B.BookingID = RS.BookingID
JOIN Seats SE ON RS.SeatID = SE.SeatID
ORDER BY C.CustomerID, B.BookingID;


-- ============================================
-- QUERY 4: Payment Method Breakdown
-- ============================================
-- Description: View the payment method used for each booking
-- and count total bookings per payment type.

SELECT 
    PaymentMethod,
    COUNT(*) AS NumberOfBookings,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Bookings), 2) AS Percentage
FROM Bookings
GROUP BY PaymentMethod
ORDER BY NumberOfBookings DESC;


-- ============================================
-- QUERY 5: Snack Menu
-- ============================================
-- Description: Display available snack items and their prices.

SELECT 
    SnackID,
    Name AS SnackName,
    CONCAT('$', CAST(Price AS CHAR)) AS Price
FROM Snacks
ORDER BY Price DESC;


-- ============================================
-- QUERY 6: Number of Tickets Sold per Movie
-- ============================================
-- Description: Count how many tickets were sold for each movie 
-- by counting bookings.

SELECT 
    M.Name AS MovieName,
    M.Genre,
    COUNT(B.BookingID) AS TicketsSold,
    SUM(RT.Price) AS TotalRevenue
FROM Bookings B
JOIN Shows S ON B.ShowID = S.ShowID
JOIN Movies M ON S.MovieID = M.MovieID
JOIN Rooms R ON S.RoomID = R.RoomID
JOIN RoomTypes RT ON R.RoomTypeID = RT.RoomTypeID
GROUP BY M.MovieID, M.Name, M.Genre
ORDER BY TicketsSold DESC;


-- ============================================
-- QUERY 7: Snack Orders Linked to Customers
-- ============================================
-- Description: Show each customer's snack orders with quantities.

SELECT 
    C.CustomerID,
    CONCAT(C.Fname, ' ', C.Lname) AS CustomerName,
    S.Name AS SnackName,
    D.Quantity,
    S.Price AS UnitPrice,
    (D.Quantity * S.Price) AS LineTotal,
    O.OrderTime
FROM Snack_Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Snack_Order_Details D ON O.SnackOrderID = D.SnackOrderID
JOIN Snacks S ON D.SnackID = S.SnackID
ORDER BY C.CustomerID, O.OrderTime;


-- ============================================
-- ADDITIONAL USEFUL QUERIES
-- ============================================

-- Query 8: Employee List with Roles
SELECT 
    EmpID,
    CONCAT(Fname, ' ', Lname) AS EmployeeName,
    Role,
    CONCAT('$', CAST(Salary AS CHAR)) AS Salary
FROM Employees
ORDER BY Role, Salary DESC;


-- Query 9: Most Popular Movies (by bookings)
SELECT 
    M.Name AS MovieName,
    M.Genre,
    COUNT(DISTINCT B.BookingID) AS TotalBookings,
    COUNT(DISTINCT B.CustomerID) AS UniqueCustomers
FROM Movies M
JOIN Shows S ON M.MovieID = S.MovieID
JOIN Bookings B ON S.ShowID = B.ShowID
GROUP BY M.MovieID, M.Name, M.Genre
ORDER BY TotalBookings DESC
LIMIT 5;


-- Query 10: Most Popular Snacks
SELECT 
    S.Name AS SnackName,
    SUM(D.Quantity) AS TotalSold,
    COUNT(DISTINCT D.SnackOrderID) AS NumberOfOrders,
    SUM(D.Quantity * S.Price) AS TotalRevenue
FROM Snacks S
JOIN Snack_Order_Details D ON S.SnackID = D.SnackID
GROUP BY S.SnackID, S.Name
ORDER BY TotalSold DESC;


-- Query 11: Revenue Summary (Tickets + Snacks)
SELECT 
    'Ticket Sales' AS RevenueSource,
    SUM(RT.Price) AS TotalRevenue
FROM Bookings B
JOIN Shows S ON B.ShowID = S.ShowID
JOIN Rooms R ON S.RoomID = R.RoomID
JOIN RoomTypes RT ON R.RoomTypeID = RT.RoomTypeID

UNION ALL

SELECT 
    'Snack Sales' AS RevenueSource,
    SUM(D.Quantity * S.Price) AS TotalRevenue
FROM Snack_Order_Details D
JOIN Snacks S ON D.SnackID = S.SnackID;


-- Query 12: Room Utilization Report
SELECT 
    R.RoomID,
    RT.Type AS RoomType,
    R.Capacity,
    COUNT(S.ShowID) AS TotalShows,
    COUNT(DISTINCT S.MovieID) AS UniqueMovies
FROM Rooms R
JOIN RoomTypes RT ON R.RoomTypeID = RT.RoomTypeID
LEFT JOIN Shows S ON R.RoomID = S.RoomID
GROUP BY R.RoomID, RT.Type, R.Capacity
ORDER BY TotalShows DESC;


-- ============================================
-- END OF QUERIES
-- ============================================
