SELECT CONVERT(INT,SQRT(SUM(AreaParque.Extension))),COUNT(TipoEspecie.idTipoEspecie),
CASE
	WHEN YEAR(Parque.FechaInauguracion) < 2000 THEN "Parque creado antes del siglo XXI"
	ELSE "Parque creado en el siglo XXI"
END
FROM (Parque
INNER JOIN AreaParque ON AreaParque.idParque = Parque.idParque
INNER JOIN EspecieXArea ON EspecieXArea.idAreaParque = AreaParque.idAreaParque
INNER JOIN Especie ON Especie.idEspecie = EspecieXArea.idEspecie
INNER JOIN TipoEspecie ON TipoEspecie.idTipoEspecie = Especie.idTipoEspecie)
WHERE Parque.idParque NOT IN 
	(SELECT Parque.idParque
	 FROM Parque
	 WHERE Parque.idParque IN 
	 	(SELECT Alojamiento.idParque
	 	 FROM Alojamiento
	 	 WHERE Alojamiento.idCategoria IN 
	 	 	(SELECT idCategoria
	 	 	 FROM CategoriaAlojamiento
	 	 	 WHERE CategoriaAlojamiento.Nombre = 'Resort and Spa')))
GROUP BY Parque.idParque
ORDER BY Parque.idParque
;