-- 1. Create Databases
CREATE DATABASE Brands;
CREATE DATABASE Products;

-- 2. Create ITEMS_TABLE in Brands Database
USE Brands;
CREATE TABLE ITEMS_TABLE (
    Item_Id INT PRIMARY KEY,
    item_description VARCHAR(255),
    vendor_nos INT,
    vendor_name VARCHAR(255),
    bottle_size INT,
    bottle_price DECIMAL(10, 2)
);


-- 2. Create PRODUCT_TABLE (referred to as PRODUCTS_SALES_TABLE later) in Products Database
USE Products;
CREATE TABLE PRODUCTS_SALES_TABLE (
    Product_Id INT,
    Country VARCHAR(50),
    Product VARCHAR(50),
    Units_Sold FLOAT,
    Manufacturing_Price DECIMAL(10, 2),
    Sale_Price DECIMAL(10, 2),
    Gross_Sales DECIMAL(10, 2),
    Sales DECIMAL(10, 2),
    COGS DECIMAL(10, 2),
    Profit DECIMAL(10, 2),
    Date DATE,
    Month_Number INT,
    Month_Name VARCHAR(20),
    Year INT
);

-- 3. Inserting Records into ITEMS_TABLE
INSERT INTO Brands.dbo.ITEMS_TABLE VALUES 
(1, 'Travis Hasse Apple Pie', 305, 'Mhw Ltd', 750, 9.77),
(2, 'Daristi Xtabentun', 391, 'Anchor Distilling (preless imports)', 750, 14.12),
(3, 'Hiram Walker Peach Brandy', 370, 'Pernod Ricard Usa/austin Nichols', 1000, 6.50),
(4, 'Oak Cross Whisky', 305, 'Mhw Ltd', 750, 25.33),
(5, 'Uv Red (Cherry) Vodka', 380, 'Phillips Beverage Company', 200, 1.97),
(6, 'Heaven Hill Old Style White Label', 259, 'Heaven Hill Distilleries Inc.', 750, 6.37),
(7, 'Hyde Herbal Liqueur', 194, 'Fire Tail Brands LIc', 750, 5.06),
(8, 'Dupont Calvados Fine Reserve', 403, 'Robert Kacher Selections', 750, 23.61);


-- 3. Inserting Sample Records into PRODUCTS_SALES_TABLE (Note: In the PDF, the Date column years were mismatched with the Year column, so I updated them myself.)
INSERT INTO Products.dbo.PRODUCTS_SALES_TABLE VALUES
(1, 'Canada',  'Carretera', 1618.5, 3, 20, 32370, 32370, 16185, 16185, '2014-01-01', 1, 'January', 2014),
(2, 'Germany', 'Carretera', 1321,   3, 20, 26420, 26420, 13210, 13210, '2015-01-01', 1, 'January', 2015),
(3, 'France',  'Carretera', 2178,   3, 15, 32670, 32670, 21780, 10890, '2016-06-01', 6, 'June',    2016),
(4, 'Germany', 'Carretera', 888,    3, 15, 13320, 13320, 8880,  4440,  '2017-06-01', 6, 'June',    2017),
(5, 'Mexico',  'Carretera', 2470,   3, 15, 37050, 37050, 24700, 12350, '2018-06-01', 6, 'June',    2018),
(6, 'Germany', 'Carretera', 1513,   3, 350, 529550,529550,393380,136170,'2019-12-01',12,'December',2019),
(7, 'Germany', 'Montana',   921,    5, 15, 13815, 13815, 9210,  4605,  '2020-03-01', 3, 'March',   2020),
(8, 'Canada',  'Montana',   2518,   5, 12, 30216, 30216, 7554,  22662, '2021-06-01', 6, 'June',    2021);

-- Q4. Delete products with specific Units Sold (1618.5, 888, 2470).
DELETE FROM PRODUCTS_SALES_TABLE 
WHERE Units_Sold IN (1618.5, 888, 2470);

-- Q5. Select all records
SELECT * FROM Brands.dbo.ITEMS_TABLE;

-- Q6. Select specific columns
SELECT item_description, bottle_price FROM Brands.dbo.ITEMS_TABLE;

