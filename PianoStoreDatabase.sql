-- Start out using Master database
USE Master;
GO

-- Drop the database if it exists
IF DB_ID('PianoStore') IS NOT NULL
	DROP DATABASE PianoStore;
	GO


-- Create a new database
CREATE DATABASE PianoStore;
GO

-- Switch to new database (PianoStore)
USE PianoStore;
GO


-- Create a table for brands sold
CREATE TABLE PianoBrands (
BrandID		INT			NOT NULL IDENTITY PRIMARY KEY, 
Brand		VARCHAR(30) NOT NULL,  
YearFounded	INT			NULL
);

-- Create a table for sales associates
CREATE TABLE SalesAssociate (
AssociateID	INT			IDENTITY PRIMARY KEY NOT NULL,
FirstName	VARCHAR(10) NOT NULL,
LastName	VARCHAR(10) NOT NULL,
);

-- Create a table for customers
CREATE TABLE Customers (
CustomerID	INT			IDENTITY PRIMARY KEY NOT NULL,
FirstName	VARCHAR(10) NOT NULL,
LastName	VARCHAR(10) NOT NULL
);

-- Create a table for sales
CREATE TABLE Sales (
SaleID		INT				IDENTITY PRIMARY KEY NOT NULL,
SoldBy		INT				REFERENCES SalesAssociate(AssociateID) NOT NULL,
BrandSold	INT				REFERENCES PianoBrands(BrandID) NOT NULL,
SoldTo		INT				REFERENCES Customers(CustomerID) NOT NULL,
DateSold	SMALLDATETIME	NOT NULL,
Ammount		MONEY			NOT NULL
);

/*Insert values into PianoBrands.
You can save time and instead of typing out INSERT INTO every time, you can just seperate your values with commas*/

INSERT INTO PianoBrands (Brand, YearFounded)
VALUES ('Steinway & Sons', 1853),
	   ('Chickering', NULL),
	   ('Yamaha', 1900),
	   ('Baldwin', 1857),
	   ('Bosendorfer', NULL);

-- Insert values into Sales associates
INSERT INTO SalesAssociate (FirstName, LastName)
VALUES ('Bob', 'Morris'),
	   ('Phil', 'Lollar'),
	   ('Chris', 'Lansdown'),
	   ('Eli', 'Johnson');

--Insert values into customers
INSERT INTO Customers (FirstName, LastName)
VALUES ('Roger','Williams'),
	   ('Jim', 'Brickan'),
	   ('Vladimir', 'Horowitz'),
	   ('Wladziu', 'Liberace'),
	   ('Anthony', 'Burger');

/*Insert values into sales. 
Soldby, BrandSold, and SoldTo are foreign keys*/
INSERT INTO Sales (SoldBy, BrandSold, SoldTo, DateSold, Ammount)
VALUES (1, 2, 3, 'June 18, 2020', '123,461'),
	   (3, 1, 1, 'April 7, 2007', '165,765'),
	   (2, 4, 3, 'January 31, 1999', '213,742'),
	   (1, 5, 5, 'October 22, 2003', '121,000'),
	   (2, 2, 3, 'March 1, 2014', '100,466'),
	   (3, 3, 2, 'December 21, 2000','98,313'),
	   (1, 3, 4, 'July, 2018', '121,912'),
	   (3, 4, 1, 'January 1,2010','151,421'),
	   (3, 1, 5, 'November 20, 2012','120,999'),
	   (3, 1, 2, 'August 2,1998','140,847');

-- Alter table to add Gender column
ALTER TABLE Customers
ADD Gender VARCHAR(10);

--Insert a record with a null value
INSERT INTO Customers (FirstName, LastName, Gender)
VALUES ('Jessica', 'Parker', NULL);

-- Alter table to drop a column
ALTER TABLE PianoBrands
DROP COLUMN YearFounded;

-- Alter a table to delete a record
DELETE FROM SalesAssociate
WHERE FirstName = 'Eli';

/*Sort results by descending. 
Order by decending to see the most recent sale*/
SELECT DateSold FROM Sales
ORDER BY DateSold DESC; 

/*Sort results by ascending. 
Order be ascending to see the oldest sale*/
SELECT DateSold FROM Sales
ORDER BY DateSold ASC; 

/*Select the top 10 values from a table. 
Select top 10 to see what your top 10 biggest purchaeses were*/
SELECT TOP(10) Ammount
FROM Sales;

/*Use the IN select statement.
Would be helpful in finding a sale if you only knew the sale amount*/
Select * FROM Sales
WHERE Ammount IN (120999);

/*Select a value within a range. 
Would be helpful to see sales made over a certain amount*/
SELECT Ammount FROM Sales
Where Ammount > 130000; 

-- Include an inner join 
SELECT SalesAssociate.AssociateID, Customers.FirstName
FROM SalesAssociate
INNER JOIN Customers ON SalesAssociate.AssociateID = Customers.CustomerID;

-- Include a left join
SELECT PianoBrands.BrandID, Customers.CustomerID
FROM PianoBrands
LEFT JOIN Customers ON BrandID = CustomerID;

--Include a right join
SELECT PianoBrands.BrandID, SalesAssociate.AssociateID
FROM PianoBrands
RIGHT JOIN SalesAssociate ON BrandID = AssociateID;

/*Use the aggregate function SUM. 
This will let us see the total amount the store has made*/
SELECT SUM(Ammount) AS TotalAmmountMade FROM Sales; 

/*Use the aggregate function COUNT.
Will give a count of how many brands are sold in store.*/
SELECT COUNT(BrandID) AS NumberOfBrands FROM PianoBrands; 

/* Use the aggregate function AVG. 
Will give you the average dollar amount made.*/
SELECT AVG(Ammount) AS AverageSalePrice FROM Sales;

/*Use Group BY. 
This will allow you to see which buyer has bought which brands*/
SELECT COUNT(SoldTo)AS Buyer,BrandSold 
FROM Sales
GROUP BY BrandSold; 

-- See full name of customer without CONCAT
SELECT (FirstName + ' ' + LastName) FROM Customers
WHERE LastName = 'Horowitz'; 

-- See full name of customer using CONCAT
SELECT CONCAT(FirstName, '', LastName) FROM Customers
WHERE LastName = 'Horowitz';



