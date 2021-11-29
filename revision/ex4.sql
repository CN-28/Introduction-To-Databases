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



SELECT [M].[firstname], [M].[lastname], (SELECT [firstname] + ' ' + [lastname] FROM [member] AS [M1]
                                         INNER JOIN [adult] AS [A1] ON [A1].[member_no] = [M1].[member_no]
                                         WHERE [J].[adult_member_no] = [A1].[member_no]), 
COUNT(DISTINCT [LH].[title_no]) + (SELECT COUNT(DISTINCT [LH2].[title_no]) FROM [adult] AS [A2]
                          INNER JOIN [loanhist] AS [LH2] ON [A2].[member_no] = [LH2].[member_no]
                          WHERE YEAR([LH2].[out_date]) = 2001 AND [A2].[member_no] = [J].[adult_member_no]),
CONCAT([A].[street], ' ', [A].[city], ' ', [A].[state], ' ', [A].[zip])
FROM [juvenile] AS [J]
INNER JOIN [adult] AS [A] ON [A].[member_no] = [J].[adult_member_no]
INNER JOIN [member] AS [M] ON [M].[member_no] = [J].[member_no]
INNER JOIN [loanhist] AS [LH] ON [LH].[member_no] = [J].[member_no]
WHERE YEAR([out_date]) = 2001
GROUP BY [M].[member_no], [M].[firstname], [M].[lastname], [J].[adult_member_no], [A].[street], [A].[city], [A].[state], [A].[zip]



SELECT [J].[member_no], [A].[street] + ' ' + [A].[city] + ' ' + [A].[state] + ' '+ [A].[zip] FROM [juvenile] AS [J]
INNER JOIN [adult] AS [A] ON [J].[adult_member_no] = [A].[member_no]
WHERE [J].[member_no] NOT IN (SELECT [member_no] FROM [loanhist]
                              INNER JOIN [title] ON [title].[title_no] = [loanhist].[title_no]
                              WHERE [author] LIKE 'Jane Austen' AND YEAR([out_date]) = 2001 AND MONTH([out_date]) = 7)


SELECT [T].[title] FROM [title] AS [T]
INNER JOIN [loanhist] AS [LH] ON [LH].[title_no] = [T].[title_no]
GROUP BY [T].[title], [T].[author] HAVING COUNT([LH].[out_date]) > (SELECT AVG([RES].[CNT]) FROM (SELECT [T1].[author] AS [Aut], [T1].[title] AS [tit], COUNT([LH1].[out_date]) AS [cnt] FROM [title] AS [T1]
                                                                    INNER JOIN [loanhist] AS [LH1] ON [LH1].[title_no] = [T1].[title_no]
                                                                    GROUP BY [T1].[author], [T1].[title]) AS [RES] WHERE [T].[title] = [RES].[tit] AND [T].[author] = [RES].[Aut])