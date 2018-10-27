USE greenTEC;

SET STATISTICS TIME ON;

SELECT Comunidad.Nombre,SUM(AreaParque.Extension)
FROM (Comunidad
INNER JOIN ParqueXComunidad ON ParqueXComunidad.idComunidad = Comunidad.idComunidad
INNER JOIN Parque ON Parque.idParque = ParqueXComunidad.idParque
INNER JOIN AreaParque ON AreaParque.idParque = Parque.idParque)
GROUP BY Comunidad.Nombre
ORDER BY Comunidad.Nombre;

SET STATISTICS TIME OFF;

CREATE NONCLUSTERED INDEX IX_Extension
ON dbo.AreaParque (Extension);


SET STATISTICS TIME ON;

SELECT Comunidad.Nombre,SUM(AreaParque.Extension)
FROM (Comunidad
INNER JOIN ParqueXComunidad ON ParqueXComunidad.idComunidad = Comunidad.idComunidad
INNER JOIN Parque ON Parque.idParque = ParqueXComunidad.idParque
INNER JOIN AreaParque ON AreaParque.idParque = Parque.idParque)
GROUP BY Comunidad.Nombre
ORDER BY Comunidad.Nombre;

SET STATISTICS TIME OFF;


DROP INDEX IX_Extension
ON dbo.AreaParque;
