/*
	Attenzione: esegui lo script su un database appena creato,
	con le tabelle vuote e gli IDENTITY che partono da 1.
	Non eseguirlo una seconda volta senza prima svuotare i dati.
*/

-- 1. Preparazione dei dati
USE ScuolaDb;
GO

-- ============================================================
-- CREAZIONE DI UNA TABELLA TEMPORANEA CON I NUMERI DA 1 A 30
-- Serve per generare i 30 record senza ripetere continuamente
-- la stessa lista di numeri.
-- ============================================================

CREATE TABLE #Numeri
(
    Numero INT PRIMARY KEY
);

INSERT INTO #Numeri (Numero)
VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),
(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),
(21),(22),(23),(24),(25),(26),(27),(28),(29),(30);

SELECT * FROM #Numeri;
-- ============================================================
-- NOMI E COGNOMI DI ESEMPIO
-- ============================================================



CREATE TABLE #Anagrafica
(
    Numero INT PRIMARY KEY,
    Nome VARCHAR(50),
    Cognome VARCHAR(50)
);

INSERT INTO #Anagrafica (Numero, Nome, Cognome)
VALUES
(1, 'Luca', 'Rossi'),
(2, 'Marco', 'Bianchi'),
(3, 'Giulia', 'Verdi'),
(4, 'Sara', 'Ferrari'),
(5, 'Matteo', 'Romano'),
(6, 'Anna', 'Colombo'),
(7, 'Paolo', 'Ricci'),
(8, 'Sofia', 'Marino'),
(9, 'Andrea', 'Greco'),
(10, 'Elena', 'Bruno'),
(11, 'Davide', 'Gallo'),
(12, 'Chiara', 'Conti'),
(13, 'Francesco', 'De Luca'),
(14, 'Martina', 'Costa'),
(15, 'Alessandro', 'Giordano'),
(16, 'Federica', 'Mancini'),
(17, 'Simone', 'Rizzo'),
(18, 'Valentina', 'Lombardi'),
(19, 'Stefano', 'Moretti'),
(20, 'Laura', 'Barbieri'),
(21, 'Antonio', 'Fontana'),
(22, 'Marta', 'Santoro'),
(23, 'Roberto', 'Mariani'),
(24, 'Alice', 'Rinaldi'),
(25, 'Gabriele', 'Caruso'),
(26, 'Francesca', 'Ferrara'),
(27, 'Nicola', 'Galli'),
(28, 'Ilaria', 'Martini'),
(29, 'Enrico', 'Leone'),
(30, 'Beatrice', 'Longo');
GO


SELECT * FROM #Anagrafica;

-- 2. Tabella AnniScolastici
-- Inseriamo 30 anni scolastici, dal 1997/1998 al 2026/2027.

-- ============================================================
-- INSERT INTO ANNI SCOLASTICI
-- ============================================================


INSERT INTO AnniScolastici
(
    NomeAnno,
    DataInizio,
    DataFine,
    Attivo
)
SELECT
    CONCAT(1996 + Numero, '/', 1997 + Numero),
    DATEFROMPARTS(1996 + Numero, 9, 1),
    DATEFROMPARTS(1997 + Numero, 6, 30),
    CASE
        WHEN Numero = 30 THEN 1
        ELSE 0
    END
FROM #Numeri;
GO

SELECT * FROM AnniScolastici;

/*
    3. Tabella Docenti
    Inseriamo 30 docenti con nome, cognome, email, codice fiscale e specializzazione.
*/
-- ============================================================
-- INSERT INTO DOCENTI
-- ============================================================



INSERT INTO Docenti
(
    Nome,
    Cognome,
    DataNascita,
    Email,
    Telefono,
    CodiceFiscale,
    Specializzazione,
    DataAssunzione,
    Attivo
)
SELECT
    Nome,
    Cognome,
    DATEADD(YEAR, -35 - Numero, CAST('2026-01-01' AS DATE)),
    CONCAT(LOWER(Nome), '.', LOWER(Cognome), '@scuoladb.it'),
    CONCAT('333', RIGHT('0000000' + CAST(Numero AS VARCHAR(7)), 7)),
    CONCAT(
        'DOC',
        RIGHT('0000000000000' + CAST(Numero AS VARCHAR(13)), 13)
    ),
    CASE Numero % 5
        WHEN 0 THEN 'Informatica'
        WHEN 1 THEN 'Matematica'
        WHEN 2 THEN 'Lingue'
        WHEN 3 THEN 'Economia'
        ELSE 'Scienze'
    END,
    DATEADD(YEAR, -Numero, CAST('2026-01-01' AS DATE)),
    1
