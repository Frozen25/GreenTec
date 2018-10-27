-- Transaccion 1
USE Dummy;

PRINT N'Configurar el nivel de aislamiento';
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

PRINT N'Comenzar transaccion';
BEGIN TRANSACTION;
PRINT N'Realizar consulta';
SELECT * FROM dbo.Person WHERE dbo.Person.IdPerson > 3
PRINT N'Esperando...';
WAITFOR DELAY '00:00:20';
PRINT N'Realizar consulta 2';
SELECT * FROM dbo.Person WHERE dbo.Person.IdPerson > 3

PRINT N'Actualizando transaccion';
COMMIT TRANSACTION;



-- Transaccion 2
USE Dummy;

PRINT N'Comenzar transaccion';
BEGIN TRANSACTION;
PRINT N'Realizando consulta';
UPDATE dbo.Person
SET dbo.Person.Age = 10
WHERE dbo.Person.IdPerson = 2

PRINT N'Actualizando consulta';
COMMIT TRANSACTION;



-- Transaccion 3 - bloqueada
USE Dummy;

PRINT N'Comenzar transaccion';
BEGIN TRANSACTION;
PRINT N'Realizando consulta';
UPDATE dbo.Person
SET dbo.Person.Age = 10
WHERE dbo.Person.IdPerson = 4

PRINT N'Actualizando consulta';
COMMIT TRANSACTION;
