<?php
$host = 'localhost';
$db = 'FlateMate_DB';
$user = 'root';
$pass = 'Ayan12345';
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;dbname=$db;charset=$charset";

$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
];

try {
     $pdo = new PDO($dsn, $user, $pass, $options);
} catch (\PDOException $e) {
     echo json_encode(['message' => 'Database connection failed: ' . $e->getMessage()]);
     exit;
}
?>
