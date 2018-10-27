BULK INSERT greenTEC.dbo.EventoExcursion
FROM 'C:\Users\cluadmin\Desktop\GreenTec-master\datosDePoblacion\EventoExcursion.txt'
WITH
(
	FIRSTROW = 2,
	FORMATFILE = 'C:\Users\cluadmin\Desktop\PROYECTO2\bulkimport\tempFORMAT.fmt'
);