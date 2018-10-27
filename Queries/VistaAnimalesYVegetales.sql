CREATE VIEW AnimalesYVegetales AS
SELECT dbo.Especie.NombreVulgar, dbo.Especie.NombreCientifico, dbo.TipoEspecie.Nombre AS NombreEspecie, dbo.Temporada.Inicio AS TemporadaInicio, dbo.Temporada.Fin AS TemporadaFin, 
                  dbo.Caracteristica.Nombre AS NombreCaracteristica
FROM     dbo.Especie INNER JOIN
                  dbo.TipoEspecie ON dbo.Especie.idTipoEspecie = dbo.TipoEspecie.idTipoEspecie INNER JOIN
                  dbo.Temporada ON dbo.Especie.idTemporada = dbo.Temporada.idTemporada INNER JOIN
                  dbo.Caracteristica ON dbo.Especie.idCaracteristica = dbo.Caracteristica.idCaracteristica AND dbo.TipoEspecie.idTipoEspecie = dbo.Caracteristica.idTipoEspecie
WHERE  (dbo.TipoEspecie.Nombre LIKE '%Animal%') AND (dbo.Caracteristica.Nombre LIKE '%Omnivoro%')
;