-- Transaccion 1
USE Dummy

PRINT N'Declarnado variables';
DECLARE 
    @AGE AS INT,
	@TEMP_AGE   AS INT

PRINT N'Iniciando transaccio';
BEGIN TRANSACTION

PRINT N'Declarando cursor';
DECLARE person_cursor CURSOR SCROLL_LOCKS
    FOR SELECT dbo.Person.IdPerson FROM dbo.Person
	FOR UPDATE OF AGE

PRINT N'Habilitando cursor';
OPEN person_cursor

PRINT N'Obteniendo datos';
FETCH NEXT FROM person_cursor
INTO @AGE;

PRINT N'Empezando cambios';
WHILE @@FETCH_STATUS = 0
BEGIN
   SELECT @TEMP_AGE = @TEMP_AGE + 1
   UPDATE dbo.Person SET @AGE = @TEMP_AGE WHERE CURRENT OF person_cursor
   FETCH NEXT FROM person_cursor
   INTO @AGE
   WAITFOR DELAY '00:00:02'
END

PRINT N'Cambios terminados';
PRINT N'Cerrando cursor';
CLOSE person_cursor;
DEALLOCATE person_cursor;

PRINT N'Actualizando transaccion';
COMMIT TRANSACTION



-- Transaccion 2
USE Dummy

PRINT N'Comenzando transaccion';
BEGIN TRANSACTION
DECLARE person_cursor CURSOR SCROLL_LOCKS
    FOR SELECT * FROM dbo.Person

PRINT N'Habilitando cursor';
OPEN person_cursor
PRINT N'Obtieniendo valores';
FETCH NEXT FROM person_cursor;

WHILE @@FETCH_STATUS = 0  
BEGIN
   FETCH NEXT FROM person_cursor;
END

PRINT N'Valores obtenidos';
PRINT N'Cerrando cursor';
CLOSE person_cursor;
PRINT N'Borrando cursor';
DEALLOCATE person_cursor;
PRINT N'Actualizando transaccion';
COMMIT TRANSACTION
