
-- ===========================================
-- PHASE 1: Create Database
-- ===========================================
CREATE DATABASE EthiopianCoffeeDB;
USE EthiopianCoffeeDB;

-- ===========================================
-- PHASE 2: Create Tables
-- ===========================================
CREATE TABLE Cooperative (
    CooperativeID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Contact_Info VARCHAR(100),
    Total_Members INT,
    RegNumber VARCHAR(20) UNIQUE
);

CREATE TABLE Farmer (
    FarmerID VARCHAR(10) PRIMARY KEY,
    Full_Name VARCHAR(100) NOT NULL,
    GPS_Latitude DECIMAL(9,6),
    GPS_Longitude DECIMAL(9,6),
    CooperativeID VARCHAR(10),
    FOREIGN KEY (CooperativeID) REFERENCES Cooperative(CooperativeID)
);

CREATE TABLE LandPlot (
    PlotID VARCHAR(10) PRIMARY KEY,
    Soil_Quantity_Size_Hectares FLOAT,
    Altitude INT,
    Description TEXT,
    FarmerID VARCHAR(10),
    FOREIGN KEY (FarmerID) REFERENCES Farmer(FarmerID)
);

CREATE TABLE CoffeeBatch (
    BatchID VARCHAR(10) PRIMARY KEY,
    PlotID VARCHAR(10),
    Harvest_Date DATE,
    FOREIGN KEY (PlotID) REFERENCES LandPlot(PlotID)
);

CREATE TABLE WareHouse (
    WareHouseID VARCHAR(10) PRIMARY KEY,
    GPS_Latitude DECIMAL(9,6),
    GPS_Longitude DECIMAL(9,6),
    Temperature_Celsius FLOAT,
    Last_Updated DATE
);

CREATE TABLE Storage (
    StorageID INT IDENTITY(1,1) PRIMARY KEY,
    BatchID VARCHAR(10),
    WareHouseID VARCHAR(10),
    StorageDate DATE DEFAULT GETDATE(),
    FOREIGN KEY (BatchID) REFERENCES CoffeeBatch(BatchID),
    FOREIGN KEY (WareHouseID) REFERENCES WareHouse(WareHouseID)
);

CREATE TABLE Transport (
    TransportID VARCHAR(10) PRIMARY KEY,
    BatchID VARCHAR(10),
    DepartureDate DATE,
    GPS_Device_ID VARCHAR(20),
    ArrivalDate DATE,
    DeliveryStatus VARCHAR(20) DEFAULT 'In Transit',
    FOREIGN KEY (BatchID) REFERENCES CoffeeBatch(BatchID)
);

CREATE TABLE QualityAssessment (
    AssessmentID VARCHAR(10) PRIMARY KEY,
    BatchID VARCHAR(10),
    Grade VARCHAR(20),
    Moisture_Percent FLOAT CHECK (Moisture_Percent >= 0 AND Moisture_Percent <= 100),
    Defect_Count INT,
    FOREIGN KEY (BatchID) REFERENCES CoffeeBatch(BatchID)
);

CREATE TABLE Buyer (
    BuyerID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100),
    Country VARCHAR(50),
    ContactEmail VARCHAR(100)
);

CREATE TABLE ExportDocument (
    ExportID VARCHAR(10) PRIMARY KEY,
    BatchID VARCHAR(10),
    BuyerID VARCHAR(10),
    Incoterm VARCHAR(50),
    ShippingDate DATE,
    FOREIGN KEY (BatchID) REFERENCES CoffeeBatch(BatchID),
    FOREIGN KEY (BuyerID) REFERENCES Buyer(BuyerID)
);

CREATE TABLE Payment (
    PaymentID VARCHAR(10) PRIMARY KEY,
    FarmerID VARCHAR(10),
    Amount FLOAT CHECK (Amount >= 0),
    PaymentDate DATE DEFAULT GETDATE(),
    FOREIGN KEY (FarmerID) REFERENCES Farmer(FarmerID)
);

-- ===========================================
-- PHASE 3: Insert Sample Data
-- ===========================================
INSERT INTO Cooperative VALUES 
('COOP001', 'Sidama Union', 'sidama@example.com', 500, 'REG001'),
('COOP002', 'Yirgacheffe Union', 'yirga@example.com', 300, 'REG002'),
('COOP003', 'Guji Union', 'guji@example.com', 200, 'REG003');

INSERT INTO Farmer VALUES 
('F001', 'Abebe Kebede', 6.5244, 38.4393, 'COOP001'),
('F002', 'Alemu Tadesse', 6.7222, 38.3021, 'COOP002'),
('F003', 'Mesfin Hailu', 6.1234, 38.1234, 'COOP001'),
('F004', 'Lensa Guta', 6.7890, 38.5678, 'COOP003');

