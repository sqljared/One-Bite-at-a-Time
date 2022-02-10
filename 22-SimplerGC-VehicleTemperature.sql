USE WideWorldImporters
GO
SET NOCOUNT ON;

--	Note the different syntax for a IMOLTP table
--ALTER TABLE [Warehouse].[VehicleTemperatures]
--	ADD INDEX IX_VehicleTemperatures_RecordedWhen NONCLUSTERED (RecordedWhen);

DECLARE @BatchSize INT = 100;

BEGIN TRANSACTION;

--620528 rows
DELETE TOP (@BatchSize) vt
FROM Warehouse.VehicleTemperatures vt --WITH(INDEX(IX_VehicleTemperatures_RecordedWhen))
WHERE
	vt.RecordedWhen < DATEADD(DAY, -180, GETUTCDATE());

ROLLBACK TRANSACTION;
GO

--UPDATE STATISTICS Warehouse.VehicleTemperatures
--	WITH FULLSCAN, ALL;
--GO