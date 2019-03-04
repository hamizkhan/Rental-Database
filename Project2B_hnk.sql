
spool Project3_oaa.txt;

set echo on

SET LINESIZE 150

COLUMN GenreID FORMAT a8
--#1
INSERT INTO Fee_oaa
VALUES('C',2.50);

--#2
UPDATE RentalDetail_oaa
SET FeeCode='A'
WHERE RentalID=1 AND DiskID=191;

--#3
UPDATE RentalDetail_oaa
SET FeeCode='C'
WHERE RentalID=11 AND DiskID=421;


--#4
ALTER TABLE Rating_oaa
MODIFY RatingDesc VARCHAR(45);

UPDATE Rating_oaa
SET RatingDesc='May Not be Suitable for Children Under 13'
WHERE RatingID='PG-13';

--#5
INSERT INTO Customer_oaa
VALUES((SELECT MAX(CustID)+1 FROM Customer_oaa),'Mary','Jones','2145552020');

--#6
SELECT CustID,CustFName,CustLName
FROM Customer_oaa
WHERE CustPhone IS NULL;

--#7
SELECT AVG(FeeAmt) AS "AvgFee"
FROM Fee_oaa;

--#8
SELECT COUNT(DISTINCT TitleID) AS "TitleCount"
FROM Disk_oaa;

--#9
SELECT GenreID AS "GenreID",COUNT(TitleID) AS "TitleCount"
FROM Title_oaa
GROUP BY GenreID;

--#10
SELECT R.RentalID AS "RentalID",RentalDate AS "Date",TO_CHAR(SUM(FeeAmt),  '$999.00') AS "RentalTotal"
FROM Rental_oaa R, RentalDetail_oaa RD,Fee_oaa F
WHERE R.RentalID=RD.RentalID
AND F.FeeCode=RD.FeeCode
AND R.RentalID=10
GROUP BY R.RentalID,RentalDate;

--11A
SELECT C.CustID AS "CustomerID", CustFName || ' ' || CustLName AS "CustomerName", COUNT(RentalID) AS "RentalCount"
FROM Customer_oaa C, Rental_oaa R
WHERE C.CustID = R.CustID
GROUP BY C.CustID, CustFName,CustLName
ORDER BY "RentalCount" DESC, "CustomerID" ;

  
 --11B
COLUMN FeeCode FORMAT a8

 SELECT RentalID AS "RentalID", DiskID AS "DiskID", FeeCode AS "FeeCode"
  FROM RentalDetail_oaa
 ORDER BY RentalID, DiskID ;

 --12
SELECT T.TitleID,Title, COUNT(DISTINCT FormatCode) AS "FormatCount"
FROM Title_oaa T, Disk_oaa D
WHERE T.TitleID=D.TitleID
GROUP BY T.TitleID,Title
ORDER BY "FormatCount" DESC ;

--13
SELECT CustID AS  "Customer_ID",CustFName AS "First_Name",CustLName AS "Last_Name",'(' ||SUBSTR(CustPhone, 1, 3) || ')' || SUBSTR(CustPhone, 4, 3) || '-' || SUBSTR(CustPhone, 7, 4) AS "Phone"
FROM Customer_oaa
ORDER BY CustID;

--14
SELECT RD.RentalID, G.GenreID, GenreDesc AS "Genre", T.TitleID, Title, TO_CHAR(FeeAmt,'$999.00') AS "Fee"
FROM Rental_oaa R,RentalDetail_oaa RD,Fee_oaa F, Disk_oaa D, Title_oaa T,Genre_oaa G
WHERE R.RentalID=RD.RentalID
AND RD.FeeCode=F.FeeCode
AND RD.DiskID=D.DiskID
AND D.TitleID=T.TitleID
AND T.GenreID=G.GenreID
AND FeeAmt IN (SELECT MIN(FeeAmt) FROM Fee_oaa F, RentalDetail_oaa RD
WHERE RD.FeeCode=F.FeeCode GROUP BY RD.RentalID)
ORDER BY "Fee" DESC;