INSERT INTO LandPlot VALUES 
('P001', 1.5, 2000, 'Rich volcanic soil', 'F001'),
('P002', 2.0, 2100, 'Sandy soil', 'F002'),
('P003', 1.2, 1950, 'Highland clay', 'F003'),
('P004', 1.8, 2050, 'Loamy soil', 'F004');

INSERT INTO CoffeeBatch VALUES 
('B001', 'P001', '2024-11-10'),
('B002', 'P002', '2024-11-12'),
('B003', 'P003', '2024-11-13'),
('B004', 'P004', '2024-11-15');

INSERT INTO WareHouse VALUES 
('W001', 6.5678, 38.4567, 18.5, '2025-04-20'),
('W002', 6.6789, 38.5678, 19.2, '2025-04-20');

INSERT INTO Storage (BatchID, WareHouseID) VALUES 
('B001', 'W001'),
('B002', 'W002'),
('B003', 'W001'),
('B004', 'W002');

INSERT INTO Transport VALUES 
('T001', 'B001', '2025-04-22', 'GPSD001', NULL, 'In Transit'),
('T002', 'B002', '2025-04-23', 'GPSD002', NULL, 'In Transit'),
('T003', 'B003', '2025-04-24', 'GPSD003', NULL, 'In Transit'),
('T004', 'B004', '2025-04-25', 'GPSD004', NULL, 'In Transit');

INSERT INTO QualityAssessment VALUES 
('Q001', 'B001', 'Grade 1', 10.5, 2),
('Q002', 'B002', 'Grade 2', 12.0, 5),
('Q003', 'B003', 'Grade 1', 11.0, 1),
('Q004', 'B004', 'Grade 3', 13.5, 6);

INSERT INTO Buyer VALUES 
('BUY001', 'Global Coffee Ltd.', 'USA', 'globalcoffee@example.com'),
('BUY002', 'European Beans Co.', 'Germany', 'eubeans@example.de'),
('BUY003', 'Tokyo Roast Inc.', 'Japan', 'tokyoroast@example.jp');

INSERT INTO ExportDocument VALUES 
('EXP001', 'B001', 'BUY001', 'FOB', '2025-05-01'),
('EXP002', 'B002', 'BUY002', 'CIF', '2025-05-02'),
('EXP003', 'B003', 'BUY003', 'EXW', '2025-05-03');

INSERT INTO Payment VALUES 
('PAY001', 'F001', 1200.00, GETDATE()),
('PAY002', 'F002', 1350.00, GETDATE()),
('PAY003', 'F003', 1100.00, GETDATE()),
('PAY004', 'F004', 1400.00, GETDATE());

-- ===========================================
-- PHASE 4: Transactions
-- ===========================================
UPDATE Transport SET DepartureDate = GETDATE() WHERE TransportID = 'T001';
UPDATE Transport SET DepartureDate = GETDATE() WHERE TransportID = 'T002';
UPDATE Transport SET ArrivalDate = GETDATE(), DeliveryStatus = 'Delivered' WHERE TransportID = 'T001';
UPDATE Transport SET ArrivalDate = GETDATE(), DeliveryStatus = 'Delivered' WHERE TransportID = 'T002';
UPDATE Payment SET Amount = Amount + 100 WHERE PaymentID = 'PAY001';

-- ===========================================
-- PHASE 5: Reports
-- ===========================================
SELECT Farmer.Full_Name, Cooperative.Name AS CooperativeName
FROM Farmer
JOIN Cooperative ON Farmer.CooperativeID = Cooperative.CooperativeID;

SELECT CoffeeBatch.BatchID, WareHouse.WareHouseID, Storage.StorageDate
FROM CoffeeBatch
JOIN Storage ON CoffeeBatch.BatchID = Storage.BatchID
JOIN WareHouse ON Storage.WareHouseID = WareHouse.WareHouseID;

SELECT TransportID, BatchID, DepartureDate, ArrivalDate, DeliveryStatus, GPS_Device_ID FROM Transport;

SELECT ExportDocument.ExportID, Buyer.Name AS BuyerName, ExportDocument.ShippingDate
FROM ExportDocument
JOIN Buyer ON ExportDocument.BuyerID = Buyer.BuyerID;

SELECT SUM(Amount) AS TotalPayment FROM Payment;

SELECT Full_Name AS 'Farmer Name' FROM Farmer WHERE FarmerID = 'F001';
