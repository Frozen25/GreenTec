CREATE NONCLUSTERED INDEX IX_Extension
ON greenTEC.dbo.AreaParque(Extension);

SELECT CONVERT(INT,SQRT(SUM(AreaParque.Extension))) AS LadoParque, COUNT(TipoEspecie.idTipoEspecie) AS CantidadEspecies,
CASE
	WHEN Parque.idParque < 50 THEN 'Primeros 50 parques'
	ELSE 'Segundos 50 parques'
END
FROM (greenTEC.dbo.Parque
INNER JOIN greenTEC.dbo.AreaParque ON AreaParque.idParque = Parque.idParque
INNER JOIN greenTEC.dbo.EspecieXArea ON EspecieXArea.idAreaParque = AreaParque.idAreaParque
INNER JOIN greenTEC.dbo.Especie ON Especie.idEspecie = EspecieXArea.idEspecie
INNER JOIN greenTEC.dbo.TipoEspecie ON TipoEspecie.idTipoEspecie = Especie.idTipoEspecie
INNER JOIN greenTEC.dbo.Alojamiento ON Alojamiento.idParque = Parque.idParque)
WHERE Alojamiento.idCategoria NOT IN
	(SELECT CategoriaAlojamiento.idCategoria
	 FROM greenTEC.dbo.CategoriaAlojamiento
	 WHERE CategoriaAlojamiento.Nombre LIKE '%Resort and Spa%')
GROUP BY Parque.idParque
ORDER BY LadoParque;

DROP INDEX IX_Extension
ON greenTEC.dbo.AreaParque;