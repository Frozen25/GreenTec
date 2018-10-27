CREATE PROCEDURE Insertar4Tablas 
@NombrePais nvarchar(50), @NombreProvincia nvarchar(50), @NombreCanton nvarchar(50), @NombreDistrito nvarchar(50)
AS 
BEGIN
 
  DECLARE @UltimoIdPais int = (SELECT MAX(idPais) FROM Pais) + 1;
  DECLARE @UltimoIdProvincia int = (SELECT MAX(idProvincia) FROM Provincia) + 1;
  DECLARE @UltimoIdCanton int = (SELECT MAX(idCanton) FROM Canton) + 1;
  DECLARE @UltimoIdDistrito int = (SELECT MAX(idDistrito) FROM Distrito) + 1;

  INSERT INTO Pais VALUES (@UltimoIdPais, @NombrePais);
  INSERT INTO Provincia VALUES (@UltimoIdProvincia, @NombreProvincia, @UltimoIdPais);
  INSERT INTO Canton VALUES (@UltimoIdCanton, @NombreCanton, @UltimoIdProvincia);
  INSERT INTO Distrito VALUES (@UltimoIdDistrito, @NombreDistrito, @UltimoIdCanton);

END