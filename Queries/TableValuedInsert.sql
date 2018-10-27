CREATE TYPE ProvinciaType AS TABLE
(
  idProvincia int,
  Nombre nvarchar(50),
  idPais int	
)

 GO

CREATE PROCEDURE TableValuedInsercion
@PrType ProvinciaType READONLY
AS 
BEGIN
  INSERT INTO Provincia SELECT * FROM @PrType
END

-- Declara la variable que almacena el binario del archivo XML
DECLARE @xmldata XML;
DECLARE @PrType ProvinciaType

-- Carga la variable
SELECT @xmldata = d
  FROM OPENROWSET (BULK 'C:\Users\aguis\OneDrive\Documentos\Programas\Programitas SQL\SQL Server\test3.xml', SINGLE_BLOB) AS Data(d)

-- Declara la variable utilizada para cargar el archivo XML cargado a memoria por SQL Server
DECLARE @hdoc int

-- Carga el binario del XML a la varibale hdoc
EXEC sp_xml_preparedocument @hdoc OUTPUT, @xmldata

-- Inserta los datos en una tabla temporal y luego en la tabla de la base de dato. 
-- Para OPENXML se indica el origen, la gerarqu�a del XML de donde se quieren sacar los datos y
-- si los datos son atributos o elementos
INSERT INTO @PrType 
SELECT * FROM OPENXML (@hdoc, '/Provincias/Provincia', 2)
WITH 
(
    idProvincia int,
    Nombre nvarchar(50),
    idPais int
)

-- Saca de memoria la variable que contiene el XML
EXEC sp_xml_removedocument @hdoc

EXEC TableValuedInsercion @PrType

SELECT * FROM Provincia;
