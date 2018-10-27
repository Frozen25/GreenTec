-- Transaccion 1
USE Dummy;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

BEGIN TRANSACTION;
SELECT * FROM dbo.Person WHERE dbo.Person.IdPerson > 3
WAITFOR DELAY '00:00:20';
SELECT * FROM dbo.Person WHERE dbo.Person.IdPerson > 3
COMMIT TRANSACTION;



-- Transaccion 2
USE Dummy;

BEGIN TRANSACTION;
UPDATE dbo.Person
SET dbo.Person.Age = 10
WHERE dbo.Person.IdPerson = 2
COMMIT TRANSACTION;



-- Transaccion 3 - bloqueada
USE Dummy;

BEGIN TRANSACTION;
UPDATE dbo.Person
SET dbo.Person.Age = 10
WHERE dbo.Person.IdPerson = 4
COMMIT TRANSACTION;
