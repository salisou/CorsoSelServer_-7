-- Una vista è una tabella virtuale.
-- Non contiene dei propri ma memorizza una query.

-- Esempio VIEW
USE ScuolaDb;
GO


-- Documentare sempre le funzioni
CREATE OR ALTER VIEW vw_ListaStudenti
AS
	SELECT * 
	FROM Studenti;