-- Q7. Filter where price > 20
SELECT item_description, bottle_price 
FROM Brands.dbo.ITEMS_TABLE 
WHERE bottle_price > 20;

-- Q8. Unique Countries
SELECT DISTINCT Country FROM PRODUCTS_SALES_TABLE;

-- Q9. Count of Countries (Total rows, or distinct? Usually means Distinct in business context)
SELECT COUNT(DISTINCT Country) AS NumberOfCountries FROM PRODUCTS_SALES_TABLE;

-- Q10. Countries with Sale Price between 10 and 20
SELECT COUNT(DISTINCT Country) 
FROM PRODUCTS_SALES_TABLE 
WHERE Sale_Price BETWEEN 10 AND 20;

--  Intermediate Questions

-- Q1. Total Sale Price and Gross Sales
SELECT SUM(Sale_Price) as Total_Sale_Price, SUM(Gross_Sales) as Total_Gross_Sales 
FROM PRODUCTS_SALES_TABLE;

-- Q2. Year with highest sales
SELECT TOP 1 Year, SUM(Sales) as Total_Sales 
FROM PRODUCTS_SALES_TABLE 
GROUP BY Year 
ORDER BY Total_Sales DESC;

-- Q3. Product with specific sales amount
SELECT Product FROM PRODUCTS_SALES_TABLE WHERE Sales = 37050.00;

-- Q4. Countries with profit between range
SELECT DISTINCT Country 
FROM PRODUCTS_SALES_TABLE 
WHERE Profit BETWEEN 4605 AND 22662;

-- Q5. Product ID with specific sales amount (Note: Used COGS because it is the only entry with an amount of 24,700.)
SELECT Product_Id FROM PRODUCTS_SALES_TABLE WHERE COGS = 24700.00;

-- Q6. Total Units Sold per Country
SELECT Country, SUM(Units_Sold) as Total_Units 
FROM PRODUCTS_SALES_TABLE 
GROUP BY Country;

-- Q7. Average Sales per Country
SELECT Country, AVG(Sales) as Avg_Sales 
FROM PRODUCTS_SALES_TABLE 
GROUP BY Country;

-- Q9. Max Profit
SELECT MAX(Profit) FROM PRODUCTS_SALES_TABLE;

-- Q10. Records with Profit > Average Profit (Subquery)
SELECT * FROM PRODUCTS_SALES_TABLE 
WHERE Profit > (SELECT AVG(Profit) FROM PRODUCTS_SALES_TABLE);

-- Q11. item_description having the bottle size of 750
SELECT item_description
FROM Brands.dbo.ITEMS_TABLE
WHERE bottle_size = 750;

-- Q12. vendor Name having the vendor_nos 305 , 380 , 391
SELECT vendor_nos, vendor_name
FROM Brands.dbo.ITEMS_TABLE
WHERE vendor_nos IN (385, 380, 391);

-- Q13. Total Bottle Price
SELECT SUM(bottle_price) FROM Brands.dbo.ITEMS_TABLE;

-- Q14. Make Primary Key (DDL) (as we already defined Item_ID as a Primary Key so it shows error)
ALTER TABLE ITEMS_TABLE ADD CONSTRAINT PK_Item_ID PRIMARY KEY (Item_Id);

-- Q15. item id having the bottle_price of $ 5.06
SELECT Item_Id
FROM Brands.dbo.ITEMS_TABLE
WHERE bottle_price = 5.06;

-- Advance Questions:

-- Q1. INNER JOIN
SELECT * FROM Brands.dbo.ITEMS_TABLE I
INNER JOIN Products.dbo.PRODUCTS_SALES_TABLE P ON I.Item_Id = P.Product_Id;

-- FULL OUTER JOIN
SELECT * FROM Brands.dbo.ITEMS_TABLE I
FULL OUTER JOIN Products.dbo.PRODUCTS_SALES_TABLE P ON I.Item_Id = P.Product_Id;

SELECT * FROM Brands.dbo.ITEMS_TABLE I
LEFT JOIN Products.dbo.PRODUCTS_SALES_TABLE P ON I.Item_Id = P.Product_Id;

