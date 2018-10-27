BULK INSERT greenTEC.dbo.Distrito
FROM 'C:\Users\cluadmin\Desktop\GreenTec-master\datosDePoblacion\Distrito.txt'
WITH
(
	FIRSTROW = 2,
	FORMATFILE = 'C:\Users\cluadmin\Desktop\PROYECTO2\bulkimport\distritoFORMAT.fmt'
);