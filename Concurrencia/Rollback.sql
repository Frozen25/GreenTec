USE Dummy;

BEGIN TRY
	PRINT N'Comenzando transaccion';
	BEGIN TRANSACTION
	PRINT N'Realizando la consulta';
	SELECT * FROM dbo.Person;
	PRINT N'Esperanado...';
	WAITFOR DELAY '00:00:05'
	PRINT N'Actualizando';
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	PRINT N'Verificar tiempo';
	IF @@TRANCOUNT > 0
		PRINT N'Realizar Rollback';
		ROLLBACK;
END CATCH