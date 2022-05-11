USE WideWorldImporters
GO
SET NOCOUNT ON;

--	Note the different syntax for a IMOLTP table
--ALTER TABLE [Warehouse].[VehicleTemperatures]
--	ADD INDEX IX_VehicleTemperatures_RecordedWhen NONCLUSTERED (RecordedWhen);

--620528 rows
CREATE TABLE #VehicleTemperaturesGC(
	VehicleTemperatureID INT,
	INDEX IX_VehicleTemperaturesGC(VehicleTemperatureID)
);

DECLARE @BatchSize INT = 100;

BEGIN TRANSACTION;

INSERT INTO #VehicleTemperaturesGC
SELECT TOP (@BatchSize)
	vt.VehicleTemperatureID
FROM Warehouse.VehicleTemperatures vt WITH(INDEX(IX_VehicleTemperatures_RecordedWhen))
WHERE
	vt.RecordedWhen < 
		DATEADD(month, -50, GETUTCDATE());

DELETE sd
FROM #VehicleTemperaturesGC gc
JOIN Warehouse.VehicleTemperatures sd
	ON sd.VehicleTemperatureID = gc.VehicleTemperatureID;

ROLLBACK TRANSACTION;

DROP TABLE #VehicleTemperaturesGC;
GO