-- Q2. item_description and Product having the gross sales of 13,320.00
SELECT I.item_description, P.Product
FROM Brands.dbo.ITEMS_TABLE I
INNER JOIN Products.dbo.PRODUCTS_SALES_TABLE P ON I.Item_Id = P.Product_Id
WHERE P.Gross_Sales = 13320;

--Q3. Split the Item_description Column into Columns Item_desc1 and Item_desc2
SELECT 
    SUBSTRING(item_description, 1, CHARINDEX(' ', item_description) - 1) AS Item_desc1,
    SUBSTRING(item_description, CHARINDEX(' ', item_description) + 1, LEN(item_description)) AS Item_desc2
FROM Brands.dbo.ITEMS_TABLE;

-- Q4. Top 3 Expensive Items.
SELECT TOP 3 * FROM brands.dbo.ITEMS_TABLE ORDER BY bottle_price DESC;

-- Q5. total Gross Sales and Profit for each Product in each Country.
SELECT Country, Product, SUM(Gross_Sales) as Total_Gross, SUM(Profit) as Total_Profit
FROM PRODUCTS_SALES_TABLE
GROUP BY Country, Product;

-- Q6. vendor_name and item_description of items with a bottle_size of 750 and bottle_price less than 10.
SELECT vendor_name, item_description
FROM Brands.dbo.ITEMS_TABLE 
WHERE bottle_size = 750 and bottle_price < 10;

-- Q7. Product with the highest Profit in 2019.
SELECT TOP 1 Product, Profit
FROM PRODUCTS_SALES_TABLE
WHERE year = 2019
ORDER BY Profit DESC;

-- Q8. Product_Id and Country of all records where the Profit is at least twice the COGS.
SELECT Product_Id, Country
FROM PRODUCTS_SALES_TABLE
WHERE Profit >= (2*COGS);

-- Q9. Country that had the highest total Gross Sales in 2018
SELECT TOP 1 Country, SUM(Gross_Sales) AS Total_Gross_Sales
FROM PRODUCTS_SALES_TABLE
WHERE year = 2018
GROUP BY Country
ORDER BY Total_Gross_Sales DESC;

-- Q10. Calculate the total Sales for each Month Name across all years
SELECT 
    Month_Name,
    SUM(Gross_Sales) AS Total_Sales
FROM Products.dbo.PRODUCTS_SALES_TABLE
GROUP BY Month_Name
ORDER BY CASE Month_Name
    WHEN 'January' THEN 1
    WHEN 'February' THEN 2
    WHEN 'March' THEN 3
    WHEN 'April' THEN 4
    WHEN 'May' THEN 5
    WHEN 'June' THEN 6
    WHEN 'July' THEN 7
    WHEN 'August' THEN 8
    WHEN 'September' THEN 9
    WHEN 'October' THEN 10
    WHEN 'November' THEN 11
    WHEN 'December' THEN 12
END;

-- Q11. item_description and vendor_name for items whose vendor_nos exists more than once in the ITEMS_TABLE table
SELECT item_description, vendor_name
FROM Brands.dbo.ITEMS_TABLE
WHERE vendor_nos IN (
SELECT vendor_nos
FROM Brands.dbo.ITEMS_TABLE
GROUP BY vendor_nos
HAVING COUNT(*) > 1);

-- Q12. Find the average Manufacturing Price for Product in each Country and only include those Country and Product combinations where the average is above 3
SELECT Country, Product, AVG(Manufacturing_Price) as Avg_Mfg_Price
FROM PRODUCTS_SALES_TABLE
GROUP BY Country, Product
HAVING AVG(Manufacturing_Price) > 3;

-- Super-Advance Questions

-- Q1. Find the item_description and bottle_price of items that have the same vendor_name as items with Item_Id 1.
SELECT item_description, bottle_price
FROM Brands.dbo.ITEMS_TABLE
WHERE vendor_name = (
SELECT vendor_name
FROM Brands.dbo.ITEMS_TABLE
WHERE Item_Id = 1);

-- Q2. Create a stored procedure to retrieve all records from the ITEMS_TABLE table where bottle_price is greater than a given value

CREATE PROCEDURE GetExpensiveItems (@PricePoint DECIMAL(10,2))
AS
BEGIN
    SELECT * FROM Brands.dbo.ITEMS_TABLE WHERE bottle_price > @PricePoint;
END;

