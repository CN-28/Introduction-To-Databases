SELECT [member].[firstname], [member].[lastname], [birth_date], [street] + ', ' + [city] AS [Address] FROM [juvenile]
INNER JOIN [member] ON [member].[member_no] = [juvenile].[member_no]
INNER JOIN [adult] ON [adult].[member_no] = [juvenile].[adult_member_no]


SELECT (J_M.[firstname] + ' ' + J_M.[lastname]) AS [Child], [birth_date], [street] + ', ' + [city] AS [Address], (A_M.[firstname] + ' ' + A_M.[lastname]) AS [Parent]FROM [juvenile]
INNER JOIN [member] AS J_M ON J_M.[member_no] = [juvenile].[member_no]
INNER JOIN [adult] AS A ON A.[member_no] = [juvenile].[adult_member_no]
INNER JOIN [member] AS A_M ON [juvenile].[adult_member_no] = A_M.[member_no]