--15
SELECT GenreDesc,Title,RatingID
FROM Genre_oaa G,Title_oaa T
WHERE G.GenreID=T.GenreID
ORDER BY GenreDesc,Title;

--16
SELECT GenreDesc AS "GenreName",COUNT(Title) AS "TitleCount"
FROM Genre_oaa G,Title_oaa T
WHERE G.GenreID=T.GenreID
GROUP BY GenreDesc
ORDER BY  "TitleCount" DESC;

--17
SELECT RentalID,D.DiskID,T.Title,TO_CHAR(FeeAmt,'$999.00') AS "FeeAmt"
FROM RentalDetail_oaa RD, Title_oaa T,Fee_oaa F, Disk_oaa D
WHERE F.FeeCode=RD.FeeCode
AND RD.DiskID=D.DiskID
AND D.TitleID=T.TitleID
AND FeeAmt<=2.50
ORDER BY "FeeAmt" DESC, Title;

--18
SELECT R.RentalID,TO_CHAR(RentalDate, 'MM-DD-YYYY') AS "RentalDate",C.CustID,CustFName,CustLName,COUNT(DiskID)
FROM Rental_oaa R,Customer_oaa C,RentalDetail_oaa RD
WHERE C.CustID=R.CustID
AND R.RentalID=RD.RentalID
GROUP BY R.RentalID,RentalDate,C.CustID,CustFName,CustLName
ORDER BY R.RentalID;

--19
SELECT D.DiskID AS "DiskID",Title AS "Title",RatingID AS "Rating",FormatDesc AS "Format",TO_CHAR(FeeAmt,'$999.00') AS "Fee"
FROM Disk_oaa D, Title_oaa T, Format_oaa FO, Fee_oaa FE, RentalDetail_oaa RD
WHERE D.TitleID=T.TitleID
AND FO.FormatCode=D.FormatCode
AND D.DiskID= RD.DiskID
AND FE.FeeCode=RD.FeeCode
AND RentalID=3
ORDER BY "DiskID";

--20
SELECT R.RatingID,RatingDesc,COUNT(TitleID)
FROM Rating_oaa R,Title_oaa T
WHERE R.RatingID=T.RatingID
GROUP BY R.RatingID,RatingDesc;

--21
SELECT R.RentalID,D.DiskID,T.Title,G.GenreDesc,F.FeeCode,F.FeeAmt
FROM RentalDetail_oaa RD,Fee_oaa F,Disk_oaa D,Title_oaa T,Rental_oaa R,Genre_oaa G
WHERE RD.FeeCode=F.FeeCode 
AND RD.DiskID=D.DiskID
AND D.TitleID=T.TitleID
AND T.GenreID=G.GenreID
AND RD.RentalID=R.RentalID
AND F.FeeAmt > (SELECT AVG(FeeAmt) FROM Fee_oaa,RentalDetail_oaa RD WHERE F.FeeCode = RD.FeeCode)
ORDER BY T.Title;

--22
SELECT DISTINCT T.TitleID, Title,GenreDesc,R.RatingID
FROM Title_oaa T,Genre_oaa G, Rating_oaa R,Fee_oaa F,RentalDetail_oaa RD,Disk_oaa D
WHERE T.RatingID=R.RatingID
AND T.GenreID=G.GenreID
AND RD.FeeCode=F.FeeCode
AND RD.DiskID=D.DiskID
AND T.TitleID=D.TitleID
AND F.FeeCode='B'
ORDER BY Title;

--23
SELECT R.RentalID AS "RentalID",TO_CHAR(RentalDate, 'MM-DD-YYYY') AS "Date",TO_CHAR(SUM(FeeAmt),'$999.00') AS "RentalTotal"
FROM Rental_oaa R,RentalDetail_oaa RD,Fee_oaa F
WHERE R.RentalID=RD.RentalID
AND RD.FeeCode=F.FeeCode
AND R.RentalID=3
GROUP BY R.RentalID,RentalDate;

