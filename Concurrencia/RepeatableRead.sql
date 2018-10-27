-- Transaction 1
USE Dummy;

PRINT N'Configurando nivel de aislamiento';
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

PRINT N'Comenzar transaccion';
BEGIN TRANSACTION;
PRINT N'Ejecutando consulta';
DELETE FROM dbo.Person WHERE dbo.Person.IdPerson = 11;
INSERT INTO dbo.Person VALUES (11, 'NewName', 'NewLast', 20, 'Cartago');
PRINT N'Esperando...';
WAITFOR DELAY '00:00:20';
PRINT N'Actualizar transaccion';
COMMIT TRANSACTION;



-- Transaction 2 - bloqueada
USE Dummy;

PRINT N'Comenzar transaccion';
BEGIN TRANSACTION;
PRINT N'Ejecutando consulta';
SELECT * FROM dbo.Person WHERE dbo.Person.IdPerson > 5;
PRINT N'Actualizando transaccion';
COMMIT TRANSACTION;
