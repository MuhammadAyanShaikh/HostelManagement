CREATE DATABASE FlateMate_DB;
USE FlateMate_DB;

CREATE TABLE Locations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(50),
    country VARCHAR(50) NOT NULL,
    NoOfHostels INT NOT NULL
);

CREATE TABLE Hostels (
    H_id INT PRIMARY KEY AUTO_INCREMENT,
    H_name VARCHAR(50),
    location_id INT NOT NULL,
    address VARCHAR(255),
    price DECIMAL(8,2) NOT NULL,
    num_of_guests INT,
    description TEXT,
    rating DECIMAL(2,1) CHECK (rating BETWEEN 0 AND 5),
    num_of_Rooms INT NOT NULL,
    FOREIGN KEY (location_id) REFERENCES Locations(id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Rooms (
    R_id INT PRIMARY KEY AUTO_INCREMENT,
    H_id INT NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    room_price DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (H_id) REFERENCES Hostels(H_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Guests (
    G_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    message TEXT,
    H_id INT,
    FOREIGN KEY (H_id) REFERENCES Hostels(H_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE RoomAllocations (
    G_id INT NOT NULL,
    H_id INT NOT NULL,
    R_id INT NOT NULL,
    PRIMARY KEY (G_id, H_id, R_id),
    FOREIGN KEY (G_id) REFERENCES Guests(G_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (H_id) REFERENCES Hostels(H_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (R_id) REFERENCES Rooms(R_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Bookings_info (
    B_id INT PRIMARY KEY AUTO_INCREMENT,
    G_id INT NOT NULL,
    R_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    number_of_guests INT NOT NULL DEFAULT 1,
    FOREIGN KEY (G_id) REFERENCES Guests(G_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (R_id) REFERENCES Rooms(R_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Locations (city, country, NoOfHostels) VALUES
('Hyderabad', 'Pakistan', 1),
('Karachi', 'Pakistan', 1),
('Islamabad', 'Pakistan', 1),
('Lahore', 'Pakistan', 1);

INSERT INTO Hostels (H_name, location_id, address, price, num_of_guests, description, rating, num_of_Rooms) VALUES
('Hyderabad Hostel', 1, 'Hyderabad City Center', 200000.00, 0, 'Affordable stay in Hyderabad', 4.0, 5),
('Karachi Hostel', 2, 'Clifton Block 5, Karachi', 200000.00, 0, 'Comfortable and clean rooms in Karachi', 4.3, 6),
('Islamabad Hostel', 3, 'F-6 Sector, Islamabad', 200000.00, 0, 'Peaceful environment in Islamabad', 4.5, 4),
('Lahore Hostel', 4, 'Gulberg III, Lahore', 200000.00, 0, 'Centrally located in Lahore', 4.2, 7);

INSERT INTO Rooms (H_id, room_type, room_price) VALUES
(1, 'Standard Room', 200000.00),
(2, 'Standard Room', 200000.00),
(3, 'Standard Room', 200000.00),
(4, 'Standard Room', 200000.00);