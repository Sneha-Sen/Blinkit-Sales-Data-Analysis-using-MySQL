create database blinkitdb;
use blinkitdb;
select * from blinkit;
select count(*) from blinkit;

-- Data Cleaning
UPDATE blinkit
SET ItemFatContent = 
    CASE 
        WHEN ItemFatContent IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN ItemFatContent = 'reg' THEN 'Regular'
        ELSE ItemFatContent
    END;
SELECT DISTINCT ItemFatContent FROM blinkit;

-- Total Sales
SELECT Round((SUM(TotalSales) / 1000000.0) ,2) AS Total_Sales_Million
FROM blinkit;

-- AVERAGE SALES
SELECT ROUND(AVG(TotalSales) ,0) AS Avg_Sales
FROM blinkit;

-- NO OF ITEMS
SELECT COUNT(*) AS No_of_Orders
FROM blinkit;

-- AVG RATING
SELECT Round(AVG(Rating),1) AS Avg_Rating
FROM blinkit;

-- Total Sales by Fat Content
SELECT ItemFatContent, ROUND(SUM(TotalSales) ,2) AS Total_Sales
FROM blinkit
GROUP BY ItemFatContent;

-- Total Sales by Item Type
SELECT ItemType, ROUND(SUM(TotalSales) ,2) AS Total_Sales
FROM blinkit
GROUP BY ItemType
ORDER BY Total_Sales DESC;

-- Fat Content by Outlet for Total Sales
SELECT 
    OutletLocationType,
    ROUND(SUM(CASE WHEN ItemFatContent = 'Low Fat' THEN TotalSales ELSE 0 END), 2) AS Low_Fat,
    ROUND(SUM(CASE WHEN ItemFatContent = 'Regular' THEN TotalSales ELSE 0 END), 2) AS Regular
FROM blinkit
GROUP BY OutletLocationType
ORDER BY OutletLocationType;

-- Total Sales by Outlet Establishment
SELECT OutletEstablishmentYear, ROUND(SUM(TotalSales),2) AS Total_Sales
FROM blinkit
GROUP BY OutletEstablishmentYear
ORDER BY OutletEstablishmentYear;

-- Percentage of Sales by Outlet Size
SELECT 
    OutletSize,
    ROUND(SUM(TotalSales), 2) AS Total_Sales,
    ROUND(SUM(TotalSales) * 100 / (SELECT SUM(TotalSales) FROM blinkit), 2) AS Sales_Percentage
FROM blinkit
GROUP BY OutletSize
ORDER BY Total_Sales DESC;

-- Sales by Outlet Location
SELECT OutletLocationType, ROUND(SUM(TotalSales),2) AS Total_Sales
FROM blinkit
GROUP BY OutletLocationType
ORDER BY Total_Sales DESC;

-- All Metrics by Outlet Type:
SELECT 
    OutletType,
    ROUND(SUM(TotalSales), 2) AS Total_Sales,
    ROUND(AVG(TotalSales), 0) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    ROUND(AVG(Rating), 2) AS Avg_Rating,
    ROUND(AVG(ItemVisibility), 2) AS Item_Visibility
FROM blinkit
GROUP BY OutletType
ORDER BY Total_Sales DESC;

