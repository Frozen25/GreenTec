-- Transaction 1
USE Dummy;

PRINT N'Configurando nivel de aislamiento';
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

PRINT N'Comenzando transaccion';
BEGIN TRANSACTION;
PRINT N'Realizando consulta';
DELETE FROM dbo.Person WHERE dbo.Person.IdPerson = 11;
INSERT INTO dbo.Person VALUES (11, 'NewName', 'NewLast', 20, 'Cartago');
PRINT N'Esperando...';
WAITFOR DELAY '00:00:15';
SELECT * FROM dbo.Person;
PRINT N'Actualizando transaccion';
COMMIT TRANSACTION;



-- Transaction 2
USE Dummy;

PRINT N'Configurando nivel de aislamiento';
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

PRINT N'Comenzar transaccion';
BEGIN TRANSACTION;
PRINT N'Ejecutando consulta';
SELECT * FROM dbo.Person;
PRINT N'Actualizando transaccion';
COMMIT TRANSACTION;
