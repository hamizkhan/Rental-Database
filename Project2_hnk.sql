

spool Project2_oaa.txt;

set echo on

DROP TABLE RentalDetail_oaa;
DROP TABLE Rental_oaa;
DROP TABLE Disk_oaa;
DROP TABLE Title_oaa;
DROP TABLE Customer_oaa;
DROP TABLE Clerk_oaa;
DROP TABLE Fee_oaa;
DROP TABLE Rating_oaa;
DROP TABLE Genre_oaa;
DROP TABLE Format_oaa;

--Part 1: Create Tables

CREATE TABLE Format_oaa(
FormatCode	CHAR(1)	NOT NULL,
FormatDesc	VARCHAR(9)	NOT NULL,
PRIMARY KEY (FormatCode)
);

CREATE TABLE Genre_oaa(
GenreID	CHAR(2)	NOT NULL,
GenreDesc VARCHAR(10) NOT NULL,
PRIMARY KEY (GenreID)
);

CREATE TABLE Rating_oaa(
RatingID VARCHAR(6) NOT NULL,
RatingDesc VARCHAR(25) NOT NULL,
PRIMARY KEY (RatingID)
);

CREATE TABLE Fee_oaa(
FeeCode CHAR(1)	NOT NULL,
FeeAmt NUMBER(3,2) NOT NULL,
PRIMARY KEY (FeeCode)
);

CREATE TABLE Clerk_oaa(
ClerkID NUMBER(4) NOT NULL,
ClerkFName VARCHAR(15) NOT NULL,
ClerkLName VARCHAR (15) NOT NULL,
PRIMARY KEY (ClerkID)
);

CREATE TABLE Customer_oaa(
CustID NUMBER(5) NOT NULL,
CustFName VARCHAR(15) NOT NULL,
CustLName VARCHAR(15) NOT NULL,
CustPhone CHAR(10),
PRIMARY KEY(CustID)
);

CREATE TABLE Title_oaa(
TitleID NUMBER(4) NOT NULL,
Title VARCHAR(20) NOT NULL,
RatingID VARCHAR(6) NOT NULL,
GenreID	CHAR(2) NOT NULL,
PRIMARY KEY (TitleID),
FOREIGN KEY (RatingID) REFERENCES Rating_oaa,
FOREIGN KEY (GenreID) REFERENCES Genre_oaa
);

CREATE TABLE Disk_oaa(
DiskID NUMBER(4) NOT NULL,
TitleID NUMBER(4) NOT NULL,
FormatCode	CHAR(1)	NOT NULL,
PRIMARY KEY (DiskID),
FOREIGN KEY (TitleID) REFERENCES Title_oaa,
FOREIGN KEY (FormatCode) REFERENCES Format_oaa
);

CREATE TABLE Rental_oaa(
RentalID NUMBER(5) NOT NULL,
RentalDate Date NOT NULL,
CustID NUMBER(5) NOT NULL,
ClerkID NUMBER(4) NOT NULL,
PRIMARY KEY (RentalID),
FOREIGN KEY (CustID) REFERENCES Customer_oaa,
FOREIGN KEY (ClerkID) REFERENCES Clerk_oaa
);

CREATE TABLE RentalDetail_oaa(
RentalID NUMBER(5) NOT NULL,
DiskID NUMBER(4) NOT NULL,
FeeCode CHAR(1)	NOT NULL,
PRIMARY KEY (RentalID,DiskID),
FOREIGN KEY (RentalID) REFERENCES Rental_oaa,
FOREIGN KEY (DiskID) REFERENCES Disk_oaa,
FOREIGN KEY (FeeCode) REFERENCES Fee_oaa
);

DESCRIBE RentalDetail_oaa;
DESCRIBE Rental_oaa;
DESCRIBE Disk_oaa;
DESCRIBE Title_oaa;
DESCRIBE Customer_oaa;
DESCRIBE Clerk_oaa;
DESCRIBE Fee_oaa;
DESCRIBE Rating_oaa;
DESCRIBE Genre_oaa;
DESCRIBE Format_oaa;

--Part 2:Insert Data into the table
--Format_oaa

INSERT INTO Format_oaa
VALUES('D','DVD');

INSERT INTO Format_oaa
VALUES('B','Blue-Ray');



--Genre_oaa
INSERT INTO Genre_oaa
VALUES('AC','Action');

INSERT INTO Genre_oaa
VALUES('CL','Classics');

INSERT INTO Genre_oaa
VALUES('FM','Family');

INSERT INTO Genre_oaa
VALUES('HR','Horror');

----Rating_oaa

INSERT INTO Rating_oaa
VALUES('R','Restricted Under 17');

INSERT INTO Rating_oaa
VALUES('PG-13','Inappropriate Under 13');

INSERT INTO Rating_oaa
VALUES('PG','Parental Guidance');

INSERT INTO Rating_oaa
VALUES('G','General');

--Fee_oaa