EXEC GetExpensiveItems 10.00;

-- Q3. Create a stored procedure to insert a new record into the product_sales table.

CREATE PROCEDURE InsertProductSale
    @ProductId INT,
    @Country VARCHAR(50),
    @Product VARCHAR(50),
    @UnitsSold FLOAT,
    @MfgPrice INT,
    @SalePrice INT,
    @GrossSales FLOAT,
    @Sales FLOAT,
    @COGS FLOAT,
    @Profit FLOAT,
    @SaleDate DATE,
    @MonthNum INT,
    @MonthName VARCHAR(20),
    @Year INT
AS
BEGIN
    INSERT INTO PRODUCTS_SALES_TABLE (
        Product_Id, Country, Product, [Units Sold], [Manufacturing Price], 
        [Sale Price], [Gross Sales], Sales, COGS, Profit, Date, 
        [Month Number], [Month Name], Year
    )
    VALUES (
        @ProductId, @Country, @Product, @UnitsSold, @MfgPrice, 
        @SalePrice, @GrossSales, @Sales, @COGS, @Profit, @SaleDate, 
        @MonthNum, @MonthName, @Year
    );
END;

-- Execute the procedure with a random example record
EXEC InsertProductSale
    @ProductId = 101,
    @Country = 'India',
    @Product = 'Smartphone',
    @UnitsSold = 150.5,
    @MfgPrice = 200,
    @SalePrice = 300,
    @GrossSales = 45150.0,
    @Sales = 45000.0,
    @COGS = 30000.0,
    @Profit = 15000.0,
    @SaleDate = '2025-12-29',
    @MonthNum = 12,
    @MonthName = 'December',
    @Year = 2025;

-- Q4. Create a trigger to automatically update the Gross_Sales field in the product_sales table whenever Units_Sold or Sale_Price is updated.CREATE TRIGGER trg_UpdateGrossSales
ON PRODUCTS_SALES_TABLE
AFTER UPDATE
AS
BEGIN
    -- Check if relevant columns were updated
    IF UPDATE([Units_Sold]) OR UPDATE([Sale_Price])
    BEGIN
        UPDATE PRODUCTS_SALES_TABLE
        SET [Gross_Sales] = i.[Units_Sold] * i.[Sale_Price]
        FROM PRODUCTS_SALES_TABLE t
        INNER JOIN inserted i ON t.Product_Id = i.Product_Id;
    END
END;

-- Q5. Write a query to find all item_description in the ITEMS_TABLE table that contain the word "Whisky" regardless of case.
SELECT item_description
FROM Brands.dbo.ITEMS_TABLE
WHERE LOWER(item_description) LIKE '%whisky%';

-- Q6. Write a query to find the Country and Product where the Profit is greater than the average Profit of all products.SELECT Country, Product, Profit
FROM PRODUCTS_SALES_TABLE
WHERE Profit > (
    SELECT AVG(Profit) 
    FROM PRODUCTS_SALES_TABLE
);

-- Q7. Write a query to join the ITEMS_TABLE and product_sales tables on a common field (e.g., vendor_nos) and select relevant fields from both tables.SELECT 
    I.item_description, 
    I.vendor_name, 
    S.Sales, 
    S.Profit
FROM Brands.dbo.ITEMS_TABLE I
INNER JOIN PRODUCTS_SALES_TABLE S 
    ON I.Item_Id = S.Product_Id; 

-- Q8. Write a query to combine item_description and vendor_name into a single string for each record in the ITEMS_TABLE table, separated by a hyphen

SELECT CONCAT(item_description, ' - ', vendor_name) AS Item_Vendor_Details
FROM Brands.dbo.ITEMS_TABLE;

-- Q9. Write a query to display the bottle_price rounded to one decimal place for each record in the ITEMS_TABLE table.

SELECT 
    item_description, 
    ROUND(bottle_price, 1) AS Rounded_Price
FROM Brands.dbo.ITEMS_TABLE;

--Q10. Write a query to calculate the number of days between the current date and the Date field for each record in the product_sales table

SELECT 
    Product_Id, 
    Date AS Sale_Date, 
    DATEDIFF(day, Date, GETDATE()) AS Days_Since_Sale
FROM PRODUCTS_SALES_TABLE;

