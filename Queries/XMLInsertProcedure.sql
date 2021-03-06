CREATE PROCEDURE XMLInsercion
@xmlfile XML
AS
BEGIN
  
  -- Declara la variable utilizada para cargar el archivo XML cargado a memoria por SQL Server
  DECLARE @hdoc int

  -- Carga el binario del XML a la varibale hdoc
  EXEC sp_xml_preparedocument @hdoc OUTPUT, @xmlfile

  -- Inserta los datos en una tabla temporal y luego en la tabla de la base de dato. 
  -- Para OPENXML se indica el origen, la gerarquía del XML de donde se quieren sacar los datos y
  -- si los datos son atributos o elementos
  INSERT INTO Pais 
  SELECT * FROM OPENXML (@hdoc, '/Paises/Pais', 2)
  WITH 
  (
      idPais int,
	  Nombre nvarchar(50)
  )

  -- Saca de memoria la variable que contiene el XML
  EXEC sp_xml_removedocument @hdoc
END

-----------------------------------------------------------------------
DECLARE @xmldata XML;

-- Carga la variable

SELECT @xmldata = d
 FROM OPENROWSET (BULK 'C:\Users\aguis\OneDrive\Documentos\Programas\Programitas SQL\SQL Server\test2.xml', SINGLE_BLOB) AS Data(d)

EXEC [dbo].[XMLInsercion] @xmldata