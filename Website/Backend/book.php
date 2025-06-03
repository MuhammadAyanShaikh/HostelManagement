<?php
header('Content-Type: application/json');
require 'db.php';

$data = json_decode(file_get_contents('php://input'), true);

// Sanitize & Extract
$first_name = $data['first_name'];
$last_name = $data['last_name'];
$email = $data['email'];
$phone = $data['phone'];
$message = $data['message'];
$hostel_id = $data['hostel_id'];
$checkin = $data['checkin'];
$checkout = $data['checkout'];
$num_guests = $data['num_guests'];
$total_price = $data['total_price'];

try {
    // Insert into Guests
    $stmt = $pdo->prepare("INSERT INTO Guests (first_name, last_name, email, phone_number, message, H_id) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->execute([$first_name, $last_name, $email, $phone, $message, $hostel_id]);

    // Get guest_id
    $guest_id = $pdo->lastInsertId();

    // Get room_id (assuming one room per hostel as per your sample)
    $stmt = $pdo->prepare("SELECT R_id FROM Rooms WHERE H_id = ? LIMIT 1");
    $stmt->execute([$hostel_id]);
    $room = $stmt->fetch();
    $room_id = $room['R_id'];

    // Insert into Bookings_info
    $stmt = $pdo->prepare("INSERT INTO Bookings_info (G_id, R_id, check_in_date, check_out_date, total_price, number_of_guests)
                           VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->execute([$guest_id, $room_id, $checkin, $checkout, $total_price, $num_guests]);

    // Insert into RoomAllocations (automated)
    $stmt = $pdo->prepare("INSERT INTO RoomAllocations (G_id, H_id, R_id) VALUES (?, ?, ?)");
    $stmt->execute([$guest_id, $hostel_id, $room_id]);

    echo json_encode(['message' => 'Booking confirmed!']);
} catch (Exception $e) {
    echo json_encode(['message' => 'Error: ' . $e->getMessage()]);
}
?>
