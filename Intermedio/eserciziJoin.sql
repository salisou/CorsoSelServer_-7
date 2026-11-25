USE ScuolaDb;

-- ISNULL = NULL ('N/D')

/*
    ISNULL(colonna_numrica, 0) as nuovo_nome
    ISNULL(CONVERT(NVARCHAR, colonna_stringa), 'N/D') as nuovo_nome
    FORMAT(data_colonna, 'dd/MM/yyyy', 'it-IT')
    FORMAT(DataNascita, 'dd/MM/yyyy', 'it-IT') AS [Data Nascita], 100, 101, ....
*/

SELECT
    ISNULL(CONVERT(NVARCHAR, ClasseId), 'N/D') AS ClasseId,
    CONCAT(Nome, ' ' ,Cognome) AS [Nome Completo],
    ISNULL(CONVERT(NVARCHAR, DataNascita, 109), 'dd/MM/yyyy') AS [Data Nascita],
    ISNULL(CONVERT(NVARCHAR, Sesso), '') AS Sesso,
    ISNULL(CONVERT(NVARCHAR, CodiceFiscale), '') AS CF,
    ISNULL(CONVERT(NVARCHAR, Email), '') AS Email,
    ISNULL(CONVERT(NVARCHAR, Telefono), '') AS Telefono,
    ISNULL(CONVERT(NVARCHAR, Indirizzo), '') AS Indirizzo,
    ISNULL(CONVERT(NVARCHAR, Citta), '') AS Citta,
    CONCAT(
    ISNULL(CONVERT(NVARCHAR, MONTH(DataRegistrazione), 105), 'N/D'), '/' ,
    ISNULL(CONVERT(NVARCHAR, YEAR(DataRegistrazione), 103), 'N/D')) AS [Data Registrazione], 
    Attivo
FROM Studenti;


-- Modifica del cliente PIPPO 
SELECT TOP 5
    ISNULL(CONVERT(NVARCHAR, ClasseId), 'N/D') AS ClasseId,
    CONCAT(Nome, ' ' ,Cognome) AS [Nome Completo],
    ISNULL(CONVERT(NVARCHAR, DataNascita, 109), 'dd/MM/yyyy') AS [Data Nascita],
    ISNULL(CONVERT(NVARCHAR, CodiceFiscale), '') AS CF,
    CONCAT(
    ISNULL(CONVERT(NVARCHAR, MONTH(DataRegistrazione), 105), 'N/D'), '/' ,
    ISNULL(CONVERT(NVARCHAR, YEAR(DataRegistrazione), 103), 'N/D')) AS [Data Registrazione]
FROM Studenti
ORDER BY [Nome Completo] ASC;

-- Modifica 2 del direttore 
SELECT -- TOP 5
    ISNULL(CONVERT(NVARCHAR, ClasseId), 'N/D') AS ClasseId,
    CONCAT(Nome, ' ' ,Cognome) AS [Nome Completo],
    ISNULL(CONVERT(NVARCHAR, DataNascita, 109), 'dd/MM/yyyy') AS [Data Nascita],
    ISNULL(CONVERT(NVARCHAR, CodiceFiscale), '') AS CF,
    CONCAT(
    ISNULL(CONVERT(NVARCHAR, MONTH(DataRegistrazione), 105), 'N/D'), '/' ,
    ISNULL(CONVERT(NVARCHAR, YEAR(DataRegistrazione), 103), 'N/D')) AS [Data Registrazione]
FROM Studenti
WHERE Sesso = 'F'
ORDER BY [Nome Completo] ASC

-- Modifica 3
-- Modifica 2 del direttore 
SELECT -- TOP 5
    ISNULL(CONVERT(NVARCHAR, s.ClasseId), 'N/D') AS ClasseId,
    CONCAT(s.Nome, ' ' ,s.Cognome) AS [Nome Completo],
    ISNULL(CONVERT(NVARCHAR, s.DataNascita, 109), 'dd/MM/yyyy') AS [Data Nascita],
    ISNULL(CONVERT(NVARCHAR, s.CodiceFiscale), '') AS CF,
    CONCAT(
    ISNULL(CONVERT(NVARCHAR, MONTH(s.DataRegistrazione), 105), 'N/D'), '/' ,
    ISNULL(CONVERT(NVARCHAR, YEAR(s.DataRegistrazione), 103), 'N/D')) AS [Data Registrazione],
    ISNULL(CONVERT(NVARCHAR, i.DataIscrizione, 103), 'N/D') AS [Data Iscrizione],
    i.Stato
FROM Studenti AS s 
JOIN Iscrizioni AS i
    ON s.StudenteId = i.StudenteId
WHERE Sesso = 'F'
ORDER BY [Nome Completo] ASC;


-- Modifca 4
SELECT -- TOP 5
    ISNULL(CONVERT(NVARCHAR, s.ClasseId), 'N/D') AS ClasseId,
    ISNULL(CONVERT(NVARCHAR, c.NomeCorso), 'Nome non definito') AS [Nome Corso],
    ISNULL(CONVERT(NVARCHAR, c.Descrizione), 'Non Definita') AS Descrizione,
    ISNULL(CONVERT(NVARCHAR, c.Categoria), 'Non Definita') AS Categoria,
    ISNULL(CONVERT(NVARCHAR, c.Costo), 'Non Definita') AS Costo,
    CONCAT(s.Nome, ' ' ,s.Cognome) AS [Nome Completo],
    ISNULL(CONVERT(NVARCHAR, s.DataNascita, 109), 'dd/MM/yyyy') AS [Data Nascita],
    ISNULL(CONVERT(NVARCHAR, s.CodiceFiscale), '') AS CF,
    CONCAT(
    ISNULL(CONVERT(NVARCHAR, MONTH(s.DataRegistrazione), 105), 'N/D'), '/' ,
    ISNULL(CONVERT(NVARCHAR, YEAR(s.DataRegistrazione), 103), 'N/D')) AS [Data Registrazione],
    ISNULL(CONVERT(NVARCHAR, i.DataIscrizione, 103), 'N/D') AS [Data Iscrizione],
    i.Stato
