/*
	Lezione 1 – Il comando SELECT

	1. Cos'è SELECT?
	SELECT è il comando SQL utilizzato per interrogare una
	o più tabelle e recuperare i dati che ci interessano.

	2. A cosa serve?
	Permette di:
		- visualizzare tutte le colonne di una tabella;
		- selezionare soltanto alcune colonne;
		- creare colonne calcolate;
		- assegnare nomi personalizzati alle colonne del risultato;
		- individuare valori distinti.

	3. Perché è importante per un Data Analyst?
	Un Data Analyst raramente ha bisogno di visualizzare un'intera tabella.
	Generalmente deve estrarre soltanto le informazioni utili per rispondere
	a una domanda aziendale.

	Per esempio:
		- Quanti studenti sono iscritti?
		- Quali corsi sono disponibili?
		- Quali studenti hanno un indirizzo email?
		- Quali sono i voti degli studenti?
		- Quanto costa ciascun corso?

	SELECT è quindi uno dei comandi fondamentali per costruire report e analisi.

	4. Sintassi di base
	SELECT
		Colonna1,
		Colonna2,
		Colonna3
		....
	FROM NomeTabella;


	- SELECT: indica quali colonne vogliamo visualizzare.
	- FROM: indica da quale tabella recuperare i dati.
	- ;: termina l'istruzione SQL.



	Obiettivi del modulo
		- Estrarre dati da una o più tabelle.
		- Selezionare soltanto le colonne necessarie.
		- Filtrare i dati in base a condizioni.
		- Ordinare e limitare i risultati => null.
		- Individuare valori mancanti e duplicati.
		- Preparare dataset per report e dashboard.
*/
USE ScuolaDb;


-- Esempio 1: Estrarre dati da una o più tabelle.
SELECT * FROM AnniScolastici;


-- Esempio2: Selezionare soltanto le colonne necessarie della tabella Studenti.
-- Nome, Cognome, Email, CodiceFiscale, Sesso
SELECT
	Nome,
	Cognome,
	Email,
	CodiceFiscale,
	Sesso
FROM Studenti;


-- WHERE: Filtra i dati a secondo le condizioni
-- Esempio 3: Filtrare i dati in base a condizioni usando (WHERE).
SELECT
	*
FROM Aule
WHERE AulaId = 7;

-- concatenazione: Permette di unire più stringhe usando il "+"
-- Esemipo 3.1 Restituire il nome completo dello studente con il codice fisca
SELECT
	Nome + ' - ' + Cognome,
	CodiceFiscale
FROM Studenti;

-- Aliass(AS): permette di definire un nome ad una colonna
SELECT
	Nome + ' - ' + Cognome as NomeCompleto,
	CodiceFiscale
FROM Studenti;


-- Esempio 2
SELECT
	Nome + ' - ' + Cognome as 'Nome Completo',
	CodiceFiscale
FROM Studenti;

-- Esempio 3
SELECT
	Nome + ' - ' + Cognome as [Nome Completo],
	CodiceFiscale AS [Codice Fiscale]
FROM Studenti;



-- Modifca della colonna Capacita => NULL
Alter table Aule
ALTER COLUMN Capacita INT NULL;

-- Modifica della colonna TipoAula => NULL
Alter table Aule
ALTER COLUMN TipoAula NVARCHAR(50) NULL;


-- Inserimento dei dati con valori null
INSERT INTO Aule
	(NomeAula, TipoAula, Capacita, Piano, Attiva)
VALUES
	('Aula 32', NULL, NULL, null, 0);


-- IS NULL e IS NOT NULL
SELECT *
FROM Aule
WHERE Piano IS NULL;


select * from Classi;

-- Inserimento della classe con valore null
select * from Docenti


INSERT INTO Classi
	(NomeClasse, AnnoScolasticoId, TutorDocenteId)
VALUES
	('2IT-Sezione 35', 12, 30);

SELECT *
FROM Classi
WHERE NomeClasse = '2IT-Sezione 35';



SELECT *
FROM Classi
WHERE ClasseId = 31;


-- TOP
-- Limitare il risultato della select a 5
SELECT TOP 5 *
FROM Studenti;

SELECT top 5 *
FROM Studenti
where Sesso = 'F';

SELECT top 3 *
FROM Studenti
where Sesso = 'M';


-- Ultimi righe 
SELECT *
FROM(
    SELECT TOP 5 * 
    FROM Studenti
    ORDER BY StudenteId DESC
) AS Ulitmi
ORDER BY StudenteId ASC



