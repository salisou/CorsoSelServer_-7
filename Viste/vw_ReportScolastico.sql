USE ScuolaDb;
GO

CREATE OR ALTER VIEW vw_ReportGeneraleScuola
AS
SELECT
    -- Anni Scolastici
    COUNT(DISTINCT a.AnnoScolasticoId) AS [Tot Anni Scolastici],

    -- Aule
    COUNT(DISTINCT al.AulaId) AS [Tot Aule],
    MIN(al.Capacita) AS [Aula Min Capienza],
    MAX(al.Capacita) AS [Aula Max Capienza],

    -- Classi
    COUNT(DISTINCT cl.ClasseId) AS [Tot Classi],

    -- Corsi
    COUNT(DISTINCT c.CorsoId) AS [Tot Corsi],
    SUM(DISTINCT c.DurataOre) AS [Tot Ore],
    AVG(c.DurataOre) AS [Media Ore],
    MIN(c.DurataOre) AS [Min Ore],
    MAX(c.DurataOre) AS [Max Ore],

    SUM(DISTINCT c.Crediti) AS [Tot Crediti],
    AVG(c.Crediti) AS [Media Crediti],
    MIN(c.Crediti) AS [Credito Minimo],
    MAX(c.Crediti) AS [Credito Massimo],

    SUM(c.Costo) AS [Tot Costi],
    AVG(c.Costo) AS [Costo Medio],
    MIN(c.Costo) AS [Costo Minimo],
    MAX(c.Costo) AS [Costo Massimo],

    -- Docenti
    COUNT(DISTINCT d.DocenteId) AS [Tot Docenti],

    -- Docenti Corso
    COUNT(DISTINCT dc.DocenteCorsoId) AS [Tot Docenti-Corsi],

    -- Lezioni
    COUNT(DISTINCT l.LezioneId) AS [Tot Lezioni],

    -- Pagamenti
    COUNT(DISTINCT paga.PagamentoId) AS [Tot Pagamenti],

    SUM(paga.Importo) AS [Importo Totale Incassato],
    AVG(paga.Importo) AS [Pagamento Medio],

    -- Presenze
    COUNT(DISTINCT p.PresenzaId) AS [Tot Presenze],

    -- Studenti
    COUNT(DISTINCT s.StudenteId) AS [Tot Studenti],

    -- Voti
    COUNT(DISTINCT v.VotoId) AS [Tot Voti],
    AVG(v.Voto) AS [Media Voti],
    MIN(v.Voto) AS [Voto Minimo],
    MAX(v.Voto) AS [Voto Massimo]

FROM Studenti s
INNER JOIN Iscrizioni i
    ON s.StudenteId = i.StudenteId

INNER JOIN Pagamenti paga
    ON paga.IscrizioneId = i.IscrizioneId

INNER JOIN Corsi c
    ON c.CorsoId = i.CorsoId

INNER JOIN AnniScolastici a
    ON a.AnnoScolasticoId = i.AnnoScolasticoId

INNER JOIN Classi cl
    ON cl.ClasseId = s.ClasseId

INNER JOIN Presenze p
    ON p.StudenteId = s.StudenteId

INNER JOIN Lezioni l
    ON l.CorsoId = c.CorsoId

INNER JOIN Aule al
    ON al.AulaId = l.AulaId

INNER JOIN Docenti d
    ON d.DocenteId = l.DocenteId

INNER JOIN DocentiCorsi dc
    ON dc.DocenteId = d.DocenteId

INNER JOIN Voti v
    ON v.IscrizioneId = i.IscrizioneId;