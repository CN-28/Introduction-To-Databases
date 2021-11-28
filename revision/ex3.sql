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


