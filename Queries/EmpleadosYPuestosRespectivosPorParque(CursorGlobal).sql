CREATE PROCEDURE EmpleadosPuestos @idParque INT
AS
BEGIN
    DECLARE EmpleadosPuestosCursor CURSOR GLOBAL
    FOR
    SELECT Persona.Nombre,Puesto.Nombre
    FROM (Empleado
    INNER JOIN Persona ON Empleado.idPersona = Persona.idPersona
    INNER JOIN Puesto ON Puesto.idPuesto = Empleado.idPuesto)
    WHERE Empleado.idParque = @idParque
    OPEN EmpleadosPuestosCursor
    FETCH NEXT FROM EmpleadosPuestosCursor
    WHILE @@FETCH_STATUS = 0
    BEGIN
        FETCH NEXT FROM EmpleadosPuestosCursor
    END
    CLOSE EmpleadosPuestosCursor
    DEALLOCATE EmpleadosPuestosCursor
END
;