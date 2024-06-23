-- Supplier Analysis
-- #1 Defect Cost
CREATE TABLE SupplierPerformance
SELECT `Supplier name`, SUM(`Order quantities`) as TotalOrderQuantity, ROUND(SUM(`Manufacturing costs`)/ SUM(`Order quantities`),2) as ManufacturingCostPerOrder , 
ROUND(ROUND(SUM(`Defect rates`),2)*SUM(`Order quantities`)/(ROUND(SUM(`Manufacturing costs`)/ SUM(`Order quantities`),2)),2) as TotalDefectCost,ROUND(avg(`Lead times`) - avg(`Shipping times`),2) as AverageLeadtimeRequired, ROUND(avg(`Manufacturing lead time`),2) as ManufacturingLeadtime,
ROUND(avg(`Lead times`) - avg(`Shipping times`)-avg(`Manufacturing lead time`)) as TimeDelay
FROM dataset
GROUP BY `Supplier name`
Order by `Supplier name` DESC
-- > Supplier 1 has the highest defect cost, supplier 3 the lowest

-- #2 Lead time
SELECT `Supplier name`, ROUND(avg(`Lead times`) - avg(`Shipping times`),2) as AverageLeadtimeRequired, ROUND(avg(`Manufacturing lead time`),2) as ManufacturingLeadtime,
ROUND(avg(`Lead times`) - avg(`Shipping times`)-avg(`Manufacturing lead time`)) as TimeDelay
FROM dataset
GROUP BY `Supplier name`
Order by `Supplier name`
-- > Supplier 5 has the longest TimeDelay of 8 days, then Supplier 3 of 6 days, while Supplier 1 has the shortest


-- #2 Transport Cost Analysis
-- Type of Transport
CREATE TABLE Transport
SELECT `Transportation modes`, Avg(`Shipping times`) as AverageShippingTime, ROUND(Avg(`Shipping costs`),2) as AverageShippingCost 
FROM dataset
GROUP BY `Transportation modes`
-- > Road Transport has the shortest Shipping Time

SELECT `Supplier name`, COUNT(`Transportation modes`= 'Road') as NumberRoadTransport FROM dataset
GROUP BY `Supplier name`
Order by NumberRoadTransport DESC

-- > Road Transport is mostly used by Supplier 1
-- > Solution for reducing Time delay for Supplier 5 & 3 : changing to Road Transport or Safety stock planning

-- Transport Cost

SELECT `Transportation modes`, ROUND(Avg(`Shipping costs`),2) as AverageShippingCost from Dataset
GROUP BY `Transportation modes`
Order by AverageShippingCost DESC
-- > Air Transport has the highest AverageShippingCost, while Sea Transport has the lowest

-- Number of Road Transport by Routes
SELECT Routes, COUNT(*) as NumberRoadTransport FROM dataset
WHERE `Transportation modes`= 'Road'
GROUP BY Routes
Order By NumberRoadTransport DESC
-- > Route B is mostly used in Road Transport

-- Number of Air Transport by Routes
SELECT Routes, COUNT(*) as NumberAirTransport FROM dataset
WHERE `Transportation modes`= 'Air'
GROUP BY Routes
Order By NumberAirTransport DESC
-- > Route A is mostly used in Air Transport

-- Number of Sea Transport by Routes
SELECT Routes, COUNT(*) as NumberSeaTransport FROM dataset
WHERE `Transportation modes`= 'Sea'
GROUP BY Routes
Order By NumberSeaTransport DESC
-- > Route A is mostly used in Sea Transport

-- Number of Sea Transport by Routes
SELECT Routes, COUNT(*) as NumberRailTransport FROM dataset
WHERE `Transportation modes`= 'Rail'
GROUP BY Routes
Order By NumberRailTransport DESC
-- > Route A is mostly used in Rail Transport

SELECT Routes, COUNT(*) as NumberTransport, round(sum(Costs)) as TotalCost, Avg(`Shipping times`) as AverageShippingTime FROM dataset
GROUP BY Routes
Order by Routes



SELECT Routes, ROUND(Avg(Costs),2) as AverageCostbyRoutes from dataset
Group by Routes
Order by AverageCostbyRoutes 
-- > ROUTE A has the lowest Average Cost, while Route C has the highest

-- # 3 Inventory Analysis

-- > Total of each cost:


-- StockoutRate by SKU



SELECT `Supplier name`, SKU, `Stock levels`-Availability  as 'StockShortage', `Number of products sold` FROM dataset
Order by `Supplier name`



SELECT `﻿Product type`, sum( `Number of products sold`) as TotalProductsSold from dataset
GROUP BY(`﻿Product type`)
-- > Skincare is best sold

SELECT `﻿Product type`, sum(Availability) as Availability, sum(`Stock levels`) as StockLevels, Round((Sum(Availability)-Sum(`Stock levels`))/sum(`Stock levels`),2) as AvailableRate  from dataset
GROUP By `﻿Product type`
-- > Shortage products of comestics & haircare, excessive stock of skincare products


SELECT `Supplier name`, sum(`Order quantities`) as HaircareOrderQuantity from dataset
Where `﻿Product type`= 'haircare'
Group by `Supplier name`
Order by sum(`Order quantities`) DESC
-- > Supplier 4 take care of highest haircare OrderQuantity

SELECT `Supplier name`, sum(`Order quantities`) as cosmeticsOrderQuantity from dataset
Where `﻿Product type`= 'cosmetics'
Group by `Supplier name`
Order by sum(`Order quantities`) DESC

-- > Supplier 1 takes care of highest cosmetics OrderQuantity

SELECT `Supplier name`, sum(`Order quantities`) as SkincareOrderQuantity from dataset
Where `﻿Product type`= 'skincare'
Group by `Supplier name`
Order by sum(`Order quantities`) DESC

-- > Supplier 1 takes care of highest skincare OrderQuantity


-- > SOLUTION 1: SAFETY STOCK PLANNING

			
