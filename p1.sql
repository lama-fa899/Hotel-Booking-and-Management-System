CREATE TABLE Room(RoomID NUMBER(4) CONSTRAINT RoomID_PK PRIMARY KEY,
RoomNumber NUMBER(4) CONSTRAINT RoomNumber_U UNIQUE ,
Availability VARCHAR2(20) DEFAULT 'Available' ,
Capacity NUMBER(10) CONSTRAINT Capacity_n NOT NULL,
Type VARCHAR2(30) CONSTRAINT Type_n NOT NULL,
PriceperNight NUMBER(10,2) CONSTRAINT PriceperNight_n NOT NULL);

CREATE TABLE Staff(
    StaffID NUMBER(5) constraint staffid_staff primary key,
    Name varchar(20) constraint name_staff not null,
    Email VARCHAR2(30) not null,
    Phone NUMBER(10),
    JobType VARCHAR2(15) constraint jobtype_staff not null,
    Salary NUMBER(10) constraint salary_staff check (Salary > 2000) constraint salary_n not null 
);


CREATE TABLE Receptionist(
       StaffID NUMBER(5)PRIMARY KEY , 
       Foreign KEY (StaffID) REFERENCES Staff(StaffID),
       -- night shift=  0, day shift = 1
       Shift_Time NUMBER(1) DEFAULT (1) CONSTRAINT shift_t NOT NULL 
);

CREATE TABLE Housekeeper(StaffID NUMBER(5) PRIMARY KEY ,
         Foreign KEY (StaffID) REFERENCES Staff(StaffID),
         Assigned_floor VARCHAR2(3) CONSTRAINT  Assigned_staff NOT NULL 
);


CREATE TABLE Manager(
       StaffID NUMBER(5)PRIMARY KEY,
       Foreign KEY (StaffID) REFERENCES Staff(StaffID),
       Start_date DATE
);


CREATE TABLE Chef(
       StaffID NUMBER(5)PRIMARY KEY, 
       Foreign KEY (StaffID) REFERENCES Staff(StaffID),
       Speciality VARCHAR2(15)
);


CREATE TABLE Securaity(
       StaffID NUMBER(5)PRIMARY KEY,
       Foreign KEY (StaffID) REFERENCES Staff(StaffID),
       Rank VARCHAR2(25) CHECK (Rank IN ('Security Manager','Security Supervisors','Security Guards','Auxiliary�Roles')) NOT NULL
);

CREATE TABLE Services (
    ServiceID INT PRIMARY KEY,
    ServiceName VARCHAR(50) NOT NULL,
    ServiceType VARCHAR(50),
    ServicePrice NUMERIC(6,2)
    );
    
CREATE TABLE Guest (
    GuestID INT PRIMARY KEY,
    GuestName VARCHAR(50) NOT NULL,
    Phone VARCHAR(20) UNIQUE,
    Email VARCHAR(100) UNIQUE,
    Nationality VARCHAR(20)
    );



CREATE TABLE Reservation(ReservationID NUMBER(10) CONSTRAINT reservation_PK PRIMARY KEY ,GuestID NUMBER(4) NOT NULL ,RoomID NUMBER(4) NOT NULL,
StaffID NUMBER(4)NOT NULL ,ReservationDate Date NOT NULL ,CheckINDate Date NOT NULL,
CheckOutDate Date NOT NULL,TotalPrice NUMBER(10,2) NOT NULL,PaymentStatus VARCHAR(10) DEFAULT 'pending',
CONSTRAINT reservation_check_validDates CHECK (CheckINDate<CheckOutDate
AND ReservationDate <= CheckINDate)
,FOREIGN KEY(RoomID) REFERENCES Room(RoomID),
 FOREIGN KEY(GuestID) REFERENCES Guest(GuestID)
,FOREIGN KEY(StaffID) REFERENCES Staff(StaffID)
);


CREATE TABLE ReservationServices(ReservationID NUMBER(10),ServiceID NUMBER(4),PRIMARY KEY(ReservationID,ServiceID),
FOREIGN KEY(ReservationID) REFERENCES Reservation(ReservationID),FOREIGN KEY(ServiceID) REFERENCES Services(ServiceID));

CREATE TABLE Payment(PaymentID NUMBER(4) CONSTRAINT PaymentID_PK PRIMARY KEY,
ReservationID_Fk NUMBER(4) CONSTRAINT ReservationID_n NOT NULL,
PaymentAmount NUMBER(10,2) CONSTRAINT PaymentAmount_n NOT NULL,
Currency VARCHAR2(10) CONSTRAINT Currency_n NOT NULL,
PaymentDate DATE CONSTRAINT PaymentDate_n NOT NULL,
PaymentMethod VARCHAR2(30) CONSTRAINT PaymentMethod_n NOT NULL,
payerinfo VARCHAR2(100) ,
CONSTRAINT Payment_FK FOREIGN KEY(ReservationID_Fk) REFERENCES Reservation(ReservationID));

