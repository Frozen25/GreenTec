CREATE PROCEDURE Excursiones @idParque INT
AS
BEGIN
    DECLARE ExcursionesCursor CURSOR LOCAL
    FOR
    SELECT Excursion.Nombre,HorarioExcursion.Dia,HorarioExcursion.InicioExcursion,HorarioExcursion.FinExcursion
    FROM (Alojamiento
    INNER JOIN Excursion ON Excursion.idAlojamiento = Alojamiento.idAlojamiento
    INNER JOIN HorarioXExcursion ON HorarioXExcursion.idExcursion = Excursion.idExcursion
    INNER JOIN HorarioExcursion ON HorarioExcursion.idHorarioExcursion = HorarioXExcursion.idHorarioExcursion)
    WHERE Alojamiento.idParque = @idParque
    OPEN ExcursionesCursor
    FETCH NEXT FROM ExcursionesCursor
    WHILE @@FETCH_STATUS = 0
    BEGIN
        FETCH NEXT FROM ExcursionesCursor
    END
    CLOSE ExcursionesCursor
    DEALLOCATE ExcursionesCursor
END
;