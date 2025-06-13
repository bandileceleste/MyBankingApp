CREATE TRIGGER trg_NewCustomerInsert
ON dbo.NewCustomer
AFTER INSERT
AS
BEGIN
    INSERT INTO Customer (name, surname, mobileNum, idNum, nationality, emailAddress, password, confPassword)
    SELECT 
        name, 
        surname, 
        mobileNum, 
        CAST(NEWID() AS NVARCHAR(13)),  -- Generate a unique ID number
        'Unknown',                       -- Default nationality
        CONCAT(mobileNum, '-', CAST(NEWID() AS NVARCHAR(36)), '@default.com'), -- Ensure unique email
        'DefaultPass123',      
        'DefaultPass123'       
    FROM inserted
    WHERE NOT EXISTS (SELECT 1 FROM Customer WHERE Customer.mobileNum = inserted.mobileNum);
END;
