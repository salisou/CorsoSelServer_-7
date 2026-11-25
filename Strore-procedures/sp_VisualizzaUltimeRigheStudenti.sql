CREATE OR ALTER PROCEDURE sp_VisualizzaUltimeRigheStudenti
    @NumeroRecord INT,
    @Tipo CHAR(1) -- P = Primi, U = Ultimi
AS
BEGIN
    SET NOCOUNT ON;

    IF @Tipo = 'P'
    BEGIN
        SELECT TOP (@NumeroRecord) 
        ISNULL(CONVERT(NVARCHAR(20), ClasseId), 'N/D') AS ClasseId,
        CONCAT(Nome, ' ', Cognome) AS [Nome Completo],
        ISNULL(CONVERT(NVARCHAR(10), DataNascita, 103), 'N/D') AS [Data Nascita],
        ISNULL(CodiceFiscale, '') AS CF,
        CONCAT(
            MONTH(DataRegistrazione),
            '/',
            YEAR(DataRegistrazione)
        ) AS [Data Registrazione]
        FROM Studenti
        ORDER BY StudenteId ASC;
    END
    ELSE IF @Tipo = 'U'
    BEGIN
    SELECT TOP (@NumeroRecord)
        ISNULL(CONVERT(NVARCHAR(20), ClasseId), 'N/D') AS ClasseId,
        CONCAT(Nome, ' ', Cognome) AS [Nome Completo],
        ISNULL(CONVERT(NVARCHAR(10), DataNascita, 103), 'N/D') AS [Data Nascita],
        ISNULL(CodiceFiscale, '') AS CF,
        CONCAT(
            MONTH(DataRegistrazione),
            '/',
            YEAR(DataRegistrazione)
        ) AS [Data Registrazione]
    FROM Studenti
    ORDER BY StudenteId DESC;
    END
END;
GO
