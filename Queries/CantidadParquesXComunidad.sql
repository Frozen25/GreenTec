USE greenTEC;

SET STATISTICS TIME ON;

SELECT Comunidad.Nombre,COUNT(Parque.idParque) AS CantidadDeParques
FROM (Comunidad
INNER JOIN ParqueXComunidad ON ParqueXComunidad.idComunidad = Comunidad.idComunidad
INNER JOIN Parque ON Parque.idParque = ParqueXComunidad.idParque)
GROUP BY Comunidad.Nombre
ORDER BY Comunidad.Nombre;

SET STATISTICS TIME OFF;


CREATE NONCLUSTERED INDEX IX_Cantidad
ON dbo.Parque(idParque);
CREATE NONCLUSTERED INDEX IX_Cantidad
ON dbo.ParqueXComunidad(idParque);

SET STATISTICS TIME ON;

SELECT Comunidad.Nombre,COUNT(Parque.idParque)
FROM (Comunidad
INNER JOIN ParqueXComunidad ON ParqueXComunidad.idComunidad = Comunidad.idComunidad
INNER JOIN Parque ON Parque.idParque = ParqueXComunidad.idParque)
GROUP BY Comunidad.Nombre
ORDER BY Comunidad.Nombre;

SET STATISTICS TIME OFF;

DROP INDEX IX_Cantidad
ON dbo.Parque;
DROP INDEX IX_Cantidad
ON dbo.ParqueXComunidad;
