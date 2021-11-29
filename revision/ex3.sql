SELECT [CompanyName], YEAR([ShippedDate]) AS [Year], MONTH([ShippedDate]) AS [Month], SUM([Freight]) AS [Sum of freight] FROM [Customers] AS [C]
INNER JOIN [Orders] AS [O] ON [O].[CustomerID] = [C].[CustomerID]
GROUP BY [CompanyName], YEAR([ShippedDate]), MONTH([ShippedDate])


SELECT [CU1].[CustomerID], (SELECT TOP 1 [C].[CategoryName] FROM [Customers] AS [CU]
INNER JOIN [Orders] AS [O] ON [O].[CustomerID] = [CU].[CustomerID]
INNER JOIN [Order Details] AS [OD] ON [OD].[OrderID] = [O].[OrderID]
INNER JOIN [Products] AS [P] ON [P].[ProductID] = [OD].[ProductID]
INNER JOIN [Categories] AS [C] ON [P].[CategoryID] = [C].[CategoryID]
WHERE YEAR([OrderDate]) = 1997 AND [CU1].[CustomerID] = [CU].[CustomerID]
GROUP BY [CU].[CustomerID], [C].[CategoryName]
order by COUNT([C].[CategoryID]) DESC) FROM [Customers] AS [CU1]


-- 3

SELECT [CategoryName], COUNT([S].[ShipperID]) FROM [Categories] AS [C]
INNER JOIN [Products] AS [P] ON [P].[CategoryID] = [C].[CategoryID]
INNER JOIN [Order Details] AS [OD] ON [OD].[ProductID] = [P].[ProductID]
INNER JOIN [Orders] AS [O] ON [O].[OrderID] = [OD].[OrderID]
INNER JOIN [Shippers] AS [S] ON [S].[ShipperID] = [O].[ShipVia]
WHERE YEAR([O].[ShippedDate]) = 1997 AND MONTH([O].[ShippedDate]) = 12
GROUP BY [CategoryName]
INTERSECT
SELECT [C1].[CategoryName], COUNT ([S1].[ShipperID]) FROM [Orders] AS [O1]
INNER JOIN [Shippers] AS [S1] ON [S1].[ShipperID] = [O1].[ShipVia]
INNER JOIN [Order Details] AS [OD1] ON [OD1].[OrderID] = [O1].[OrderID]
INNER JOIN [Products] AS [P1] ON [P1].[ProductID] = [OD1].[ProductID]
INNER JOIN [Categories] AS [C1] ON [C1].[CategoryID] = [P1].[CategoryID]
WHERE YEAR([O1].[ShippedDate]) = 1997 AND MONTH([O1].[ShippedDate]) = 12
AND [S1].[CompanyName] = 'United Package' GROUP BY [C1].[CategoryName]


-- 4

SELECT [C1].[CustomerID], [CAT1].[CategoryName] FROM [Customers] AS [C1]
INNER JOIN [Orders] AS [O1] ON [C1].[CustomerID] = [O1].[CustomerID]
INNER JOIN [Order Details] AS [OD1] ON [OD1].[OrderID] = [O1].[OrderID]
INNER JOIN [Products] AS [P1] ON [P1].[ProductID] = [OD1].[ProductID]
INNER JOIN [Categories] AS [CAT1] ON [CAT1].[CategoryID] = [P1].[CategoryID]
WHERE YEAR([O1].[OrderDate]) = 1997 AND MONTH([O1].[OrderDate]) = 3 AND
[C1].[CustomerID] IN (SELECT [C].[CustomerID] FROM [Customers] AS [C]
                      INNER JOIN [Orders] AS [O] ON [C].[CustomerID] = [O].[CustomerID]
                      INNER JOIN [Order Details] AS [OD] ON [OD].[OrderID] = [O].[OrderID]
                      INNER JOIN [Products] AS [P] ON [P].[ProductID] = [OD].[ProductID]
                      INNER JOIN [Categories] AS [CAT] ON [CAT].[CategoryID] = [P].[CategoryID]
                      WHERE YEAR([O].[OrderDate]) = 1997 AND MONTH([O].[OrderDate]) = 3
                      GROUP BY [C].[CustomerID] HAVING COUNT([P].[CategoryID]) = 1)