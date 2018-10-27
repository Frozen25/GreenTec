-- TOP, pueden especificarse los atributos, cambiando el *-- 
SELECT TOP 100 * FROM Excursion;

-- SUBSTRING, SUBSTRING(nombreString, start, length) --
SELECT Nombre, SUBSTRING(Nombre, 1, 1) AS letraInicial ,
SUBSTRING(Nombre, 3, 2) AS tresCaracteres
FROM Parque;

-- DISTINCT --
SELECT DISTINCT Nombre FROM Canton;

-- AVERAGE --
SELECT AVG(Presupuesto) FROM ProyectoInvestigacion;

-- LTRIM, quita los espacios en blanco al principio del string; pasa de '  hola' a 'hola' -- 
SELECT LTRIM(NombreCientifico), LTRIM(NombreVulgar) FROM Especie;

-- COALESCE, retorna el primer valor no nulo de una serie de elementos
SELECT COALESCE(NULL, 1, 2, 'GreenTEC');

GO

-- EXECUTE AS, especifica el usuario de la base de datos que tiene permisos de ejecutar el SP-- 
CREATE PROCEDURE ObtenerPaises 
WITH EXECUTE AS OWNER
AS
BEGIN
  SELECT * FROM Pais;
END

--  UNION -- 
SELECT * FROM Provincia
UNION ALL
SELECT * FROM Canton;

-- sp_recompile, recompila tablas vistas y SP, para eliminar datos de caché --
EXEC sp_recompile N'Especie';
