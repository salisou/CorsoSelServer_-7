-- Gli Operatori di Aritmetici
-- +, -, *, /, %
SELECT
    10 + 20 Adizione,
    10 - 20 Sottrazione,
    10 * 20 Moltiplicazione,
    10 / 20 Divisione,
    10 % 20 Modulo;


-- Gli Operatori di Confronto
/*
    =       (Uguale a),
    <>/ !=  ( diverso da ),
    >       (Maggiore di) ,
    <       (Minore di),
    >=      (Maggiore Uguale a),
    <=      (Minore Uguale a)
*/

SELECT
    *
FROM Voti
WHERE Voto >= 6;

-- ORDER BY: Permette di ordinare le colonne
SELECT
    *
FROM Voti
WHERE Voto >= 6
ORDER BY Voto ASC;

-- Gli Operatori Logici
-- AND, OR, NOT
SELECT *
FROM Pagamenti
WHERE Importo >= 200 and Importo <= 300


SELECT *
FROM Pagamenti
WHERE Importo >= 200 OR Importo <= 300


SELECT *
FROM Classi
WHERE Descrizione IS NOT NULL
   AND NOT Descrizione = 'Classe formativa numero 22'

-- GLi operatori di assegonazione
-- =, +=, -=, *=, /=, %=
-- Esempio 1: Assegnazione di un valore ad una variabile
DECLARE @Importo1 DECIMAL(10,2);
DECLARE @Importo2 DECIMAL(10,2);

DECLARE @SOMMA DECIMAL(10,2);

-- somma dell'importo 1 e importo 2
SET @Importo1 = 100.00;
SET @Importo2 = 200.00;

SET @SOMMA = @Importo1 + @Importo2;

PRINT 'La somma dei due importi è: ' + CAST(@SOMMA AS NVARCHAR(10));



-- Gli operatori Speciali in SQl
-- IS NULL, IS NOT NULL, BETWEEN, IN(), LIKE, EXISTS
SELECT *
FROM Pagamenti
WHERE Importo BETWEEN 200 AND 300


SELECT *
FROM Classi
where Descrizione is not null
    and Descrizione <> 'Classe formativa numero 16'
    and Descrizione != 'Classe formativa numero 10';



-- Cercare i pagamenti effetuati in un periodo (2026 e 2026-12-31)
SELECT
    *
FROM Pagamenti
WHERE DataPagamento BETWEEN '2026-01-01'
    AND '2026-12-31';


SELECT
    *
FROM Pagamenti
WHERE DataPagamento BETWEEN '2026-01-01'
    AND '2026-12-31'
    AND MetodoPagamento = 'Carta';


SELECT
    *
FROM Pagamenti
WHERE DataPagamento BETWEEN '2026-01-01'
    AND '2026-12-31'
    AND MetodoPagamento = 'Carta'
    AND Stato = 'In attesa';


/*
    IN()
        Permette di verificare
        se un valore appartiene a un elenco
        di valori speficicati

    Serve a evitare molte condizione 'OR'
*/
SELECT *
FROM Docenti
WHERE DocenteId = 1 OR DocenteId = 5 OR DocenteId = 15 OR DocenteId = 17;

SELECT *
FROM Docenti
WHERE DocenteId IN(1, 5, 15, 17);


-- Restituire la lista dei voti escludendo i voti con gli id 14, 5, 16, 30
SELECT *
FROM Voti
WHERE VotoId NOT IN (14, 5, 16, 30);


-- Restituire 5 clssi
SELECT *
FROM Classi
WHERE ClasseId IN(7, 10, 28, 31, 17);



/*
    Like: permette di cercare un modello di testo 
        all'interno di una colonna.


    Serve:
        è particolarmente utile quando non conosciamo
        un valore completo che stiamo cercando.

    'a%' => restituisce tutti i valori che comminciano con la lettera 'a'
    '%i' => restituisce tutti i valori che finisce con la lettera 'i'
    '%i%'  => restituisce tutti i valori che hanno una lettera 'i' all'interno
*/
-- Esempio 1
SELECT *
FROM Studenti
WHERE Nome LIKE 'M%';


select * 
from Iscrizioni
where DataIscrizione like '%3'

-- Esempio 2
SELECT *
FROM Studenti
WHERE Nome LIKE 'M%' AND Cognome LIKE '%I';

-- Esempio 3
SELECT *
FROM Studenti
WHERE Nome LIKE '%M_s%'

/*
    EXISTS: Verifica l'esistenza di un record 
*/

-- Esempio 1 Studenti che hanno almeno un'iscrizione
SELECT 
    CONCAT(s.Nome, ' ', s.Cognome) AS [Studente],
    s.CodiceFiscale AS CF
FROM Studenti AS s 
WHERE EXISTS (
    SELECT 1
    FROM Iscrizioni AS i
    WHERE s.StudenteId = i.StudenteId
)

-- Vogliamo individuare i corsi che hanno almeno uno studente scritto
SELECT 
    c.CorsoId,
    c.NomeCorso
FROM Corsi AS c
WHERE EXISTS(
    SELECT 1
    FROM Iscrizioni AS i
    WHERE i.CorsoId = c.CorsoId
);