INSERT INTO Fee_oaa
VALUES('A',3.00);

INSERT INTO Fee_oaa
VALUES('B',2.00);

--Clerk_oaa

INSERT INTO Clerk_oaa
VALUES(15,'Mary','Jones');

INSERT INTO Clerk_oaa
VALUES(21,'Mark','White');

INSERT INTO Clerk_oaa
VALUES(30,'Renee','Smith');

INSERT INTO Clerk_oaa
VALUES(12,'Tim','Shore');

INSERT INTO Clerk_oaa
VALUES(42,'Nicole','Walker');

--Customer_oaa

INSERT INTO Customer_oaa
VALUES(23,'Jean','Mackey','9725551143');

INSERT INTO Customer_oaa
VALUES(102,'Jack','Hughes','2145552014');

INSERT INTO Customer_oaa
VALUES(154,'Alicia','Moore','8175551919');

INSERT INTO Customer_oaa
VALUES(83,'Carrie','Brown',NULL);

INSERT INTO Customer_oaa
VALUES(53,'Ashleigh','Hayes','9725550628');

INSERT INTO Customer_oaa
VALUES(68,'Anthony','Smith',NULL);

INSERT INTO Customer_oaa
VALUES(72,'Shane','Wesley','8175550112');

---Title_oaa

INSERT INTO Title_oaa
VALUES(92,'Hacksaw Ridge','R','AC');

INSERT INTO Title_oaa
VALUES(76,'Wonder Woman','PG-13','AC');

INSERT INTO Title_oaa
VALUES(119,'Divergent','PG-13','AC');

INSERT INTO Title_oaa
VALUES(12,'Casa Blanca','PG','CL');

INSERT INTO Title_oaa
VALUES(29,'Despicable Me 2','PG','FM');

INSERT INTO Title_oaa
VALUES(42,'Frozen','PG','FM');

INSERT INTO Title_oaa
VALUES(58,'The Specialist','R','AC');

INSERT INTO Title_oaa
VALUES(230,'The Lone Survivor','R','AC');

INSERT INTO Title_oaa
VALUES(245,'Rio 2','G','FM');

INSERT INTO Title_oaa
VALUES(159,'Boss Baby','PG','FM');

INSERT INTO Title_oaa
VALUES(240,'Sleepy Hollow','R','HR');

INSERT INTO Title_oaa
VALUES(218,'Gone With The Wind','PG','CL');

INSERT INTO Title_oaa
VALUES(296,'The Hurt Locker','R','AC');

INSERT INTO Title_oaa
VALUES(35,'Minions','PG','FM');

--Disk_oaa

INSERT INTO Disk_oaa
VALUES(215,92,'D');

INSERT INTO Disk_oaa
VALUES(191,76,'D');

INSERT INTO Disk_oaa
VALUES(259,119,'B');

INSERT INTO Disk_oaa
VALUES(89,12,'D');

INSERT INTO Disk_oaa
VALUES(96,29,'D');

INSERT INTO Disk_oaa
VALUES(152,42,'D');

INSERT INTO Disk_oaa
VALUES(86,58,'B');

INSERT INTO Disk_oaa
VALUES(260,119,'D');

INSERT INTO Disk_oaa
VALUES(301,230,'B');

INSERT INTO Disk_oaa
VALUES(376,245,'B');

INSERT INTO Disk_oaa
VALUES(153,42,'D');

INSERT INTO Disk_oaa
VALUES(202,159,'D');

INSERT INTO Disk_oaa
VALUES(402,240,'B');

INSERT INTO Disk_oaa
VALUES(381,218,'D');

INSERT INTO Disk_oaa
VALUES(216,92,'B');

INSERT INTO Disk_oaa
VALUES(203,159,'D');

INSERT INTO Disk_oaa
VALUES(97,29,'D');

INSERT INTO Disk_oaa
VALUES(421,296,'D');

INSERT INTO Disk_oaa
VALUES(299,35,'D');


--Rental_oaa

INSERT INTO Rental_oaa
VALUES(1,'2-SEPTEMBER-2017',23,15);

INSERT INTO Rental_oaa
VALUES(2,'2-SEPTEMBER-2017',102,15);

INSERT INTO Rental_oaa
VALUES(3,'2-SEPTEMBER-2017',154,21);

INSERT INTO Rental_oaa
VALUES(4,'3-SEPTEMBER-2017',83,30);

INSERT INTO Rental_oaa
VALUES(5,'3-SEPTEMBER-2017',23,15);

INSERT INTO Rental_oaa
VALUES(6,'4-SEPTEMBER-2017',83,12);

INSERT INTO Rental_oaa
VALUES(7,'4-SEPTEMBER-2017',154,15);

INSERT INTO Rental_oaa
VALUES(8,'5-SEPTEMBER-2017',53,12);

INSERT INTO Rental_oaa
VALUES(9,'5-SEPTEMBER-2017',68,15);

