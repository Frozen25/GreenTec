CREATE PROCEDURE InsertarPaisProvincia
@IdProvincia int, @NombrePais nvarchar(10), @NombreProvincia nvarchar(10), @IdDistrito int, @NombreCanton nvarchar(10), @NombreDistrito nvarchar(10)
AS
BEGIN 
  DECLARE @Error int
  BEGIN TRANSACTION 
    DECLARE @UltimoIdPais int = (SELECT MAX(idPais) FROM Pais) + 1;
    INSERT INTO Pais VALUES(@UltimoIdPais, @NombrePais);

    INSERT INTO Canton VALUES(@IdProvincia, @NombreProvincia, @UltimoIdPais)

	SET @Error = @@ERROR

	IF (@Error <> 0)	
	  BEGIN
	    ROLLBACK TRANSACTION
		PRINT 'Error al insertar provincia'	
	  END

    EXEC InsertarCantonDistrito @IdDistrito, @NombreCanton, @NombreDistrito;
END

GO

CREATE PROCEDURE InsertarCantonDistrito
@IdDistrito int, @NombreCanton nvarchar(10), @NombreDistrito nvarchar(10)
AS
BEGIN
  DECLARE @UltimoIdProvincia int = (SELECT MAX(idProvincia) FROM Provincia) + 1;
  DECLARE @UltimoIdCanton int = (SELECT MAX(idCanton) FROM Canton) + 1;

  DECLARE @Error int

  BEGIN TRANSACTION

  INSERT INTO Canton VALUES(@UltimoIdCanton, @NombreCanton, @UltimoIdCanton);
  INSERT INTO Distrito VALUES(@IdDistrito, @NombreDistrito, @UltimoIdCanton);

  SET @Error = @@ERROR

  IF (@Error <> 0)	
	  BEGIN
	    ROLLBACK TRANSACTION
		PRINT 'Error al insertar distrito'	
	  END
END

GO