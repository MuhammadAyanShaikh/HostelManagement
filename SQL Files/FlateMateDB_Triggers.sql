USE FlateMate_DB;

DELIMITER //
CREATE TRIGGER trg_increment_guest_count
AFTER INSERT ON Bookings_info
FOR EACH ROW
BEGIN
  UPDATE Hostels
  SET num_of_guests = num_of_guests + NEW.number_of_guests
  WHERE H_id = (
      SELECT H_id FROM Rooms WHERE R_id = NEW.R_id LIMIT 1
  );
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_auto_allocate_room
AFTER INSERT ON Bookings_info
FOR EACH ROW
BEGIN
  DECLARE hostelId INT;
  SELECT H_id INTO hostelId FROM Rooms WHERE R_id = NEW.R_id;
  
  INSERT INTO RoomAllocations (G_id, H_id, R_id)
  VALUES (NEW.G_id, hostelId, NEW.R_id);
END;
//
DELIMITER ;