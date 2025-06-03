<?php include 'db_con.php'; ?>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial; background: #f4f4f4; margin: 0; padding: 0; }
        nav { background: #333; padding: 1em; color: white; }
        nav a { color: white; margin-right: 20px; text-decoration: none; }
        .container { padding: 20px; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; }
        th { background: #555; color: white; }
    </style>
</head>
<body>

<nav>
    <a href="Dashboard.php?page=bookings"> All Bookings </a>
    <a href="Dashboard.php?page=guests"> Guest History </a>
    <a href="Dashboard.php?page=hostels">Hostel Summary</a>
    <a href="Dashboard.php?page=earnings">Earnings</a>
    <a href="Dashboard.php?page=checkins">Upcoming Check-ins</a>
    <a href="Dashboard.php?page=allocations">Room Allocations</a>
</nav>

<div class="container">
    <h2>Admin Dashboard</h2>

    <?php
    $page = $_GET['page'] ?? 'bookings';
    $views = [
        'bookings' => 'view_all_bookings',
        'guests' => 'view_guest_history',
        'hostels' => 'view_hostel_summary',
        'earnings' => 'view_earnings_per_hostel',
        'checkins' => 'view_upcoming_checkins',
        'allocations' => 'view_room_allocation_summary'
    ];

    if (array_key_exists($page, $views)) {
        try {
            $stmt = $pdo->query("SELECT * FROM {$views[$page]}");
            $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

            if ($results) {
                echo "<table><tr>";
                foreach (array_keys($results[0]) as $col) {
                    echo "<th>" . htmlspecialchars($col) . "</th>";
                }
                echo "</tr>";
                foreach ($results as $row) {
                    echo "<tr>";
                    foreach ($row as $val) {
                        echo "<td>" . htmlspecialchars($val) . "</td>";
                    }
                    echo "</tr>";
                }
                echo "</table>";
            } else {
                echo "<p>No data found for view: {$views[$page]}</p>";
            }
        } catch (PDOException $e) {
            echo "<p style='color:red;'>Error loading data: " . $e->getMessage() . "</p>";
        }
    } else {
        echo "<p>Invalid view selected.</p>";
    }
    ?>
</div>

</body>
</html>
