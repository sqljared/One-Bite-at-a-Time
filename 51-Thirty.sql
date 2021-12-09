USE WideWorldImporters
GO
DECLARE @ArchiveDate DATE;

SET @ArchiveDate = DATEADD(month, -70, GETUTCDATE())

SELECT
	SUM(CASE WHEN so.OrderDate < @ArchiveDate
		THEN 1 ELSE 0 END) AS WithinDate
FROM Sales.Orders so
WHERE
	so.OrderDate < DATEADD(month, -70, GETUTCDATE())
	--so.OrderDate < @ArchiveDate

--158778, 47636.4
--SELECT 
--	COUNT(1) AS Total,
--	COUNT(1)*0.3 AS 'Wild Guess'
--FROM sales.Orders so
