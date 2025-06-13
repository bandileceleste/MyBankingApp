CREATE TRIGGER trg_InsertIntoCustomer
ON NewCustomer
AFTER INSERT
AS
BEGIN
    INSERT INTO Customer (name, surname, mobileNum, idNum, nationality, emailAddress, password, confPassword)
    SELECT 
        name, 
        surname, 
        mobileNum, 
        '0000000000000',       -- Default ID number (change as needed)
        'Unknown',             -- Default nationality
        CONCAT(mobileNum, '@default.com'), -- Default email
        'DefaultPass123',      -- Default password (change or hash this)
        'DefaultPass123'       -- Default confirm password
    FROM inserted;
END;
