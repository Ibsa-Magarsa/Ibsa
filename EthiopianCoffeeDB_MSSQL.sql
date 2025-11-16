-- =============================================================
-- Team Members - EthiopianCoffeeDB Project
-- Group Name: CoffeeCoders
-- 
-- 1. Naol Gelana         - ID: UGR/35081/16
-- 2. Roba Rikita         - ID: UGR/35275/16
-- 3. Dagim Girma         - ID: UGR/34169/16
-- 4. Ibsa Magarsaa       - ID: UGR/??/16
-- 5. Amanuel Geremu      - ID: UGR/33905/16
-- =============================================================


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
    Description VARCHAR(MAX),
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


-- === AUDIT LOGGING SECTION ===

-- =============================
-- AUDIT LOG TABLE CREATION
-- =============================
CREATE TABLE IF NOT EXISTS audit_log (
    log_id SERIAL PRIMARY KEY,
    operation_type VARCHAR(10),
    table_name VARCHAR(100),
    operation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================
-- TRIGGERS FOR Cooperative TABLE
-- =============================

CREATE OR REPLACE FUNCTION log_insert_cooperative()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('INSERT', 'Cooperative', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_update_cooperative()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('UPDATE', 'Cooperative', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_delete_cooperative()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('DELETE', 'Cooperative', GETDATE());
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER cooperative_insert_trigger
AFTER INSERT ON Cooperative
FOR EACH ROW EXECUTE FUNCTION log_insert_cooperative();

CREATE TRIGGER cooperative_update_trigger
AFTER UPDATE ON Cooperative
FOR EACH ROW EXECUTE FUNCTION log_update_cooperative();

CREATE TRIGGER cooperative_delete_trigger
AFTER DELETE ON Cooperative
FOR EACH ROW EXECUTE FUNCTION log_delete_cooperative();

-- =============================
-- TRIGGERS FOR Farmer TABLE
-- =============================

CREATE OR REPLACE FUNCTION log_insert_farmer()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('INSERT', 'Farmer', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_update_farmer()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('UPDATE', 'Farmer', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_delete_farmer()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('DELETE', 'Farmer', GETDATE());
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER farmer_insert_trigger
AFTER INSERT ON Farmer
FOR EACH ROW EXECUTE FUNCTION log_insert_farmer();

CREATE TRIGGER farmer_update_trigger
AFTER UPDATE ON Farmer
FOR EACH ROW EXECUTE FUNCTION log_update_farmer();

CREATE TRIGGER farmer_delete_trigger
AFTER DELETE ON Farmer
FOR EACH ROW EXECUTE FUNCTION log_delete_farmer();

-- =============================
-- TRIGGERS FOR LandPlot TABLE
-- =============================

CREATE OR REPLACE FUNCTION log_insert_landplot()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('INSERT', 'LandPlot', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_update_landplot()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('UPDATE', 'LandPlot', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_delete_landplot()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('DELETE', 'LandPlot', GETDATE());
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER landplot_insert_trigger
AFTER INSERT ON LandPlot
FOR EACH ROW EXECUTE FUNCTION log_insert_landplot();

CREATE TRIGGER landplot_update_trigger
AFTER UPDATE ON LandPlot
FOR EACH ROW EXECUTE FUNCTION log_update_landplot();

CREATE TRIGGER landplot_delete_trigger
AFTER DELETE ON LandPlot
FOR EACH ROW EXECUTE FUNCTION log_delete_landplot();

-- =============================
-- TRIGGERS FOR CoffeeBatch TABLE
-- =============================

CREATE OR REPLACE FUNCTION log_insert_coffeebatch()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('INSERT', 'CoffeeBatch', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_update_coffeebatch()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('UPDATE', 'CoffeeBatch', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_delete_coffeebatch()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('DELETE', 'CoffeeBatch', GETDATE());
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER coffeebatch_insert_trigger
AFTER INSERT ON CoffeeBatch
FOR EACH ROW EXECUTE FUNCTION log_insert_coffeebatch();

CREATE TRIGGER coffeebatch_update_trigger
AFTER UPDATE ON CoffeeBatch
FOR EACH ROW EXECUTE FUNCTION log_update_coffeebatch();

CREATE TRIGGER coffeebatch_delete_trigger
AFTER DELETE ON CoffeeBatch
FOR EACH ROW EXECUTE FUNCTION log_delete_coffeebatch();

-- =============================
-- TRIGGERS FOR WareHouse TABLE
-- =============================

CREATE OR REPLACE FUNCTION log_insert_warehouse()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('INSERT', 'WareHouse', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_update_warehouse()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('UPDATE', 'WareHouse', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_delete_warehouse()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('DELETE', 'WareHouse', GETDATE());
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER warehouse_insert_trigger
AFTER INSERT ON WareHouse
FOR EACH ROW EXECUTE FUNCTION log_insert_warehouse();

CREATE TRIGGER warehouse_update_trigger
AFTER UPDATE ON WareHouse
FOR EACH ROW EXECUTE FUNCTION log_update_warehouse();

CREATE TRIGGER warehouse_delete_trigger
AFTER DELETE ON WareHouse
FOR EACH ROW EXECUTE FUNCTION log_delete_warehouse();

-- =============================
-- TRIGGERS FOR Storage TABLE
-- =============================

CREATE OR REPLACE FUNCTION log_insert_storage()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('INSERT', 'Storage', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_update_storage()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('UPDATE', 'Storage', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_delete_storage()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('DELETE', 'Storage', GETDATE());
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER storage_insert_trigger
AFTER INSERT ON Storage
FOR EACH ROW EXECUTE FUNCTION log_insert_storage();

CREATE TRIGGER storage_update_trigger
AFTER UPDATE ON Storage
FOR EACH ROW EXECUTE FUNCTION log_update_storage();

CREATE TRIGGER storage_delete_trigger
AFTER DELETE ON Storage
FOR EACH ROW EXECUTE FUNCTION log_delete_storage();

-- =============================
-- TRIGGERS FOR Transport TABLE
-- =============================

CREATE OR REPLACE FUNCTION log_insert_transport()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('INSERT', 'Transport', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_update_transport()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('UPDATE', 'Transport', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_delete_transport()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('DELETE', 'Transport', GETDATE());
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER transport_insert_trigger
AFTER INSERT ON Transport
FOR EACH ROW EXECUTE FUNCTION log_insert_transport();

CREATE TRIGGER transport_update_trigger
AFTER UPDATE ON Transport
FOR EACH ROW EXECUTE FUNCTION log_update_transport();

CREATE TRIGGER transport_delete_trigger
AFTER DELETE ON Transport
FOR EACH ROW EXECUTE FUNCTION log_delete_transport();

-- =============================
-- TRIGGERS FOR QualityAssessment TABLE
-- =============================

CREATE OR REPLACE FUNCTION log_insert_qualityassessment()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('INSERT', 'QualityAssessment', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_update_qualityassessment()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('UPDATE', 'QualityAssessment', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_delete_qualityassessment()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('DELETE', 'QualityAssessment', GETDATE());
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER qualityassessment_insert_trigger
AFTER INSERT ON QualityAssessment
FOR EACH ROW EXECUTE FUNCTION log_insert_qualityassessment();

CREATE TRIGGER qualityassessment_update_trigger
AFTER UPDATE ON QualityAssessment
FOR EACH ROW EXECUTE FUNCTION log_update_qualityassessment();

CREATE TRIGGER qualityassessment_delete_trigger
AFTER DELETE ON QualityAssessment
FOR EACH ROW EXECUTE FUNCTION log_delete_qualityassessment();

-- =============================
-- TRIGGERS FOR Buyer TABLE
-- =============================

CREATE OR REPLACE FUNCTION log_insert_buyer()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('INSERT', 'Buyer', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_update_buyer()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('UPDATE', 'Buyer', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_delete_buyer()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('DELETE', 'Buyer', GETDATE());
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER buyer_insert_trigger
AFTER INSERT ON Buyer
FOR EACH ROW EXECUTE FUNCTION log_insert_buyer();

CREATE TRIGGER buyer_update_trigger
AFTER UPDATE ON Buyer
FOR EACH ROW EXECUTE FUNCTION log_update_buyer();

CREATE TRIGGER buyer_delete_trigger
AFTER DELETE ON Buyer
FOR EACH ROW EXECUTE FUNCTION log_delete_buyer();

-- =============================
-- TRIGGERS FOR ExportDocument TABLE
-- =============================

CREATE OR REPLACE FUNCTION log_insert_exportdocument()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('INSERT', 'ExportDocument', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_update_exportdocument()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('UPDATE', 'ExportDocument', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_delete_exportdocument()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('DELETE', 'ExportDocument', GETDATE());
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER exportdocument_insert_trigger
AFTER INSERT ON ExportDocument
FOR EACH ROW EXECUTE FUNCTION log_insert_exportdocument();

CREATE TRIGGER exportdocument_update_trigger
AFTER UPDATE ON ExportDocument
FOR EACH ROW EXECUTE FUNCTION log_update_exportdocument();

CREATE TRIGGER exportdocument_delete_trigger
AFTER DELETE ON ExportDocument
FOR EACH ROW EXECUTE FUNCTION log_delete_exportdocument();

-- =============================
-- TRIGGERS FOR Payment TABLE
-- =============================

CREATE OR REPLACE FUNCTION log_insert_payment()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('INSERT', 'Payment', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_update_payment()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('UPDATE', 'Payment', GETDATE());
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION log_delete_payment()
RETURNS trigger AS $$
BEGIN
  INSERT INTO audit_log(operation_type, table_name, operation_time)
  VALUES ('DELETE', 'Payment', GETDATE());
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER payment_insert_trigger
AFTER INSERT ON Payment
FOR EACH ROW EXECUTE FUNCTION log_insert_payment();

CREATE TRIGGER payment_update_trigger
AFTER UPDATE ON Payment
FOR EACH ROW EXECUTE FUNCTION log_update_payment();

CREATE TRIGGER payment_delete_trigger
AFTER DELETE ON Payment
FOR EACH ROW EXECUTE FUNCTION log_delete_payment();


-- === ADDITIONAL COMPONENTS ===

-- =============================
-- VIEWS
-- =============================

-- 1. Farmer and Cooperative Information
CREATE OR REPLACE VIEW farmer_coop_view AS
SELECT f.farmer_id, f.full_name, f.gender, f.phone, c.cooperative_name
FROM Farmer f
JOIN Cooperative c ON f.cooperative_id = c.cooperative_id;

-- 2. Batch, Warehouse and Transport Details
CREATE OR REPLACE VIEW batch_transport_view AS
SELECT cb.batch_id, cb.quantity_kg, w.warehouse_name, t.vehicle_plate
FROM CoffeeBatch cb
JOIN Transport t ON cb.transport_id = t.transport_id
JOIN Warehouse w ON t.destination_warehouse_id = w.warehouse_id;

-- 3. Farmer Total Quantity Produced
CREATE OR REPLACE VIEW farmer_total_batches AS
SELECT f.farmer_id, f.full_name, SUM(cb.quantity_kg) AS total_kg
FROM Farmer f
JOIN LandPlot lp ON f.farmer_id = lp.farmer_id
JOIN CoffeeBatch cb ON lp.plot_id = cb.plot_id
GROUP BY f.farmer_id, f.full_name;

-- 4. Payments Made to Farmers
CREATE OR REPLACE VIEW farmer_payments_view AS
SELECT p.payment_id, f.full_name, p.amount, p.payment_date
FROM Payment p
JOIN Farmer f ON p.farmer_id = f.farmer_id;

-- =============================
-- STORED PROCEDURES
-- =============================

-- Register new farmer
CREATE OR REPLACE FUNCTION register_farmer(
  full_name VARCHAR,
  gender VARCHAR,
  phone VARCHAR,
  cooperative_id INT
)
RETURNS VOID AS $$
BEGIN
  INSERT INTO Farmer(full_name, gender, phone, cooperative_id)
  VALUES (full_name, gender, phone, cooperative_id);
END;
$$ LANGUAGE plpgsql;

-- Calculate total payment for a farmer
CREATE OR REPLACE FUNCTION total_payment_for_farmer(fid INT)
RETURNS NUMERIC AS $$
DECLARE
  total NUMERIC;
BEGIN
  SELECT SUM(amount) INTO total
  FROM Payment
  WHERE farmer_id = fid;
  RETURN COALESCE(total, 0);
END;
$$ LANGUAGE plpgsql;

-- =============================
-- USER MANAGEMENT AND PERMISSIONS
-- =============================

-- Create users
CREATE ROLE admin LOGIN PASSWORD 'adminpass';
CREATE ROLE data_entry LOGIN PASSWORD 'entrypass';
CREATE ROLE viewer LOGIN PASSWORD 'viewpass';

-- Permissions
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin;
GRANT INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO data_entry;
GRANT SELECT ON ALL TABLES, ALL VIEWS IN SCHEMA public TO viewer;
