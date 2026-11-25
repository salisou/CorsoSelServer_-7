-- =============================================
-- Author:		Moussa
-- Create date: 2026-11-25 
-- Description:	Restituisce lo studente in base all'Id passato nel parametro
-- =============================================
CREATE OR ALTER PROCEDURE sp_AggiornaStudente
	@StudenteId INT,
	@Nome NVARCHAR(50),
	@Cognome NVARCHAR(50),
	@RigheModificate INT OUTPUT
AS
BEGIN
	UPDATE Studenti
	SET Nome = @Nome,
		Cognome = @Cognome
	WHERE StudenteId = @StudenteId

	SET @RigheModificate = @@ROWCOUNT;
END
GO