INSERT INTO Rental_oaa
VALUES(10,'5-SEPTEMBER-2017',23,21);

INSERT INTO Rental_oaa
VALUES(11,'5-SEPTEMBER-2017',72,42);

--RentalDetail_oaa

INSERT INTO RentalDetail_oaa
VALUES(1,215,'A');

INSERT INTO RentalDetail_oaa
VALUES(1,191,'B');

INSERT INTO RentalDetail_oaa
VALUES(2,259,'A');

INSERT INTO RentalDetail_oaa
VALUES(3,89,'B');

INSERT INTO RentalDetail_oaa
VALUES(3,96,'B');

INSERT INTO RentalDetail_oaa
VALUES(3,152,'B');

INSERT INTO RentalDetail_oaa
VALUES(4,86,'A');

INSERT INTO RentalDetail_oaa
VALUES(5,260,'A');

INSERT INTO RentalDetail_oaa
VALUES(6,301,'A');

INSERT INTO RentalDetail_oaa
VALUES(7,376,'A');

INSERT INTO RentalDetail_oaa
VALUES(7,153,'B');

INSERT INTO RentalDetail_oaa
VALUES(8,202,'B');

INSERT INTO RentalDetail_oaa
VALUES(8,402,'A');

INSERT INTO RentalDetail_oaa
VALUES(9,381,'A');

INSERT INTO RentalDetail_oaa
VALUES(9,216,'A');

INSERT INTO RentalDetail_oaa
VALUES(10,203,'B');

INSERT INTO RentalDetail_oaa
VALUES(10,97,'A');

INSERT INTO RentalDetail_oaa
VALUES(11,376,'B');

INSERT INTO RentalDetail_oaa
VALUES(11,421,'A');

INSERT INTO RentalDetail_oaa
VALUES(11,299,'A');

COMMIT;

SELECT * FROM Format_oaa
ORDER BY FormatCode ;

SELECT * FROM Genre_oaa
ORDER BY GenreID ;

SELECT * FROM Rating_oaa
ORDER BY RatingID ;

SELECT * FROM Fee_oaa
ORDER BY FeeCode ;

SELECT * FROM Clerk_oaa
ORDER BY ClerkID ;

SELECT * FROM Customer_oaa
ORDER BY CustID ;

SELECT * FROM Title_oaa
ORDER BY TitleID ;

SELECT * FROM Disk_oaa
ORDER BY DiskID ;

SELECT * FROM Rental_oaa
ORDER BY RentalID ;

SELECT * FROM RentalDetail_oaa
ORDER BY RentalID,DiskID ;

--Part 3 [Customer]

UPDATE Customer_oaa
SET CustFName='Kerry'
WHERE CustID=83;

UPDATE Customer_oaa
SET CustPhone='2146881234'
WHERE CustID=23;

INSERT INTO Customer_oaa
VALUES(100,'Amanda','Green',NULL);

COMMIT;

--[Title]

INSERT INTO Genre_oaa
VALUES('DR','Drama');

INSERT INTO Title_oaa
VALUES(279,'Hidalgo','PG-13','DR');

--[Disk]

INSERT INTO Disk_oaa
VALUES(327,92,'D');

INSERT INTO Disk_oaa
VALUES(382,119,'B');

INSERT INTO Disk_oaa
VALUES(406,29,'D');

COMMIT;

--[Rental]

INSERT INTO Rental_oaa
VALUES(12,'6-SEPTEMBER-2017',53,15);

INSERT INTO Rental_oaa
VALUES(13,'7-SEPTEMBER-2017',100,12);

COMMIT;


UPDATE RentalDetail_oaa
SET FeeCode='B'
WHERE RentalID=1 AND DiskID=215;

INSERT INTO RentalDetail_oaa
VALUES(12,376,'A');

INSERT INTO RentalDetail_oaa
VALUES(12,406,'B');

INSERT INTO RentalDetail_oaa
VALUES(13,382,'A');

INSERT INTO RentalDetail_oaa
VALUES(13,215,'B');

INSERT INTO RentalDetail_oaa
VALUES(13,327,'A');

COMMIT;

--Part 4

SELECT * FROM Format_oaa
ORDER BY FormatCode ;

SELECT * FROM Genre_oaa
ORDER BY GenreID ;

SELECT * FROM Rating_oaa
ORDER BY RatingID ;

SELECT * FROM Fee_oaa
ORDER BY FeeCode ;

SELECT * FROM Clerk_oaa
ORDER BY ClerkID ;

SELECT * FROM Customer_oaa
ORDER BY CustID ;

SELECT * FROM Title_oaa
ORDER BY TitleID ;

SELECT * FROM Disk_oaa
ORDER BY DiskID ;

SELECT * FROM Rental_oaa
ORDER BY RentalID ;

SELECT * FROM RentalDetail_oaa
ORDER BY RentalID,DiskID ;


spool off
set echo off




















