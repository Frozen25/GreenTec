-- Transaction 1
USE Dummy;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

BEGIN TRANSACTION;
DELETE FROM dbo.Person WHERE dbo.Person.IdPerson = 11;
INSERT INTO dbo.Person VALUES (11, 'NewName', 'NewLast', 20, 'Cartago');
WAITFOR DELAY '00:00:20';
COMMIT TRANSACTION;



-- Transaction 2 - bloqueada
USE Dummy;

BEGIN TRANSACTION;
SELECT * FROM dbo.Person WHERE dbo.Person.IdPerson > 5;
COMMIT TRANSACTION;
