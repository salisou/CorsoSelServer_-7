-- Funzioni di aggreazione
/*
	COUNT()		-> Conta i cord
	SUM()		-> Calcola le somma
	AVG()		-> Calcola la media
	MIN()		-> individua il volore minimo
	MAX()		-> individua il volore massimo
	GROUP BY	-> Ragruppa i dati
	HAVING		-> Filta i gruppi
*/
USE ScuolaDb;

-- Restuire il numero totale degli studenti
SELECT
	COUNT(*) AS [Totale Studenti]
FROM Studenti;


-- Restituire la media dei voti
SELECT
	CONVERT( DECIMAL(10, 2), AVG(Voto)) AS [Media dei voti]
FROM Voti;


-- Restituire l'importo totale dei pagamenti
SELECT
	SUM(Importo) as [totale Importo]
FROM Pagamenti;

-- Restituire il voto minimo e massimo
SELECT
	MIN(Voto) as [Voto Minimo],
	MAX(Voto) as [Voto Massimo]
FROM Voti;

-- Restituire il totale degli studenti scritti ad un corso,
-- con nome, cognome data Iscrizione
-- having e groupn by
SELECT
	COUNT(s.StudenteId) AS [Totale Studenti],
	s.Nome,
	s.Cognome,
	i.DataIscrizione
FROM Studenti s
INNER JOIN Iscrizioni i
	ON s.StudenteId = i.StudenteId
INNER JOIN Corsi c
	ON c.CorsoId = i.CorsoId
GROUP BY s.Nome, s.Cognome, i.DataIscrizione


-- Visualizzare solo i corsi con almeno 2 studenti (Nome del corso, Nome completo)
SELECT
	--s.Nome + ' ' + s.Cognome AS [Nome completo],
	c.NomeCorso AS [Nome del corso],
	COUNT(i.StudenteId) AS [Totale Studenti]
FROM Corsi c 
INNER JOIN Iscrizioni i
	ON i.CorsoId = c.CorsoId
--INNER JOIN Studenti s
--	ON s.StudenteId = i.StudenteId
GROUP BY   c.NomeCorso -- s.Nome, s.Cognome,
HAVING COUNT(i.StudenteId) >= 2;


-- Restituisce gli studenti che appartengono ai corsi con almeno 2 iscritti
SELECT
	s.Nome + ' ' + s.Cognome AS [Nome completo],
	c.NomeCorso AS [Nome del corso]
	--COUNT(i.StudenteId) AS [Totale Studenti]
FROM Studenti s
INNER JOIN Iscrizioni i
	ON s.StudenteId = i.StudenteId
INNER JOIN  Corsi c
	ON i.CorsoId = c.CorsoId
WHERE c.CorsoId IN (
	SELECT
		CorsoId
	FROM Iscrizioni
	GROUP BY CorsoId
	HAVING COUNT(*) >= 2
);


SELECT DISTINCT
	c.NomeCorso
FROM Corsi c
INNER JOIN Iscrizioni i
   ON i.CorsoId = c.CorsoId


SELECT Distinct
	nome + ' ' + Cognome AS NomeCompleto
FROM Studenti s
INNER JOIN Iscrizioni i
    ON i.StudenteId = s.StudenteId

SELECT * FROM Pagamenti

SELECT *
FROM Studenti s
INNER JOIN Iscrizioni AS i
	ON s.StudenteId = i.StudenteId
INNER JOIN Pagamenti AS paga 
	ON paga.IscrizioneId = i.IscrizioneId
INNER JOIN Corsi AS c
	ON c.CorsoId = i.CorsoId
INNER JOIN AnniScolastici AS a
	ON a.AnnoScolasticoId = i.AnnoScolasticoId
INNER JOIN Classi AS cl
	ON cl.ClasseId = s.ClasseId
INNER JOIN Presenze AS p
	ON p.StudenteId = s.StudenteId
INNER JOIN Lezioni AS l
	ON l.CorsoId = c.CorsoId
INNER JOIN Aule AS al
	ON al.AulaId = l.AulaId
INNER JOIN Docenti AS d
	ON d.DocenteId = l.DocenteId
INNER JOIN DocentiCorsi AS dc
	ON dc.DocenteId = d.DocenteId
INNER JOIN Voti AS v
	ON v.IscrizioneId = i.IscrizioneId 
