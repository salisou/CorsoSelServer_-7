--EXEC
--EXECUTE

-- Lista degli STudenti
EXEC sp_Elenco_Studenti;

-- Studente per Id 
EXECUTE sp_CercaStudentePerId 15;
EXEc sp_CercaStudentePerId @StudenteId = 15;