CREATE TABLE Cleans (StaffID  NUMBER(4),RoomID NUMBER(4),PRIMARY KEY(StaffID ,RoomID),
FOREIGN KEY(StaffID) REFERENCES Housekeeper(StaffID),FOREIGN KEY(RoomID) REFERENCES Room(RoomID));

INSERT INTO Staff VALUES (101, 'Sara',  'sara@hotel.com',   0551000001, 'Receptionist', 3500);
INSERT INTO Staff VALUES (102, 'Omar',  'omar@hotel.com',   0551000002, 'Receptionist', 3600);
INSERT INTO Staff VALUES (103, 'Rana',  'rana@hotel.com',   0551000003, 'Receptionist', 3400);
INSERT INTO Staff VALUES (104, 'Noor',  'noor@hotel.com',   0551000004, 'Receptionist', 3550);
INSERT INTO Staff VALUES (105, 'Alya',  'alya@hotel.com',   0551000005, 'Receptionist', 3300);

INSERT INTO Staff VALUES (106, 'Fahad',  'fahad@hotel.com',   0551000006, 'Housekeeper', 3000);
INSERT INTO Staff VALUES (107, 'Mona',  'mona@hotel.com',   0551000007, 'Housekeeper', 3100);
INSERT INTO Staff VALUES (108, 'Rita',  'rita@hotel.com',   0551000008, 'Housekeeper', 3200);
INSERT INTO Staff VALUES (109, 'Salem',  'salem@hotel.com',   0551000009, 'Housekeeper', 3050);
INSERT INTO Staff VALUES (110, 'Areej', 'areej@hotel.com',  0551000010, 'Housekeeper', 3150);

INSERT INTO Staff VALUES (111, 'Huda',  'huda@hotel.com',  0551000011, 'Manager', 8000);
INSERT INTO Staff VALUES (112, 'Majed', 'majed@hotel.com',  0551000012, 'Manager', 8200);
INSERT INTO Staff VALUES (113, 'Lyan',  'lyan@hotel.com',   0551000013, 'Manager', 8100);
INSERT INTO Staff VALUES (114, 'Layla',  'layla@hotel.com',  0551000014, 'Manager', 8300);
INSERT INTO Staff VALUES (115, 'Jalal', 'jalal@hotel.com',  0551000015, 'Manager', 7900);

-- Receptionist
INSERT INTO Receptionist VALUES (101, 1);
INSERT INTO Receptionist VALUES (102, 0);
INSERT INTO Receptionist VALUES (103, 1);
INSERT INTO Receptionist VALUES (104, 1);
INSERT INTO Receptionist VALUES (105, 0);

-- Housekeeper
INSERT INTO Housekeeper VALUES (106, 'G');
INSERT INTO Housekeeper VALUES (107, '1');
INSERT INTO Housekeeper VALUES (108, '1');
INSERT INTO Housekeeper VALUES (109, '2');
INSERT INTO Housekeeper VALUES (110, '3');

-- Manager
INSERT INTO Manager VALUES (111, DATE '2023-01-01');
INSERT INTO Manager VALUES (112, DATE '2022-06-15');
INSERT INTO Manager VALUES (113, DATE '2023-09-10');
INSERT INTO Manager VALUES (114, DATE '2021-11-20');
INSERT INTO Manager VALUES (115, DATE '2024-03-05');

INSERT INTO Room (RoomID, RoomNumber, Availability, Capacity, Type, PriceperNight)
VALUES (1, 101, 'Available', 2, 'Standard', 250.00);

INSERT INTO Room (RoomID, RoomNumber, Availability, Capacity, Type, PriceperNight)
VALUES (2, 102, 'Occupied', 3, 'Deluxe', 400.00);

INSERT INTO Room (RoomID, RoomNumber, Availability, Capacity, Type, PriceperNight)
VALUES (3, 201, 'Available', 4, 'Suite', 750.00);

INSERT INTO Room (RoomID, RoomNumber, Availability, Capacity, Type, PriceperNight)
VALUES (4, 202, 'Maintenance', 2, 'Standard', 200.00);

INSERT INTO Services(ServiceID,ServiceName,ServiceType,ServicePrice) 
VALUES(1,'Room Service','Food and Beverage Services',300.00);

INSERT INTO Services(ServiceID,ServiceName,ServiceType,ServicePrice) 
VALUES(2,'Spa','Leisure and Wellness Services',450.50);

INSERT INTO Services(ServiceID,ServiceName,ServiceType,ServicePrice) 
VALUES(3,'Gym','Leisure and Wellness Services',150.00);

INSERT INTO Services(ServiceID,ServiceName,ServiceType,ServicePrice) 
VALUES(4,'Swimming pool','Leisure and Wellness Services',50.00);

INSERT INTO Services(ServiceID,ServiceName,ServiceType,ServicePrice) 
VALUES(5,'Breakfast buffet','Food and Beverage Services',150.00);

INSERT INTO Guest(GuestID,GuestName,Phone ,Email,Nationality) 
VALUES(201,'Ahmad','0512345678','ahmad@outlook.com','Saudi');

INSERT INTO Guest(GuestID,GuestName,Phone ,Email,Nationality) 
VALUES(202,'Abdulrahman','0587654321','abdulrahman@outlook.com','Saudi');

