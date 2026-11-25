-- CTE (Common Table Expression) With

;WITH IscrittiPerCorso AS
(
    SELECT CorsoId, COUNT(*) AS NumeroIscritti
    FROM Iscrizioni
    GROUP BY CorsoId
)
SELECT
    c.NomeCorso,
    COALESCE(x.NumeroIscritti, 0) AS NumeroIscritti
FROM Corsi AS c
LEFT JOIN IscrittiPerCorso AS x
    ON x.CorsoId = c.CorsoId
ORDER BY c.NomeCorso ASC, x.NumeroIscritti;