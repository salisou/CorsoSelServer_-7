USE ScuolaDb;
GO

CREATE OR ALTER VIEW vw_ListaStudentiScrittiCorsi
AS
	SELECT 
		cl.NomeClasse,
		CONCAT(s.Nome, ' ', s.Cognome) AS Studente,
		LEFT(s.CodiceFiscale, 6) + ' ' + '**********' AS [Codice Fiscale],
		s.Email,
		c.NomeCorso AS [Nome del corso],
		ISNULL(CONVERT(NVARCHAR, c.Descrizione), 'Non definita') AS Descrizione,
		CONVERT(VARCHAR(10), i.DataIscrizione, 104) AS [Data Iscrizione],
		i.Stato
	FROM Studenti AS s
	INNER JOIN Iscrizioni AS i
		ON s.StudenteId = i.StudenteId
	INNER JOIN Corsi AS c
		ON c.CorsoId = i.CorsoId
	INNER JOIN AnniScolastici AS a
		ON a.AnnoScolasticoId = i.AnnoScolasticoId
	INNER JOIN Classi AS cl
		ON cl.ClasseId = s.ClasseId