--24
SELECT D.DiskID AS "DiskID",T.TitleID AS "TitleID",Title,F.FeeCode AS "FeeCode",TO_CHAR(FeeAmt,'$99.99') AS "FeeAmt"
FROM Disk_oaa D,Title_oaa T,RentalDetail_oaa RD,Fee_oaa F
WHERE RD.FeeCode=F.FeeCode
AND RD.DiskID=D.DiskID
AND D.TitleID=T.TitleID
AND RentalID = 10
AND T.TitleID IN (SELECT TitleID FROM Title_oaa T ,Fee_oaa F,RentalDetail_oaa RD WHERE RD.FeeCode=F.FeeCode AND D.DiskID=RD.DiskID AND FeeAmt IN (SELECT MAX(FeeAmt) FROM 
Fee_oaa GROUP BY TitleID));

--25
SELECT RentalID,RentalDate AS "RentalDate",C.CustID,CustLName,CL.ClerkID,ClerkLName
FROM Rental_oaa R,Customer_oaa C,Clerk_oaa CL
WHERE R.CustID=C.CustID
AND R.ClerkID=CL.ClerkID
AND RentalDate<'05-SEP-2017'
ORDER BY RentalDate,RentalID;

--26
SELECT D.DiskID,T.TitleID,T.Title,F.FeeAmt
FROM RentalDetail_oaa RD,Fee_oaa F,Disk_oaa D,Title_oaa T
WHERE RD.FeeCode=F.FeeCode
AND RD.DiskID=D.DiskID
AND D.TitleID=T.TitleID
AND F.FeeAmt > (SELECT AVG(FeeAmt) FROM Fee_oaa )
ORDER BY F.FeeAmt DESC,D.DiskID;

--27
SELECT C.CustID AS "Customer_ID",CustFName || ' ' || CustLName AS "Customer_Name", TO_CHAR(SUM(FeeAmt),'$999.00') AS "Fee_Total"
FROM Customer_oaa C,Rental_oaa R,RentalDetail_oaa RD,Fee_oaa F
WHERE C.CustID=R.CustID
AND R.RentalID=RD.RentalID
AND RD.FeeCode=F.FeeCode
AND C.CustID=23
GROUP BY C.CustID, CustFName,CustLName;

--28
SELECT RentalID,TO_CHAR(RentalDate, 'MM-DD-YYYY') AS "RentalDate",C.CustID,CustFName,CustLName,'(' || SUBSTR(CustPhone, 1, 3) || ')' || SUBSTR(CustPhone, 4, 3) || '-' || SUBSTR(CustPhone, 7, 4) AS "Phone"
FROM Rental_oaa R,Customer_oaa C
WHERE C.CustID=R.CustID
AND RentalDate <= ' 04-SEP-2017'
ORDER BY RentalDate,C.CustID;


--29
SELECT C.ClerkID AS "EmployeeID", ClerkFName AS "FirstName",ClerkLName AS "LastName",COUNT(RentalID) AS "RentalCount"
FROM Clerk_oaa C,Rental_oaa R
WHERE C.ClerkID=R.ClerkID
GROUP BY C.ClerkID,ClerkFName,ClerkLName HAVING COUNT(RentalID) > 1
ORDER BY "RentalCount" DESC,"EmployeeID";

--30
SELECT CustID AS "Customer_ID",CustFName AS "First_Name",CustLName AS "Last_Name"
FROM Customer_oaa
WHERE CustFName LIKE 'J%'
OR CustLName LIKE 'J%'
ORDER BY "Last_Name";


--31
SELECT CustID, CustFName AS "FirstName",CustLName AS "LastName"
FROM Customer_oaa
WHERE CustID NOT IN (SELECT CustID FROM Rental_oaa
WHERE Rental_oaa.CustID = Customer_oaa.CustID);

spool off
--stop logging
set echo off