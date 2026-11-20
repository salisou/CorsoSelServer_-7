use ScuolaDb;

-- INNER JOIN / JOIN 
/*
	SELECT 
		t1.colonna1,
		t1.colonna2,
		t2.colonna6
		...
	FROM tabella1 as t1
	INNER JOIN Tabella2 as t2
		ON t1.colonnaId = t2.colonnaId <= condizione 
*/

-- Restituire la lista degli studenti scritti 
SELECT 
	CONCAT(s.Nome, ' ', s.Cognome) AS Studente,
	s.CodiceFiscale AS CF,
	s.Email,
	i.DataIscrizione AS [Data Iscrizione],
	i.Stato
FROM Studenti AS s
	INNER JOIN Iscrizioni AS i
	ON s.StudenteId = i.StudenteId;




-- Restituire la lista degli studenti scritti a un corso 
SELECT 
	CONCAT(s.Nome, ' ', s.Cognome) AS Studente,
	s.CodiceFiscale AS CF,
	s.Email,
	c.NomeCorso AS [Nome del corso],
	c.Descrizione,
	i.DataIscrizione AS [Data Iscrizione],
	i.Stato
FROM Studenti AS s
INNER JOIN Iscrizioni AS i
	ON s.StudenteId = i.StudenteId
INNER JOIN Corsi AS c
	ON c.CorsoId = i.CorsoId
WHERE i.Stato = 'Attiva' OR i.Stato = 'Sospesa'
	ORDER BY i.Stato ASC