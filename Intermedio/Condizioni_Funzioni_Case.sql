USE ScuolaDb;

select
	CONCAT(Nome, ' ', Cognome) AS [Nome Completo],
	UPPER(Cognome) as CognomeMaiuscolo,
	LOWER(Email) as EmailMinuscolo,
	LEN(Cognome) as LunghezzaCognome
from Studenti
where LEN(Cognome) != 7 and LEN(Cognome) <= 6

-- LEFT RIGHT e SUBSTRING parti di un testo
SELECT
	CodiceFiscale,
	LEFT(CodiceFiscale, 6) + ' ' + '*******' AS CF_Iniziale,
	CONCAT('*******', ' ', RIGHT(CodiceFiscale, 1)) AS CF_Finale,
	SUBSTRING(CodiceFiscale, 7, 2) AS AnnoNelCodice
FROM Studenti

select * from Studenti
-- COALESCE restituisce il primo valore non 'NULL' tra qualli passati
-- ISNULL è una funzione di T-SQL a due argumenti; COALESCE accta più valori.
SELECT
	ISNULL(Nome, 'Non definita') AS Nome,
	COALESCE(Email, Telefono, N'Nessu racapitolo disponibile') as Recapitolo
FROM Studenti;

-- CONVERT formatta una data per la visualizzazione; lo stile 104 è gg.mm.aaaa
SELECT
	Nome,
	CONVERT(NVARCHAR(10), DataNascita, 104) AS DataInFormatoItaliano
FROM Studenti
where DataNascita IS NOT NULL;


select * from Lezioni
-- DATEDIFF
SELECT
	CorsoId,
	DataLezione,
	OraInizio,
	OraFine,
	DATEDIFF(MINUTE, OraInizio, OraFine) AS DurataMiniti
FROM Lezioni;

/*
	CASE seplice: asssegna una cateria usando soglie non sovrapprostte

	Sintassi basi:
		SELECT
			colonne
			CASE
				WHEN condizione THEN 'VALORE DI DEFAULT'
				WHEN condizione THEN 'VALORE DI DEFAULT'
				ELSE 'valore di default'
			END
		FROM <TABELLA>
*/
SELECT
	NomeCorso,
	Crediti,
	CASE
		WHEN Crediti < 6 THEN 'Introduttivo'
		WHEN Crediti BETWEEN 6 AND 8 THEN 'Intermedio'
		ELSE 'Avanzato'
	END AS Livello
FROM Corsi



-- VERIFICA DEI VOTI
SELECT
	Voto,
	CASE
		WHEN Voto < 7 THEN 'Insuficente'
		WHEN Voto BETWEEN 7 AND 9 THEN 'Promosso'
		ELSE 'Ottimo promosso con lode'
	END AS Esito
FROM Voti
ORDER BY Voto ASC

-- Restituire la lista degli studenti con corsi, voti e l'esito
SELECT
	s.Nome + ' ' + s.Cognome AS Studente,
	c.NomeCorso AS [Nome del Corso],
	v.Voto,
	CASE
		WHEN v.Voto < 7 THEN 'Insuficente'
		WHEN v.Voto BETWEEN 7 AND 9 THEN 'Promosso'
		ELSE 'Ottimo promosso con lode'
	END AS Esito
FROM Studenti s
INNER JOIN Iscrizioni i
    ON i.StudenteId = s.StudenteId
INNER JOIN Corsi c
	ON c.CorsoId = i.CorsoId
INNER JOIN Voti v
	ON i.CorsoId = v.IscrizioneId
ORDER BY Voto ASC



-- IF, ELSE ed Exists
IF EXISTS(
	SELECT 1 
	FROM Corsi
)
BEGIN
	PRINT N'CIAOOOOOOOOOOOOOOOOOOOOOO CHRISTIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAN😅😅😅😅😅😅😅'
END;



IF EXISTS (
	SELECT 1
	FROM Corsi 
	WHERE Crediti >= 5
)
BEGIN 
	PRINT N'E'' DISPONIBILE UN CORSO DA 5 CREDITI O PIU'''
END
ELSE
BEGIN
	PRINT N'NON CI SONO CORSO DA 5 CREDITI O PIU'''
END

-----------------------------------------------------------------------------------------------

SELECT 
	CONCAT(Nome, ' ', Cognome) AS [Nome Completo],
	LOWER(Email) as EmailMinuscolo
FROM Studenti AS s
WHERE EXISTS(
	SELECT 1
	FROM Iscrizioni AS i
	WHERE i.StudenteId = s.StudenteId
)

----Esercizio: - Controllare se esistono studenti -----
IF EXISTS
(
    SELECT 1
    FROM Studenti
)
BEGIN
    PRINT 'Studenti presenti';
END
ELSE
BEGIN
    PRINT 'Nessuno studente registrato';
END