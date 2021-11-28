SELECT [OrderID], [Freight] FROM [Orders] AS [O1]
WHERE [Freight] > (SELECT AVG([Freight]) FROM [Orders] AS [O2]
                   WHERE YEAR([O1].[OrderDate]) = YEAR([O2].[OrderDate]))

SELECT [O1].[OrderID], [O1].[Freight] FROM [Orders] AS [O1]
INNER JOIN [Orders] AS [O2] ON YEAR([O1].[OrderDate]) = YEAR([O2].[OrderDate])
GROUP BY [O1].[OrderID], [O1].[Freight] HAVING [O1].[Freight] > AVG([O2].[Freight])


SELECT [CustomerID] FROM [Customers]
WHERE [CustomerID] NOT IN 
(SELECT [CU].[CustomerID] FROM [Customers] AS [CU]
INNER JOIN [Orders] AS [O] ON [O].[CustomerID] = [CU].[CustomerID]
INNER JOIN [Order Details] AS [OD] ON [OD].[OrderID] = [O].[OrderID]
INNER JOIN [Products] AS [P] ON [OD].[ProductID] = [P].[ProductID]
INNER JOIN [Categories] AS [C] ON [C].[CategoryID] = [P].[CategoryID]
WHERE [CategoryName] = 'Seafood')

SELECT [CustomerID] FROM [Customers]
EXCEPT
SELECT [CU].[CustomerID] FROM [Customers] AS [CU]
INNER JOIN [Orders] AS [O] ON [O].[CustomerID] = [CU].[CustomerID]
INNER JOIN [Order Details] AS [OD] ON [OD].[OrderID] = [O].[OrderID]
INNER JOIN [Products] AS [P] ON [OD].[ProductID] = [P].[ProductID]
INNER JOIN [Categories] AS [C] ON [C].[CategoryID] = [P].[CategoryID]
WHERE [CategoryName] = 'Seafood'
GROUP BY [CU].[CustomerID]

SELECT [CustomerID] FROM [Customers] AS [CU1]
WHERE NOT EXISTS
(SELECT [CU].[CustomerID] FROM [Customers] AS [CU]
INNER JOIN [Orders] AS [O] ON [O].[CustomerID] = [CU].[CustomerID]
INNER JOIN [Order Details] AS [OD] ON [OD].[OrderID] = [O].[OrderID]
INNER JOIN [Products] AS [P] ON [OD].[ProductID] = [P].[ProductID]
INNER JOIN [Categories] AS [C] ON [C].[CategoryID] = [P].[CategoryID]
WHERE [CategoryName] = 'Seafood' AND [CU1].[CustomerID] = [CU].[CustomerID])


SELECT [CU].[CustomerID],
(SELECT TOP 1 [CategoryName] FROM [Categories] AS [C]
INNER JOIN [Products] AS [P] on [C].[CategoryID] = [P].[CategoryID]
INNER JOIN [Order Details] AS [OD] on [P].[ProductID] = [OD].[ProductID]
INNER JOIN [Orders] AS [O] on [O].[OrderID] = [OD].[OrderID]
WHERE [CU].[CustomerID] = [O].[CustomerID]
GROUP BY [P].[CategoryID], [C].[CategoryName]
ORDER BY COUNT([O].[OrderID]) DESC)
FROM [Customers] AS [CU]
ORDER BY 1