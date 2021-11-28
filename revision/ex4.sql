SELECT [M].[member_no], COUNT([LH].[member_no]) +
ISNULL((SELECT COUNT([LH1].[member_no]) FROM [juvenile] AS [J1]
INNER JOIN [loanhist] AS [LH1] ON [LH1].[member_no] = [J1].[member_no]
WHERE [M].[member_no] = [J1].[adult_member_no]
GROUP BY [J1].[adult_member_no]), 0)
FROM [member] AS [M]
LEFT OUTER JOIN [loanhist] AS [LH] ON [LH].[member_no] = [M].[member_no]
WHERE [M].[member_no] IN (SELECT [A].[member_no] FROM [adult] AS [A]
                      INNER JOIN [juvenile] AS [J] ON [A].[member_no] = [J].[adult_member_no]
                      WHERE [state] = 'AZ'
                      GROUP BY [A].[member_no] HAVING COUNT([J].[member_no]) > 2
                      UNION
                      SELECT [A].[member_no] FROM [adult] AS [A]
                      INNER JOIN [juvenile] AS [J] ON [A].[member_no] = [J].[adult_member_no]
                      WHERE [state] = 'CA'
                      GROUP BY [A].[member_no] HAVING COUNT([J].[member_no]) > 3)
GROUP BY [M].[member_no] ORDER BY 1


SELECT TOP 1 [T].[author] FROM [juvenile] AS [J]
INNER JOIN [loanhist] AS [LH] ON [J].[member_no] = [LH].[member_no]
INNER JOIN [title] AS [T] ON [T].[title_no] = [LH].[title_no]
INNER JOIN [adult] AS [A] ON [A].[member_no] = [J].[adult_member_no]
WHERE YEAR([LH].[out_date]) = 2001 AND [A].[state] = 'AZ'
GROUP BY [T].[author] ORDER BY COUNT([isbn]) DESC

-- do dokokczenia
SELECT [LH].[title_no], [J].[member_no], [A].[member_no] FROM [adult] AS [A]
INNER JOIN [loanhist] AS [LH] ON [LH].[member_no] = [A].[member_no]
INNER JOIN [juvenile] AS [J] ON [A].[member_no] = [J].[adult_member_no]
WHERE YEAR([out_date]) = 2001
GROUP BY [LH].[title_no], [A].[member_no], [J].[member_no]
INTERSECT
SELECT [LH].[title_no], [J].[member_no], [J].[adult_member_no] FROM [juvenile] AS [J]
INNER JOIN [loanhist] AS [LH] ON [LH].[member_no] = [J].[member_no]
WHERE YEAR([out_date]) = 2001
GROUP BY [LH].[title_no], [J].[member_no], [J].[adult_member_no]
