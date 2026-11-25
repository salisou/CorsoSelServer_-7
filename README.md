# Corso SQL Server

Materiale didattico ed esercizi per imparare SQL Server con esempi basati su un
database scolastico. Gli script usano T-SQL e sono pensati per essere eseguiti
in un ambiente di studio.

## Requisiti

- Un'istanza di Microsoft SQL Server, anche SQL Server LocalDB.
- SQL Server Management Studio (SSMS) o un client compatibile con SQL Server.

## Preparare il database del corso

1. Connettiti all'istanza SQL Server di sviluppo.
2. Apri ed esegui `Base/Creazione_Database.sql` per creare il database `ScuolaDb`
   e le relative tabelle.
3. Esegui `Base/Insert.sql` una sola volta sul database appena creato: inserisce
   i dati di esempio e presuppone tabelle vuote con gli `IDENTITY` iniziali.
4. Apri gli altri script per seguire gli argomenti o svolgere gli esercizi.

> **Attenzione:** `Base/Creazione_Database.sql` elimina e ricrea `ScuolaDb`.
> Usalo solo su un'istanza di sviluppo e verifica il database selezionato prima
> di eseguirlo. Non eseguire nuovamente `Base/Insert.sql` senza ricreare o
> svuotare correttamente i dati.

Gli script contengono istruzioni `GO`, supportate da SSMS e `sqlcmd`. Il file
`Comandi_SQLLocalDB_Prof_Moussa_v2.xlsx` raccoglie comandi di riferimento per
SQL Server LocalDB.

## Percorso del corso

### Base

| File | Argomenti |
| --- | --- |
| `Base/Creazione_Database.sql` | Creazione del database `ScuolaDb`, tabelle, chiavi e vincoli |
| `Base/Insert.sql` | Inserimento dei dati di esempio nelle tabelle scolastiche |
| `Base/Select.sql` | Interrogazioni con `SELECT`, colonne, filtri e ordinamento |
| `Base/Operatori.sql` | Operatori aritmetici e di confronto, condizioni e filtri |
| `Base/Esempio.sql` | Esempio semplice di inserimento di uno studente |
| `Base/Revizioni.sql` | Esercizi separati con il database `Azienda_db1` e le tabelle dipendenti/stipendi |

### Intermedio

| File | Argomenti |
| --- | --- |
| `Intermedio/CRUD.sql` | Operazioni di lettura, inserimento, modifica e cancellazione |
| `Intermedio/Condizioni_Funzioni_Case.sql` | Condizioni, funzioni per testo e date, valori `NULL` e `CASE` |
| `Intermedio/Join.sql` | Relazioni tra tabelle e `INNER JOIN` |
| `Intermedio/eserciziJoin.sql` | Esercizi con `JOIN`, `LEFT JOIN` e dati scolastici correlati |
| `Intermedio/Report.sql` | Funzioni aggregate, `GROUP BY` e `HAVING` |

Gli script intermedi fanno riferimento a `ScuolaDb`: esegui prima la
preparazione del database descritta sopra. `Base/Revizioni.sql` è un percorso
separato e crea `Azienda_db1`.
