-- Transaccion 1
USE Dummy

DECLARE 
    @AGE AS INT,
	@TEMP_AGE   AS INT

BEGIN TRANSACTION

DECLARE person_cursor CURSOR SCROLL_LOCKS
    FOR SELECT dbo.Person.IdPerson FROM dbo.Person
	FOR UPDATE OF AGE

OPEN person_cursor
FETCH NEXT FROM person_cursor
INTO @AGE;

WHILE @@FETCH_STATUS = 0
BEGIN
   SELECT @TEMP_AGE = @TEMP_AGE + 1
   UPDATE dbo.Person SET @AGE = @TEMP_AGE WHERE CURRENT OF person_cursor
   FETCH NEXT FROM person_cursor
   INTO @AGE
   WAITFOR DELAY '00:00:02'
END

CLOSE person_cursor;
DEALLOCATE person_cursor;

COMMIT TRANSACTION



-- Transaccion 2
USE Dummy

BEGIN TRANSACTION
DECLARE person_cursor CURSOR SCROLL_LOCKS
    FOR SELECT * FROM dbo.Person

OPEN person_cursor
FETCH NEXT FROM person_cursor;

WHILE @@FETCH_STATUS = 0  
BEGIN
   FETCH NEXT FROM person_cursor;
END

CLOSE person_cursor;
DEALLOCATE person_cursor;

COMMIT TRANSACTION
