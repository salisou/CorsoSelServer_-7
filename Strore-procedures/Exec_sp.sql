--EXEC
--EXECUTE

-- Lista degli Studenti
EXEC sp_Elenco_Studenti;

-- Restituisce lo Studente in base all'Id 
EXECUTE sp_CercaStudentePerId 1;
EXEC sp_CercaStudentePerId @StudenteId = 30;

-- Restituisce lo studente in base al Nome
EXEC sp_CercaStudentePerNome 'Fra';

------------------------------ Update Studente per Nome e Cognome -------------------------------------------------------------------
-- Modifica il "Nome, Cognome" dello studente in base all'Id e fa il conteggio delle erighe 
DECLARE @Righe INT;

EXEC sp_AggiornaStudente @StudenteId = 1,
						 @Nome = 'Moussa',
						 @Cognome = 'Salisou',
						 @RigheModificate = @Righe OUTPUT;

SELECT @Righe AS RigheModificate;
-------------------------------------------------------------------------------------------------


-- Restituisce le prime righe 
EXEC sp_VisualizzaPrimeRigheStudenti 2;


EXEC sp_VisualizzaUltimeRigheStudenti 3, 'U';