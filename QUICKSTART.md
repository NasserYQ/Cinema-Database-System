# Quick Start Guide

## 🚀 Get Your Database Running in 5 Minutes

### Step 1: Clone the Repository
```bash
git clone https://github.com/yourusername/cinema-database-system.git
cd cinema-database-system
```

### Step 2: Set Up Your Database

**For MySQL:**
```bash
# Create the database
mysql -u root -p
```
```sql
CREATE DATABASE cinema_db;
USE cinema_db;
exit;
```

**For PostgreSQL:**
```bash
psql -U postgres
```
```sql
CREATE DATABASE cinema_db;
\c cinema_db
\q
```

### Step 3: Create Tables
```bash
# MySQL
mysql -u root -p cinema_db < sql/schema.sql

# PostgreSQL
psql -U postgres -d cinema_db -f sql/schema.sql
```

### Step 4: Load Sample Data (Optional)
```bash
# MySQL
mysql -u root -p cinema_db < sql/sample_data.sql

# PostgreSQL
psql -U postgres -d cinema_db -f sql/sample_data.sql
```

### Step 5: Run Sample Queries
```bash
# MySQL
mysql -u root -p cinema_db < sql/queries.sql

# PostgreSQL
psql -U postgres -d cinema_db -f sql/queries.sql
```

---

## 🎯 Test Individual Queries

Connect to your database and try these:

### See All Movies and Showtimes
```sql
SELECT M.Name, M.Genre, S.StartTime 
FROM Movies M
JOIN Shows S ON M.MovieID = S.MovieID
ORDER BY S.StartTime;
```

### Check Available Seats for a Show
```sql
SELECT SeatRow, SeatNumber, 
    CASE 
        WHEN R.SeatID IS NOT NULL THEN 'Reserved'
        ELSE 'Available'
    END AS Status
FROM Seats SE
LEFT JOIN Reservations R ON SE.SeatID = R.SeatID
WHERE SE.RoomID = 1
ORDER BY SeatRow, SeatNumber;
```

### View Most Popular Movies
```sql
SELECT M.Name, COUNT(B.BookingID) AS TicketsSold
FROM Movies M
JOIN Shows S ON M.MovieID = S.MovieID
JOIN Bookings B ON S.ShowID = B.ShowID
GROUP BY M.Name
ORDER BY TicketsSold DESC;
```

---

## 📊 Understanding the Database

### Key Tables
- **Movies** - Movie catalog
- **Shows** - Screening schedule
- **Bookings** - Ticket purchases
- **Customers** - User accounts
- **Snacks** - Concession items

### Relationships
- Each **Show** connects one **Movie** to one **Room**
- Each **Booking** reserves specific **Seats** for a **Show**
- **Snack Orders** link **Customers** to **Snacks** through **Order Details**

---

## 🛠️ Troubleshooting

**Problem**: Foreign key constraint fails
- **Solution**: Load tables in order: RoomTypes → Movies → Rooms → Shows → Seats → Customers → Employees → rest

**Problem**: Duplicate entry error
- **Solution**: Clear existing data or use different IDs

**Problem**: Permission denied
- **Solution**: Check your database user permissions

---

## 📚 Next Steps

1. ✅ Explore all queries in `sql/queries.sql`
2. ✅ Modify sample data to match your needs
3. ✅ Add your own business logic
4. ✅ Create views for common queries
5. ✅ Add stored procedures for complex operations

---

## 💡 Tips for Your Portfolio

- Screenshot your ER diagram and add to README
- Document any custom queries you create
- Explain design decisions in comments
- Show before/after of optimizations
- Create a presentation slide deck

---

**Need Help?** Check the full README.md for detailed documentation!
