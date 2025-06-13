USE BankingAppDB;

-- Admin Table
CREATE TABLE Admin (
    ID INT IDENTITY(1,1) PRIMARY KEY, 
    adminID AS ('a' + RIGHT('0000' + CAST(ID AS NVARCHAR(4)), 4)) PERSISTED UNIQUE,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    confpassword VARCHAR(255) NOT NULL
);

INSERT INTO Admin(name, surname, email, password, confpassword)
VALUES ('Celeste', 'Ndlovu', 'ndilecee@gmail.com', 'iLovefrenchfries#3', 'iLovefrenchfries#3');

-- Customer Table
CREATE TABLE Customer (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    cusID AS ('c' + RIGHT('0000' + CAST(ID AS NVARCHAR(4)), 4)) PERSISTED UNIQUE,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    mobileNum VARCHAR(10) NOT NULL UNIQUE,
	idNum VARCHAR(13) NOT NULL UNIQUE,
    nationality VARCHAR(50) NOT NULL,  
    emailAddress VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    confPassword VARCHAR(255) NOT NULL
);

INSERT INTO Customer(name, surname, idNum, nationality, mobileNum, emailAddress, password, confPassword)
VALUES ('Aphiwe', 'Madondo', '0406031234567', 'South Africa', '0634152286', 'aphiwemadondo@gmail.com', '12BuckleMy$hoe', '12BuckleMy$hoe');

-- Account Table
CREATE TABLE Account (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    accID AS ('u' + RIGHT('0000' + CAST(ID AS NVARCHAR(4)), 4)) PERSISTED UNIQUE,
    cusID NVARCHAR(5) NOT NULL,
    accType VARCHAR(50),
    balance DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (cusID) REFERENCES Customer(cusID)
);

INSERT INTO Account(cusID, accType, balance)
VALUES ('c0001', 'Savings', 2000.50);

-- Transaction Table
CREATE TABLE Transact (
	ID INT IDENTITY(1,1) PRIMARY KEY,
    transID AS ('t' + RIGHT('0000' + CAST(ID AS NVARCHAR(4)), 4)) PERSISTED UNIQUE,
    accID NVARCHAR(5) NOT NULL,
    transType VARCHAR(50),
    amount DECIMAL(10,2),
    transDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (accID) REFERENCES Account(accID)
);

INSERT INTO Transact(accID, transType, amount)
VALUES ('u0001', 'Deposit', 500.00);

USE BankingAppDB;

CREATE TABLE NewCustomer (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    mobileNum VARCHAR(10) NOT NULL UNIQUE
);
