SELECT MONTH([out_date]) AS [Month], YEAR([out_date]) AS [Year], COUNT([isbn]) AS [Cnt], [J].[member_no], CONCAT([street], ' ', [city], ' ', [state], ' ', [zip]) AS [Address], 'JUVENILE' FROM [juvenile] AS [J]
INNER JOIN [adult] AS [A] ON [J].[adult_member_no] = [A].[member_no]
INNER JOIN [loanhist] AS [LH] ON [J].[member_no] = [LH].[member_no]
GROUP BY MONTH([out_date]), YEAR([out_date]), [J].[member_no], [street], [city], [state], [zip]
UNION
SELECT MONTH([out_date]), YEAR([out_date]), COUNT([isbn]), [A].[member_no], CONCAT([street], ' ', [city], ' ', [state], ' ', [zip]), 'ADULT' FROM [adult] AS [A]
INNER JOIN [loanhist] AS [LH] ON [A].[member_no] = [LH].[member_no]
GROUP BY MONTH([out_date]), YEAR([out_date]), [A].[member_no], [street], [city], [state], [zip]

-- joiny
SELECT [M].[member_no], [A].[street] + '' + [A].[city], 'Juvenile' FROM [member] AS [M]
LEFT OUTER JOIN [loanhist] AS [LH] ON [LH].[member_no] = [M].[member_no]
INNER JOIN [juvenile] AS [J] ON [J].[member_no] = [M].[member_no]
INNER JOIN [adult] AS [A] ON [A].[member_no] = [J].[adult_member_no]
WHERE [LH].[member_no] IS NULL
UNION
SELECT [M].[member_no], [A].[street] + '' + [A].[city], 'Adult' FROM [member] AS [M]
LEFT OUTER JOIN [loanhist] AS [LH] ON [LH].[member_no] = [M].[member_no]
INNER JOIN [adult] AS [A] ON [A].[member_no] = [M].[member_no]
WHERE [LH].[member_no] IS NULL


-- in
SELECT [J].[member_no], [A].[street] + ' ' + [A].[city], 'Juvenile' FROM [juvenile] AS [J]
INNER JOIN [adult] AS [A] ON [J].[adult_member_no] = [A].[member_no]
WHERE [J].[member_no] NOT IN (SELECT [member_no] FROM [loanhist])
UNION
SELECT [A].[member_no], [A].[street] + ' ' + [A].[city], 'Adult' FROM [adult] AS [A]
WHERE [A].[member_no] NOT IN (SELECT [member_no] from [loanhist])


-- exists
SELECT [J].[member_no], [A].[street] + ' ' + [A].[city], 'Juvenile' FROM [juvenile] AS [J]
INNER JOIN [adult] AS [A] ON [J].[adult_member_no] = [A].[member_no]
WHERE NOT EXISTS (SELECT [LH].[member_no] FROM [loanhist] AS [LH]
                  WHERE [LH].[member_no] = [J].[member_no])
UNION
SELECT [A].[member_no], [A].[street] + ' ' + [A].[city], 'Adult' FROM [adult] AS [A]
WHERE NOT EXISTS (SELECT [LH].[member_no] FROM [loanhist] AS [LH]
                  WHERE [LH].[member_no] = [A].[member_no])