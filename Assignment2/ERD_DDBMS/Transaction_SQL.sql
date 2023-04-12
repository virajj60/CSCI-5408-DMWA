SET AUTOCOMMIT =0;
set profiling = 1;

-- Transaction 1 --
START TRANSACTION;
SELECT @userId:=userID, @amount:=totalAmt FROM reservation WHERE reservationID=2;
UPDATE user SET balanceAmt = balanceAmt - @amount WHERE userID = @userId;
COMMIT;


-- Transaction 2 --
START TRANSACTION;
SELECT @userId:=userID, @amount:=totalAmt FROM reservation WHERE reservationID=2;
UPDATE user SET balanceAmt = balanceAmt - @amount WHERE userID = @userId;
SELECT @equipmentID:=equipID FROM reservation WHERE reservationID = 3;
UPDATE equipments SET availableQty = availableQty-1 WHERE equipID = @equipmentID;
COMMIT;

show profiles; 