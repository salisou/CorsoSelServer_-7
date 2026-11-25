-- =============================================
-- Author:		Moussa
-- Create date: 2026-11-25 
-- Description:	Restituisce l'elenco degli studenti
-- =============================================
CREATE OR ALTER PROCEDURE sp_Elenco_Studenti
------------------------Parametri-----------------------------------------
AS
BEGIN
	SET NOCOUNT ON;

    SELECT 
		ISNULL(CONVERT(VARCHAR(20), ClasseId), '--') AS ClasseId,
		CONCAT(Nome, ' ', Cognome) AS [Nome Completo],
		ISNULL(LOWER(Email), 'Non presente') AS Email,
		CONVERT(NVARCHAR(10), DataNascita, 104) AS [Data Nascita],
		LEFT(CodiceFiscale, 6) + ' ' + '**********' AS CodiceFiscale,
		CASE
			WHEN Attivo = 1 THEN N'Attivo'
			ELSE 'Non Attivo' 
		END AS Stato
	FROM Studenti 
END
GO