INSERT INTO Guest(GuestID,GuestName,Phone ,Email,Nationality) 
VALUES(203,'Lama','0513579246',NULL,'Jordanian');

INSERT INTO Guest(GuestID,GuestName,Phone ,Email,Nationality) 
VALUES(204,'Ghalia','0512356790','ghalia@hotmail.com','Saudi');

INSERT INTO Guest(GuestID,GuestName,Phone ,Email,Nationality) 
VALUES(205,'Yousef','0598653200',NULL,'Syrian');



INSERT INTO Reservation(ReservationID,GuestID,RoomID,StaffID,ReservationDate,CheckINDate,CheckOutDate,TotalPrice,PaymentStatus)
VALUES (1001, 201, 1, 101,
        DATE '2024-01-02', DATE '2024-01-05', DATE '2024-01-10',
        1250, 'paid');

INSERT INTO Reservation
VALUES (1002, 202, 2, 102,
        DATE '2024-01-01', DATE '2024-02-03', DATE '2024-02-05',
        800, 'pending');

INSERT INTO Reservation
VALUES (1003, 203, 3, 103,
        DATE '2024-03-05', DATE '2024-03-07', DATE '2024-03-09',
        1500, 'paid');

INSERT INTO Reservation
VALUES (1004, 204, 4, 104,
        DATE '2024-04-5', DATE '2024-04-12', DATE '2024-04-15',
        2100, 'pending');

INSERT INTO Reservation
VALUES (1005, 205, 1, 105,
        DATE '2024-04-20', DATE '2024-05-21',DATE  '2024-05-25',
        3000, 'paid');
INSERT INTO Reservation
VALUES (1006, 205, 1, 105,
        DATE '2024-08-20', DATE '2024-08-21',DATE  '2024-08-25',
        3000, 'paid'); 
INSERT INTO Reservation
VALUES (1007, 204, 2, 103,
        DATE '2024-09-15', DATE '2024-09-20',DATE  '2024-09-25',
        4000, 'paid');        
        
        
INSERT INTO ReservationServices(ReservationID,ServiceID) VALUES (1001, 1);
INSERT INTO ReservationServices(ReservationID,ServiceID) VALUES (1002, 2);
INSERT INTO ReservationServices(ReservationID,ServiceID) VALUES (1003, 3);
INSERT INTO ReservationServices(ReservationID,ServiceID) VALUES (1004, 4);
INSERT INTO ReservationServices(ReservationID,ServiceID) VALUES (1005, 5);

INSERT INTO Cleans(StaffID,RoomID) VALUES (106, 1);
INSERT INTO Cleans(StaffID,RoomID) VALUES (107, 2);
INSERT INTO Cleans(StaffID,RoomID) VALUES (108, 3);
INSERT INTO Cleans(StaffID,RoomID) VALUES (109, 4);
INSERT INTO Cleans(StaffID,RoomID) VALUES (110, 1);

INSERT INTO Payment
VALUES (501, 1001, 1250, 'SAR', DATE '2024-01-10', 'Credit Card', 'Ahmad - Visa **** 1122');

INSERT INTO Payment
VALUES (502, 1003, 1500, 'SAR', DATE '2024-03-09', 'Cash', 'Lama - Paid at Reception');

INSERT INTO Payment
VALUES (503, 1005, 1000, 'SAR', DATE '2024-05-25', 'Debit Card', 'Yousef - Mada **** 8934');

INSERT INTO Payment
VALUES (504, 1006, 1200,  'SAR', DATE '2024-06-06', 'Credit Card', 'Ahmad - Mastercard **** 7741');


SELECT GuestID,RoomID,ReservationDate
FROM Reservation
ORDER BY ReservationDate ASC;


SELECT GuestID, COUNT(*) AS TotalReservations
FROM Reservation
GROUP BY GuestID
ORDER BY TotalReservations DESC;


SELECT ServiceType, COUNT(ServiceName) AS TotalServices FROM Services GROUP BY ServiceType;

SELECT Nationality, COUNT(*) AS Nationality_count FROM Guest GROUP BY Nationality HAVING COUNT(*) > 1;

SELECT *
FROM Room
WHERE Availability = 'Available';

SELECT RoomNumber, Type, PriceperNight
FROM Room
WHERE PriceperNight < 300;

SELECT *
FROM Payment
WHERE PaymentMethod = 'Credit Card';

SELECT *
FROM Payment;

SELECT Staff.Name, Staff.StaffID, Staff.JobType FROM Staff INNER JOIN Housekeeper 
ON Staff.StaffID = Housekeeper.StaffID ORDER BY Name ASC ;

SELECT * FROM Manager LEFT OUTER JOIN Staff 
ON  Staff.StaffID = Manager.StaffID
ORDER BY Start_date DESC;

SELECT Receptionist.Shift_Time, Staff.Name, Staff.Phone, Staff.Email FROM Receptionist RIGHT OUTER JOIN 
Staff ON  Receptionist.Staffid = Staff.StaffID ; 