FROM #Anagrafica;
GO

SELECT * FROM Docenti;

-- 4. Tabella Aule
-- ============================================================
-- INSERT INTO AULE
-- ============================================================

INSERT INTO Aule
(
    NomeAula,
    TipoAula,
    Capacita,
    Piano,
    Attiva
)
SELECT
    CONCAT('Aula ', FORMAT(Numero, '00')),
    CASE Numero % 3
        WHEN 0 THEN 'Laboratorio'
        WHEN 1 THEN 'Informatica'
        ELSE 'Aula Teorica'
    END,

    15 + Numero,

    CASE
        WHEN Numero <= 10 THEN 0
        WHEN Numero <= 20 THEN 1
        ELSE 2
    END,
    1
FROM #Numeri;
GO

SELECT * FROM Aule;

SELECT * FROM #Numeri;

/*
    5. Tabella Classi
    Ogni classe è associata a un anno scolastico e a un docente tutor.
*/
-- ============================================================
-- INSERT INTO CLASSI
-- ============================================================
INSERT INTO Classi
(
    NomeClasse,
    AnnoScolasticoId,
    TutorDocenteId,
    Descrizione
)
SELECT
    CONCAT(
        CASE Numero % 5
            WHEN 0 THEN '1A'
            WHEN 1 THEN '2A'
            WHEN 2 THEN '3A'
            WHEN 3 THEN '4A'
            ELSE '5A'
        END,
        ' - Sezione ',
        Numero
    ),
    Numero,
    Numero,
    CONCAT('Classe formativa numero ', Numero)
FROM #Numeri;
GO


SELECT * FROM Classi;

/*
    6. Tabella Studenti
    Ogni studente viene associato a una classe.
*/
-- ============================================================
-- INSERT INTO STUDENTI
-- ============================================================


INSERT INTO Studenti
(
    ClasseId,
    Nome,
    Cognome,
    DataNascita,
    Sesso,
    CodiceFiscale,
    Email,
    Telefono,
    Indirizzo,
    Citta
)
SELECT
    Numero,
    Nome,
    Cognome,
    DATEADD(YEAR, -(16 + Numero % 5), CAST('2026-01-01' AS DATE)),
    CASE
        WHEN Numero % 2 = 0 THEN 'F'
        ELSE 'M'
    END,
    CONCAT(
        'MSS',
        RIGHT('0000000000000' + CAST(Numero AS VARCHAR(13)), 13)
    ),
    CONCAT(
        LOWER(Nome),
        '.',
        LOWER(Cognome),
        '@studenti.it'
    ),
    CONCAT('320', RIGHT('0000000' + CAST(Numero AS VARCHAR(7)), 7)),
    CONCAT('Via Roma ', Numero),
    CASE Numero % 5
        WHEN 0 THEN 'Bologna'
        WHEN 1 THEN 'Ferrara'
        WHEN 2 THEN 'Modena'
        WHEN 3 THEN 'Parma'
        ELSE 'Ravenna'
    END
FROM #Anagrafica;
GO

SELECT * FROM Studenti;


-- 7. Tabella Corsi
-- ============================================================
-- INSERT INTO CORSI
-- ============================================================


INSERT INTO Corsi
(
    NomeCorso,
    Descrizione,
    Categoria,
    DurataOre,
    Crediti,
    Costo,
    Attivo
)
SELECT
    CASE Numero
        WHEN 1 THEN 'Programmazione C#'
        WHEN 2 THEN 'SQL Server'
        WHEN 3 THEN 'Python'
        WHEN 4 THEN 'Java'
        WHEN 5 THEN 'HTML e CSS'
        WHEN 6 THEN 'JavaScript'
        WHEN 7 THEN 'ASP.NET Core'
        WHEN 8 THEN 'Blazor'
        WHEN 9 THEN 'PHP'
        WHEN 10 THEN 'Laravel'
        WHEN 11 THEN 'Database Design'
        WHEN 12 THEN 'Data Analysis'
        WHEN 13 THEN 'Power BI'
        WHEN 14 THEN 'Excel Avanzato'
        WHEN 15 THEN 'Linux'
        WHEN 16 THEN 'Cyber Security'
        WHEN 17 THEN 'Networking'
        WHEN 18 THEN 'Git e GitHub'
        WHEN 19 THEN 'Windows Server'
        WHEN 20 THEN 'Cloud Computing'
        WHEN 21 THEN 'React'
        WHEN 22 THEN 'Angular'
        WHEN 23 THEN 'Node.js'
        WHEN 24 THEN 'Django'
        WHEN 25 THEN 'Flask'
        WHEN 26 THEN 'Machine Learning'
        WHEN 27 THEN 'Intelligenza Artificiale'
        WHEN 28 THEN 'Sviluppo Mobile'
        WHEN 29 THEN 'Docker'
        ELSE 'DevOps'
    END,
    CONCAT('Corso professionale di formazione numero ', Numero),
    CASE Numero % 4
        WHEN 0 THEN 'Sviluppo Software'
        WHEN 1 THEN 'Database'
        WHEN 2 THEN 'Sicurezza Informatica'
        ELSE 'Data Analysis'
    END,
    20 + (Numero * 2),
    2 + Numero % 5,
    150 + (Numero * 10),
    1
