SELECT CONVERT(INT,SQRT(SUM(AreaParque.Extension))) AS LadoParque, COUNT(TipoEspecie.idTipoEspecie) AS CantidadEspecies,
CASE
	WHEN Parque.idParque < 50 THEN 'Primeros 50 parques'
	ELSE 'Segundos 50 parques'
END
FROM (greenTEC.dbo.Parque
INNER JOIN greenTEC.dbo.AreaParque ON AreaParque.idParque = Parque.idParque
INNER JOIN greenTEC.dbo.EspecieXArea ON EspecieXArea.idAreaParque = AreaParque.idAreaParque
INNER JOIN greenTEC.dbo.Especie ON Especie.idEspecie = EspecieXArea.idEspecie
INNER JOIN greenTEC.dbo.TipoEspecie ON TipoEspecie.idTipoEspecie = Especie.idTipoEspecie)
WHERE Parque.idParque NOT IN 
	(SELECT Parque.idParque
	 FROM greenTEC.dbo.Parque
	 WHERE Parque.idParque IN 
	 	(SELECT Alojamiento.idParque
	 	 FROM greenTEC.dbo.Alojamiento
	 	 WHERE Alojamiento.idCategoria IN 
	 	 	(SELECT idCategoria
	 	 	 FROM greenTEC.dbo.CategoriaAlojamiento
	 	 	 WHERE CategoriaAlojamiento.Nombre LIKE '%Resort and Spa%')))
GROUP BY Parque.idParque
ORDER BY LadoParque
;