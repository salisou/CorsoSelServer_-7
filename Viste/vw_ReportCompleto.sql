USE ScuolaDb;
GO


-- ============================================================
-- VERIFICA DEL NUMERO DI RECORD PER OGNI TABELLA
-- ============================================================
CREATE OR ALTER VIEW vw_ReportCompleto
AS
	SELECT 'AnniScolastici' AS Tabella, COUNT(*) AS TotaleRecord
	FROM AnniScolastici

	UNION ALL

	SELECT 'Docenti', COUNT(*)
	FROM Docenti

	UNION ALL

	SELECT 'Aule', 
		COUNT(*) 
	FROM Aule

	UNION ALL

	SELECT 'Classi', COUNT(*)
	FROM Classi

	UNION ALL

	SELECT 'Studenti', COUNT(*)
	FROM Studenti

	UNION ALL

	SELECT 'Corsi', COUNT(*)
	FROM Corsi

	UNION ALL

	SELECT 'Iscrizioni', COUNT(*)
	FROM Iscrizioni

	UNION ALL

	SELECT 'DocentiCorsi', COUNT(*)
	FROM DocentiCorsi

	UNION ALL

	SELECT 'Lezioni', COUNT(*)
	FROM Lezioni

	UNION ALL

	SELECT 'Voti', COUNT(*)
	FROM Voti

	UNION ALL

	SELECT 'Presenze', COUNT(*)
	FROM Presenze

	UNION ALL

	SELECT 'Pagamenti', COUNT(*)
	FROM Pagamenti;
	GO
