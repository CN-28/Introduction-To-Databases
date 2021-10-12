SELECT [CompanyName], [Fax] FROM [Suppliers] WHERE fax IS NOT NULL



SELECT [OrderID], [OrderDate], [CustomerID] FROM [Orders] WHERE ShipCountry ='Argentina' AND (ShippedDate IS NULL OR GETDATE() < ShippedDate)

SELECT [CompanyName], [Country] FROM [Customers] ORDER BY Country, CompanyName

SELECT [ProductName], [UnitPrice], [CategoryID] FROM [Products] ORDER BY CategoryID, UnitPrice DESC

SELECT [CompanyName], [Country] FROM [Customers] WHERE Country in ('UK', 'Italy') ORDER BY CompanyName