FROM #Numeri;
GO

SELECT * FROM Corsi;


-- 8. Tabella Iscrizioni
-- Questa tabella collega gli studenti ai corsi e agli anni scolastici.
-- ============================================================
-- INSERT INTO ISCRIZIONI
-- ============================================================


INSERT INTO Iscrizioni
(
    StudenteId,
    CorsoId,
    AnnoScolasticoId,
    DataIscrizione,
    Stato
)
SELECT
    Numero,
    Numero,
    Numero,
    DATEADD(DAY, Numero, CAST('2026-01-01' AS DATE)),
    CASE Numero % 4
        WHEN 0 THEN 'Completata'
        WHEN 1 THEN 'Attiva'
        WHEN 2 THEN 'Sospesa'
        ELSE 'Ritirata'
    END
FROM #Numeri;
GO

SELECT * FROM Iscrizioni;

-- 9. Tabella DocentiCorsi
-- Questa tabella rappresenta la relazione molti-a-molti tra docenti e corsi.
-- ============================================================
-- INSERT INTO DOCENTICORSI
-- ============================================================


INSERT INTO DocentiCorsi
(
    DocenteId,
    CorsoId,
    DataAssegnazione,
    Ruolo
)
SELECT
    Numero,
    Numero,
    DATEADD(DAY, Numero, CAST('2026-01-01' AS DATE)),
    CASE Numero % 3
        WHEN 0 THEN 'Responsabile'
        WHEN 1 THEN 'Docente'
        ELSE 'Collaboratore'
    END
FROM #Numeri;
GO

select * from DocentiCorsi

/*
    10. Tabella Lezioni
    Ogni lezione è associata a un corso, a un docente e a un'aula.

    La colonna Durata è calcolata automaticamente perché è una colonna calcolata
    nella definizione della tabella. Non dobbiamo inserirla manualmente.
*/
-- ============================================================
-- INSERT INTO LEZIONI
-- ============================================================

select * from Lezioni;

-- ============================================================
-- INSERIMENTO LEZIONI
-- Associazione agli ID realmente presenti nelle tabelle
-- ============================================================

-------------------------------------🔎🔎🔎🔎🔎🔎🔎🔎🔎🔎-----------------------------------------------------

;WITH ElencoCorsi AS
(
    SELECT
        CorsoId,
        ROW_NUMBER() OVER (ORDER BY CorsoId) AS Numero
    FROM Corsi
),
ElencoDocenti AS
(
    SELECT
        DocenteId,
        ROW_NUMBER() OVER (ORDER BY DocenteId) AS Numero
    FROM Docenti
),
ElencoAule AS
(
    SELECT
        AulaId,
        ROW_NUMBER() OVER (ORDER BY AulaId) AS Numero
    FROM Aule
)
INSERT INTO Lezioni
(
    CorsoId,
    DocenteId,
    AulaId,
    Titolo,
    Descrizione,
    DataLezione,
    OraInizio,
    OraFine
)
SELECT
    c.CorsoId,
    d.DocenteId,
    a.AulaId,
    CONCAT('Lezione ', n.Numero),
    CONCAT('Lezione pratica del corso ', c.CorsoId),
    DATEADD(DAY, n.Numero, CAST('2026-02-01' AS DATE)),
    '09:00',
    '13:00'
FROM #Numeri n
INNER JOIN ElencoCorsi c
    ON c.Numero = n.Numero
INNER JOIN ElencoDocenti d
    ON d.Numero = n.Numero
INNER JOIN ElencoAule a
    ON a.Numero = n.Numero;
GO
-------------------------------------🔎🔎🔎🔎🔎🔎🔎🔎🔎🔎-----------------------------------------------------

