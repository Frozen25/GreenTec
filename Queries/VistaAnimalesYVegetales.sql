CREATE VIEW AnimalesYVegetales AS
SELECT Especie.NombreCientifico,Especie.NombreVulgar,
TipoEspecie.Nombre,Temporada.Inicio,Temporada.Fin,
Caracteristica.Nombre
FROM (Especie
INNER JOIN  TipoEspecie ON TipoEspecie.idTipoEspecie=Especie.idTipoEspecie
INNER JOIN Temporada ON Temporada.idTemporada=Especie.idTemporada
INNER JOIN Caracteristica ON Caracteristica.idCaracteristica=Especie.idCaracteristica)
WHERE TipoEspecie.Nombre='Vegetal' AND TipoEspecie.Nombre='Animal'
;