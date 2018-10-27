CREATE TRIGGER TR_PrintDespuesInsercion ON Pais FOR INSERT 
AS
BEGIN
  print 'País Insertado'
END
