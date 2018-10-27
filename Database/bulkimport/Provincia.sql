BULK INSERT greenTEC.dbo.Provincia
FROM 'C:\Users\cluadmin\Desktop\GreenTec-master\datosDePoblacion\Provincia.txt'
WITH
(
	FIRSTROW = 2,
	FORMATFILE = 'C:\Users\cluadmin\Desktop\PROYECTO2\bulkimport\provinciaFORMAT.fmt'
);