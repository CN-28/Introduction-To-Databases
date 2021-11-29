SELECT [CAT1].[CategoryName], MONTH([O1].[OrderDate]) AS [Month],
SUM((1 - [OD1].[Discount]) * [OD1].[UnitPrice] * [OD1].[Quantity]) AS [Profit] FROM [Categories] AS [CAT1]
INNER JOIN [Products] AS [P1] ON [P1].[CategoryID] = [CAT1].[CategoryID]
INNER JOIN [Order Details] AS [OD1] ON [P1].[ProductID] = [OD1].[ProductID]
INNER JOIN [Orders] AS [O1] ON [O1].[OrderID] = [OD1].[OrderID]
WHERE YEAR([O1].[OrderDate]) = 1997 AND 
[CAT1].[CategoryName] IN (SELECT TOP 1 [CAT].[CategoryName] FROM [Categories] AS [CAT]
                          INNER JOIN [Products] AS [P] ON [P].[CategoryID] = [CAT].[CategoryID]
                          INNER JOIN [Order Details] AS [OD] ON [P].[ProductID] = [OD].[ProductID]
                          INNER JOIN [Orders] AS [O] ON [O].[OrderID] = [OD].[OrderID]
                          WHERE YEAR([O].[OrderDate]) = 1997
                          GROUP BY [CAT].[CategoryName]
                          ORDER BY SUM((1 - [OD].[Discount]) * [OD].[UnitPrice] * [OD].[Quantity]) DESC)
GROUP BY [CAT1].[CategoryName], MONTH([O1].[OrderDate])


-- 3


