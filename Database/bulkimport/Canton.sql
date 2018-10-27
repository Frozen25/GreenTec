BULK INSERT greenTEC.dbo.Canton
FROM 'C:\Users\cluadmin\Desktop\GreenTec-master\datosDePoblacion\Canton.txt'
WITH
(
	FIRSTROW = 2,
	FORMATFILE = 'C:\Users\cluadmin\Desktop\PROYECTO2\bulkimport\cantonFORMAT.fmt'
);