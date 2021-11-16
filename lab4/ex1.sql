SELECT [CompanyName], [Phone] FROM [Customers]
WHERE [CustomerID] IN (SELECT [CustomerID] FROM [Orders]
                       WHERE [ShipVia] = (SELECT [ShipperID] FROM [Shippers] WHERE [CompanyName] = 'United Package')
                       AND YEAR([ShippedDate]) = 1997)
        

