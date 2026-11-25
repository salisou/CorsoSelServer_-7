USE ScuolaDb;

SELECT * FROM Studenti;
SELECT * FROM Corsi;
SELECT * FROM AnniScolastici;
SELECT * FROM Iscrizioni;

SELECT GETDATE();


SELECT * FROM Corsi WHERE NomeCorso = 'Java'

SELECT * from studenti where Nome = 'Christian';

USE [ScuolaDb]
GO

INSERT INTO [dbo].[Studenti]
           ([ClasseId]
           ,[Nome]
           ,[Cognome]
           ,[DataNascita]
           ,[Sesso]
           ,[CodiceFiscale]
           ,[Email]
           ,[Telefono]
           ,[Indirizzo]
           ,[Citta]
           ,[DataRegistrazione]
           ,[Attivo])
     VALUES
           (30
           ,'Christian'
           ,'Pegoraro'
           ,'1983-01-05'
           ,'M'
           ,'CRP83P562ICE123P'
           ,'c.TEST@gmail.com'
           ,'+393698521470'
           ,'via codigoro 85'
           ,'Treviso'
           ,GETDATE()
           ,1);
GO

select * from Studenti where Nome = 'Christian';


INSERT INTO Iscrizioni
	(StudenteId, CorsoId, DataIscrizione, AnnoScolasticoId)
VALUES
	(34, 4, GETDATE(), 30),
    (34, 3, GETDATE(), 30)


-- Iscrizione degli studente ad un corso
INSERT INTO Iscrizioni
	(StudenteId, CorsoId, DataIscrizione, AnnoScolasticoId)
VALUES
	(13, 2, GETDATE(), 30),
	(20, 5, GETDATE(), 30),
	(8, 3, GETDATE(), 30),
	(24, 4, GETDATE(), 30),
	(7, 1, GETDATE(), 30),
	(15, 2,GETDATE(), 30);

/*
	UPDTE: agguiona i dati a secondo le condizioni

	Sintassi base dell'update in SQL Server
	UPDATE <Tabella>
	SET colonna = nuovo volore
	WHERE condizione/i


	⚠️ATTENZIONE DA NON FARE MAI🙅👎
	UPDATE <Tabella>
	SET colonna = nuovo volore

	UPDATE <Tabella>
	SET CorsoId = 30
*/


UPDATE Iscrizioni
SET Stato = 'Completata'
WHERE CorsoId = 22;

-- Visualizzare la modifica fatta prima
SELECT *
FROM Iscrizioni
WHERE CorsoId = 22;

-- Modifica del corso 2 a 30
UPDATE Iscrizioni
SET CorsoId = 30
WHERE CorsoId = 2;


-- DELETE: Elimina un o più recordo a secondo le condizioni
/*
    Sintassi di base: 
        DELETE <Tabella>
        WHERE condizione = valore 
*/

select * from Studenti where StudenteId = 30


select 
    CONCAT(s.Nome, ' ', S.Cognome) AS [Nome Completo], 
    CONCAT(C.NomeCorso, ' ', c.Descrizione) Corso
from studenti s
join Iscrizioni i
    on i.StudenteId = s.StudenteId
join Corsi c 
    On c.CorsoId = i.CorsoId
Where s.StudenteId = 30


DELETE Studenti
WHERE StudenteId = 34;



update Iscrizioni
set StudenteId = 30
where StudenteId = 34