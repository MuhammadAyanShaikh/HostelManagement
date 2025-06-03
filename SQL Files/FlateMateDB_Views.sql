USE FlateMate_DB;

CREATE VIEW view_all_bookings AS
SELECT 
    b.B_id,
    CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
    g.email,
    h.H_name AS hostel_name,
    r.room_type,
    b.check_in_date,
    b.check_out_date,
    b.number_of_guests,
    b.total_price,
    b.created_at
FROM Bookings_info b
JOIN Guests g ON b.G_id = g.G_id
JOIN Rooms r ON b.R_id = r.R_id
JOIN Hostels h ON r.H_id = h.H_id;


CREATE VIEW view_guest_history AS
SELECT 
    g.G_id,
    CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
    g.email,
    h.H_name AS hostel_name,
    r.room_type,
    b.check_in_date,
    b.check_out_date,
    b.total_price
FROM Guests g
JOIN Bookings_info b ON g.G_id = b.G_id
JOIN Rooms r ON b.R_id = r.R_id
JOIN Hostels h ON r.H_id = h.H_id;


CREATE VIEW view_hostel_summary AS
SELECT 
    h.H_id,
    h.H_name,
    l.city,
    l.country,
    h.address,
    h.num_of_Rooms,
    h.num_of_guests,
    h.rating,
    COUNT(b.B_id) AS total_bookings,
    SUM(b.total_price) AS total_earnings
FROM Hostels h
JOIN Locations l ON h.location_id = l.id
LEFT JOIN Rooms r ON h.H_id = r.H_id
LEFT JOIN Bookings_info b ON r.R_id = b.R_id
GROUP BY h.H_id;


CREATE VIEW view_location_stats AS
SELECT 
    l.city,
    l.country,
    l.NoOfHostels,
    COUNT(DISTINCT h.H_id) AS actual_hostels,
    SUM(h.num_of_guests) AS total_guests
FROM Locations l
LEFT JOIN Hostels h ON l.id = h.location_id
GROUP BY l.id;


CREATE VIEW view_upcoming_checkins AS
SELECT 
    b.B_id,
    CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
    h.H_name AS hostel_name,
    b.check_in_date,
    b.check_out_date
FROM Bookings_info b
JOIN Guests g ON b.G_id = g.G_id
JOIN Rooms r ON b.R_id = r.R_id
JOIN Hostels h ON r.H_id = h.H_id
WHERE b.check_in_date >= CURDATE()
ORDER BY b.check_in_date ASC;


CREATE VIEW view_earnings_per_hostel AS
SELECT 
    h.H_name,
    DATE_FORMAT(b.created_at, '%Y-%m') AS month,
    SUM(b.total_price) AS monthly_earnings
FROM Bookings_info b
JOIN Rooms r ON b.R_id = r.R_id
JOIN Hostels h ON r.H_id = h.H_id
GROUP BY h.H_id, month
ORDER BY month DESC;


CREATE VIEW view_room_allocation_summary AS
SELECT 
    CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
    h.H_name AS hostel_name,
    r.room_type,
    ra.R_id
FROM RoomAllocations ra
JOIN Guests g ON ra.G_id = g.G_id
JOIN Hostels h ON ra.H_id = h.H_id
JOIN Rooms r ON ra.R_id = r.R_id;
