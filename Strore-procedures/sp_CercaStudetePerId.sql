-- =============================================
-- Author:		Moussa
-- Create date: 2026-11-25 
-- Description:	Restituisce lo studente in base all'Id passato nel parametro
-- =============================================
CREATE OR ALTER PROCEDURE sp_CercaStudentePerId
	@StudenteId INT
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
	WHERE StudenteId = @StudenteId
END
GO