FROM Studenti AS s 
JOIN Iscrizioni AS i
    ON s.StudenteId = i.StudenteId
JOIN Corsi AS c
    ON c.CorsoId = i.CorsoId
WHERE i.Stato = 'Attiva'
ORDER BY [Nome Completo] ASC;

--- LEFT JOIN 

/*
    SELECT
        colonne
    FROM Tabella1 as t1
    LEFT JOIN Tabella2 as t2
        ON t1.id = t2.id
*/

SELECT
    *
FROM Docenti as d
LEFT JOIN DocentiCorsi as dc
    ON d.DocenteId = dc.DocenteId


SELECT
    *
FROM Docenti as d
LEFT JOIN DocentiCorsi as dc
    ON d.DocenteId = dc.DocenteId
LEFT JOIN Corsi c
    ON dc.CorsoId = c.CorsoId


SELECT
    *
FROM Docenti as d
LEFT JOIN DocentiCorsi as dc
    ON d.DocenteId = dc.DocenteId
LEFT JOIN Corsi c
    ON dc.CorsoId = c.CorsoId
LEFT JOIN Lezioni l
    ON dc.CorsoId = l.CorsoId
LEFT JOIN Aule a
    ON a.AulaId = l.AulaId

    
select * from Iscrizioni;

select * from DocentiCorsi;
select * from Lezioni;
select * from Voti;
SELECT * FROM Corsi;
SELECT * FROM Classi;



-- STUDENTE, AnnoScolastico, DOCENTE, CORSO, Classe, AULA, LEZIONE, VOTO
SELECT 
    -- STUDENTE
    s.StudenteId,
    CONCAT(
        s.Nome, ' ', 
        s.Cognome, ' ', 
        s.CodiceFiscale, ' ',
        s.Email, ' ',
        s.Telefono) AS Studente,

    -- CLASSE
    ISNULL(cl.NomeClasse, 'Non assegnata') AS Classe,

    -- ANNO SCOLASTICO
    ISNULL(asx.NomeAnno, 'Non specificato') AS [Anno Scolastico],

    -- ISCRIZIONE
    ISNULL(CONVERT(NVARCHAR, i.IscrizioneId), 'N/D') AS [Iscrizione Id],
    ISNULL(CONVERT(NVARCHAR, i.DataIscrizione, 101), 'MM/dd/yyyy') AS [Data Iscrizione],
    ISNULL(i.Stato, 'Non specificato') AS [Stato Iscrizione],

    -- CORSO
    ISNULL(c.NomeCorso, 'Nessun corso') AS Corso,

    -- LEZIONE
    ISNULL(CONVERT(NVARCHAR, LezioneId), 'N/D') AS [Lezione Id],
    ISNULL(l.Titolo, 'Nessuna lezione') AS Lezione,
    ISNULL(CONVERT(NVARCHAR,l.DataLezione, 101), 'MM/dd/yyyy') AS [Data Lezione],
    ISNULL(CONVERT(NVARCHAR(8), l.OraInizio, 108),'N/D') AS [Ora Inizio],
    ISNULL(CONVERT(NVARCHAR(8), l.OraFine, 108),'N/D') AS [Ora Fine],

    -- DOCENTE
    ISNULL(CONCAT(d.Nome, ' ', d.Cognome), 'Non assegnato') AS [Docente],

    -- AULA
    ISNULL(a.NomeAula, 'Non assegnata') AS Aula,

    -- VOTO
    ISNULL(CONVERT(NVARCHAR(10), v.Voto), 'N/D') AS [Voto],
    ISNULL(CONVERT(NVARCHAR(10), v.DataVoto, 103), 'N/D') AS [Data Voto]
FROM Studenti AS s -- STUDENTI
LEFT JOIN Classi AS cl -- CLASSI
    ON s.ClasseId = cl.ClasseId
LEFT JOIN AnniScolastici AS asx -- ANNO SCOLASTICO
    ON cl.AnnoScolasticoId = asx.AnnoScolasticoId
LEFT JOIN Iscrizioni AS i -- ISCRIZIONI
    ON s.StudenteId = i.StudenteId
LEFT JOIN Corsi AS c -- CORSI
    ON i.CorsoId = c.CorsoId
LEFT JOIN Lezioni AS l -- LEZIONI
    ON c.CorsoId = l.CorsoId
LEFT JOIN Docenti AS d -- DOCENTI
    ON l.DocenteId = d.DocenteId
LEFT JOIN Aule AS a -- AULE
    ON l.AulaId = a.AulaId
LEFT JOIN Voti AS v -- VOTI
    ON i.IscrizioneId = v.IscrizioneId  
ORDER BY  s.Nome ASC;


SELECT
    fk.name AS NomeForeignKey,
    OBJECT_NAME(fk.parent_object_id) AS TabellaFiglia,
    OBJECT_NAME(fk.referenced_object_id) AS TabellaPadre
FROM sys.foreign_keys AS fk
ORDER BY TabellaFiglia;
GO