/*
    11. Tabella Voti
    Ogni voto è collegato a un'iscrizione tramite IscrizioneId.

    Anche Superato è una colonna calcolata:
        SQL Server determina automaticamente se il voto è sufficiente.
*/
-- ============================================================
-- INSERT INTO VOTI
-- ============================================================
INSERT INTO Voti
(
    IscrizioneId,
    Voto,
    DataVoto,
    Tipologia,
    Descrizione
)
SELECT
    Numero,
    CAST(5 + (Numero % 6) AS DECIMAL(4,2)),
    DATEADD(DAY, Numero, CAST('2026-03-01' AS DATE)),
    CASE Numero % 3
        WHEN 0 THEN 'Scritto'
        WHEN 1 THEN 'Orale'
        ELSE 'Pratico'
    END,
    CONCAT('Verifica numero ', Numero)
FROM #Numeri;
GO


SELECT * FROM Voti;
/*
    12. Tabella Presenze
    Questa tabella registra la presenza degli studenti alle lezioni.

    La coppia StudenteId e LezioneId deve essere unica, secondo il vincolo definito nella tabella.
*/
-- ============================================================
-- INSERT INTO PRESENZE
-- ============================================================



;WITH CoppiePresenze AS
(
    SELECT DISTINCT
        i.StudenteId,
        l.LezioneId
    FROM Iscrizioni AS i

    INNER JOIN Studenti AS s
        ON i.StudenteId = s.StudenteId

    INNER JOIN Lezioni AS l
        ON i.CorsoId = l.CorsoId
),
PresenzeNumerate AS
(
    SELECT
        StudenteId,
        LezioneId,
        ROW_NUMBER() OVER (
            ORDER BY StudenteId, LezioneId 
        ) AS Numero
    FROM CoppiePresenze
)
INSERT INTO Presenze
(
    StudenteId,
    LezioneId,
    Stato,
    OraRegistrazione,
    Note
)
SELECT
    p.StudenteId,
    p.LezioneId,

    CASE p.Numero % 4
        WHEN 0 THEN 'Presente'
        WHEN 1 THEN 'Assente'
        WHEN 2 THEN 'Ritardo'
        ELSE 'Giustificato'
    END,

    CAST('09:00' AS TIME),

    CONCAT(
        'Registrazione presenza dello studente ',
        p.StudenteId,
        ' alla lezione ',
        p.LezioneId
    )

FROM PresenzeNumerate AS p

-- Evitiamo di inserire due volte la stessa presenza
WHERE NOT EXISTS
(
    SELECT 1
    FROM Presenze AS esistente
    WHERE esistente.StudenteId = p.StudenteId
      AND esistente.LezioneId = p.LezioneId
);
GO

SELECT * FROM Presenze;
SELECT * FROM Lezioni;

------------------------------------------------------------------

-- 13. Tabella Pagamenti
-- Ogni pagamento è collegato a un'iscrizione.
-- ============================================================
-- INSERT INTO PAGAMENTI
-- ============================================================
INSERT INTO Pagamenti
(
    IscrizioneId,
    Importo,
    DataPagamento,
    MetodoPagamento,
    Stato,
    NumeroTransazione,
    Note
)
SELECT
    Numero,
    CAST(150 + (Numero * 10) AS DECIMAL(10,2)),
    DATEADD(DAY, Numero, CAST('2026-01-01' AS DATETIME2)),
    CASE Numero % 4
        WHEN 0 THEN 'Carta'
        WHEN 1 THEN 'Bonifico'
        WHEN 2 THEN 'Contanti'
        ELSE 'PayPal'
    END,
    CASE
        WHEN Numero % 3 = 0 THEN 'In attesa'
        ELSE 'Pagato'
    END,
    CONCAT('TRX2026', RIGHT('000' + CAST(Numero AS VARCHAR(3)), 3)),
    CONCAT('Pagamento iscrizione numero ', Numero)
FROM #Numeri;
GO

SELECT * FROM Pagamenti;

-- 14. Verifica dei record inseriti
-- Adesso controlliamo che ogni tabella contenga 30 record.
-- ============================================================
-- VERIFICA DEL NUMERO DI RECORD PER OGNI TABELLA
-- ============================================================

SELECT 'AnniScolastici' AS Tabella, COUNT(*) AS TotaleRecord
FROM AnniScolastici

UNION ALL

SELECT 'Docenti', COUNT(*)
FROM Docenti

UNION ALL

SELECT 'Aule', COUNT(*)
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
