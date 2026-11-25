USE ScuolaDb;
GO

-- =============================================
-- Author:		Moussa
-- Create date: 2026-11-25 
-- Description:	Restituisce lo studente in base al Nome passato nel parametro
-- =============================================
CREATE OR ALTER PROCEDURE sp_VisualizzaPrimeRigheStudenti
    @NumeroRecord INT
AS 
BEGIN
	SELECT TOP (@NumeroRecord)
        ISNULL(CONVERT(NVARCHAR, ClasseId), 'N/D') AS ClasseId,
        CONCAT(Nome, ' ' ,Cognome) AS [Nome Completo],
        ISNULL(CONVERT(NVARCHAR, DataNascita, 109), 'dd/MM/yyyy') AS [Data Nascita],
        ISNULL(CONVERT(NVARCHAR, CodiceFiscale), '') AS CF,
        CONCAT(
            MONTH(DataRegistrazione), '/',
            YEAR(DataRegistrazione)
        ) AS [Data Registrazione]
    FROM Studenti
    ORDER BY [Nome Completo] ASC;
END;
GO